import 'dart:convert';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:absensi/data/datasources/auth_remote_datasource.dart';
import 'package:absensi/data/model/request/auth/login_request_model.dart';
import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Penyimpanan palsu di memori (tanpa Keystore Android)
class FakeLocal extends AuthLocalDatsource {
  AuthResponseModel? saved;
  String? raw;

  @override
  Future<void> saveAuthData(AuthResponseModel data) async {
    saved = data;
    raw = data.toJson();
  }

  @override
  Future<AuthResponseModel?> getAuthData() async => saved;

  @override
  Future<void> removeAuthData() async {
    saved = null;
    raw = null;
  }
}

const adminUser = AuthUserModel(
  id: 1,
  name: 'Admin Sekolah',
  email: 'admin@contoh.test',
  role: 'admin',
);

final loginBody = {
  'success': true,
  'token': '1|abc',
  'user': adminUser.toMap()
};

http.Response reply(int status, Map<String, dynamic> body) => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

Future<http.Response> routes(http.Request req) async {
  switch (req.url.path) {
    case '/api/login':
      return reply(200, loginBody);
    case '/api/me':
      return reply(200, {'success': true, 'user': adminUser.toMap()});
    case '/api/logout':
      return reply(200, {'success': true});
    case '/api/attendances':
      return reply(401, {'message': 'Unauthenticated.'});
  }
  return reply(404, {});
}

final rigs = <Rig>[];

class Rig {
  Rig(Future<http.Response> Function(http.Request) handler) {
    final client = MockClient((req) async {
      calls.add(req);
      return handler(req);
    });
    api = ApiHelper(local: local, client: client);
    bloc = AuthBloc(AuthRemoteDatasource(api: api), local);
    rigs.add(this);
  }

  final calls = <http.Request>[];
  final local = FakeLocal();
  late final ApiHelper api;
  late final AuthBloc bloc;
}

Future<List<AuthState>> collect(AuthBloc bloc, AuthEvent event, int count) {
  final future = bloc.stream.take(count).toList();
  bloc.add(event);
  return future.timeout(const Duration(seconds: 5));
}

String? msg(AuthState s) =>
    s.maybeWhen(unauthenticated: (m) => m, orElse: () => null);

AuthEvent loginEvent([String email = 'admin@contoh.test']) =>
    AuthEvent.login(LoginRequestModel(email: email, password: 'rahasia'));

void main() {
  tearDown(() async {
    for (final r in rigs) {
      await r.bloc.close();
    }
    rigs.clear();
  });

  group('model', () {
    test('LoginRequestModel membersihkan spasi di email', () {
      final json = jsonDecode(
        LoginRequestModel(email: '  a@b.c ', password: 'x').toJson(),
      );
      expect(json['email'], 'a@b.c');
      expect(json['password'], 'x');
    });

    test('AuthResponseModel menolak jawaban tanpa token', () {
      expect(
        () => AuthResponseModel.fromJson(
          jsonEncode({'success': true, 'user': adminUser.toMap()}),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('AuthResponseModel menolak data user yang rusak', () {
      expect(
        () => AuthResponseModel.fromJson(
          '{"success":true,"token":"1|a","user":{"id":1,"name":"A"}}',
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('login', () {
    test('berhasil: masuk, token tersimpan, password tidak disimpan', () async {
      final t = Rig(routes);

      final states =
          await collect(t.bloc, loginEvent('  admin@contoh.test '), 2);

      expect(states[0], const AuthState.loading());
      expect(states[1], const AuthState.authenticated(adminUser));
      expect(t.local.saved!.token, '1|abc');
      expect(t.local.raw, isNot(contains('rahasia')));

      final req = t.calls.single;
      expect(req.url.path, '/api/login');
      expect(req.headers['Accept'], 'application/json');
      expect(req.headers.containsKey('Authorization'), isFalse);
      expect(jsonDecode(req.body)['email'], 'admin@contoh.test');
    });

    test('password salah: pesan dari server, tidak masuk', () async {
      final t = Rig((req) async => reply(401, {
            'success': false,
            'code': 'INVALID_CREDENTIALS',
            'message': 'Email atau password salah',
          }));

      final states = await collect(t.bloc, loginEvent(), 2);

      expect(
        states[1],
        const AuthState.unauthenticated(message: 'Email atau password salah'),
      );
      expect(t.local.saved, isNull);
    });

    test('jaringan putus: pesan jelas', () async {
      final t = Rig((req) async => throw http.ClientException('putus'));

      final states = await collect(t.bloc, loginEvent(), 2);

      expect(msg(states[1]), ApiHelper.networkError);
      expect(t.local.saved, isNull);
    });

    test('error server 500: pesan umum, detail server tidak ditampilkan',
        () async {
      final t = Rig(
        (req) async => reply(500, {'message': 'SQLSTATE[42S02] rahasia'}),
      );

      final states = await collect(t.bloc, loginEvent(), 2);

      expect(msg(states[1]), contains('500'));
      expect(msg(states[1]), isNot(contains('SQLSTATE')));
    });

    test('terlalu banyak percobaan (429)', () async {
      final t =
          Rig((req) async => reply(429, {'message': 'Too Many Attempts.'}));

      final states = await collect(t.bloc, loginEvent(), 2);

      expect(msg(states[1]), contains('Terlalu banyak'));
    });
  });

  group('started', () {
    test('tanpa token: ke login tanpa memanggil server', () async {
      final t = Rig((req) async => fail('server tidak boleh dipanggil'));

      final states = await collect(t.bloc, const AuthEvent.started(), 1);

      expect(states.single, const AuthState.unauthenticated());
      expect(t.calls, isEmpty);
    });

    test('token valid: masuk', () async {
      final t = Rig(routes);
      t.local.saved = const AuthResponseModel(
        success: true,
        token: '9|tok',
        user: adminUser,
      );

      final states = await collect(t.bloc, const AuthEvent.started(), 1);

      expect(states.single, const AuthState.authenticated(adminUser));
      expect(t.calls.single.headers['Authorization'], 'Bearer 9|tok');
    });

    test('token kedaluwarsa (401): dihapus dan kembali ke login', () async {
      final t = Rig((req) async => reply(401, {'message': 'Unauthenticated.'}));
      t.local.saved = const AuthResponseModel(
        success: true,
        token: '9|tok',
        user: adminUser,
      );

      final states = await collect(t.bloc, const AuthEvent.started(), 1);

      expect(
        states.single,
        const AuthState.unauthenticated(message: ApiHelper.sessionExpired),
      );
      expect(t.local.saved, isNull);
    });

    test('jaringan putus: token tetap disimpan untuk dicoba lagi', () async {
      final t = Rig((req) async => throw http.ClientException('putus'));
      t.local.saved = const AuthResponseModel(
        success: true,
        token: '9|tok',
        user: adminUser,
      );

      final states = await collect(t.bloc, const AuthEvent.started(), 1);

      expect(msg(states.single), ApiHelper.networkError);
      expect(t.local.saved, isNotNull);
    });
  });

  group('logout', () {
    test('menghapus token dan memberi tahu server', () async {
      final t = Rig(routes);
      await collect(t.bloc, loginEvent(), 2);

      final states = await collect(t.bloc, const AuthEvent.logout(), 1);

      expect(states.single, const AuthState.unauthenticated());
      expect(t.local.saved, isNull);
      expect(t.calls.last.url.path, '/api/logout');
      expect(t.calls.last.headers['Authorization'], 'Bearer 1|abc');
    });

    test('tetap keluar walau server tidak terjangkau', () async {
      final t = Rig((req) async {
        if (req.url.path == '/api/logout') throw http.ClientException('putus');
        return routes(req);
      });
      await collect(t.bloc, loginEvent(), 2);

      final states = await collect(t.bloc, const AuthEvent.logout(), 1);

      expect(states.single, const AuthState.unauthenticated());
      expect(t.local.saved, isNull);
    });
  });

  test('401 di tengah sesi: otomatis keluar', () async {
    final t = Rig(routes);
    await collect(t.bloc, loginEvent(), 2);

    final next = t.bloc.stream.first;
    final res = await t.api.send('GET', '/attendances');
    final state = await next.timeout(const Duration(seconds: 5));

    expect(res.isLeft(), isTrue);
    expect(
      state,
      const AuthState.unauthenticated(message: ApiHelper.sessionExpired),
    );
    expect(t.local.saved, isNull);
  });
}
