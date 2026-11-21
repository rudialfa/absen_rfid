import 'dart:convert';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:absensi/data/datasources/settings_remote_datasource.dart';
import 'package:absensi/data/model/request/settings/settings_update_request_model.dart';
import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:absensi/data/model/response/settings/settings_response_model.dart';
import 'package:absensi/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// Penyimpanan palsu: selalu ada token admin
class _FakeLocal extends AuthLocalDatsource {
  @override
  Future<AuthResponseModel?> getAuthData() async => const AuthResponseModel(
        success: true,
        token: '5|adm',
        user: AuthUserModel(
          id: 1,
          name: 'Admin',
          email: 'admin@contoh.test',
          role: 'admin',
        ),
      );
}

const initial = SettingsModel(
  lateTime: '07:15',
  checkoutStart: '12:00',
  cooldownSeconds: 10,
  lcdIdle: 'Tempel kartu',
  requireCardToken: false,
);

const changed = SettingsModel(
  lateTime: '07:30',
  checkoutStart: '12:00',
  cooldownSeconds: 10,
  lcdIdle: 'Tempel kartu',
  requireCardToken: false,
);

Map<String, dynamic> body(SettingsModel s) => {
      'success': true,
      'data': {
        'late_time': s.lateTime,
        'checkout_start': s.checkoutStart,
        'cooldown_seconds': s.cooldownSeconds,
        'lcd_idle': s.lcdIdle,
        'require_card_token': s.requireCardToken,
      },
    };

http.Response reply(int status, Map<String, dynamic> data) => http.Response(
      jsonEncode(data),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

final rigs = <Rig>[];

class Rig {
  Rig(Future<http.Response> Function(http.Request) handler) {
    final client = MockClient((req) async {
      calls.add(req);
      return handler(req);
    });
    bloc = SettingsBloc(
      SettingsRemoteDatasource(
        api: ApiHelper(local: _FakeLocal(), client: client),
      ),
    );
    rigs.add(this);
  }

  final calls = <http.Request>[];
  late final SettingsBloc bloc;
}

Future<List<SettingsState>> collect(
  SettingsBloc bloc,
  SettingsEvent event,
  int count,
) {
  final future = bloc.stream.take(count).toList();
  bloc.add(event);
  return future.timeout(const Duration(seconds: 5));
}

void main() {
  tearDown(() async {
    for (final r in rigs) {
      await r.bloc.close();
    }
    rigs.clear();
  });

  group('model', () {
    test('request hanya memuat field yang diisi', () {
      final r = SettingsUpdateRequestModel(
        lateTime: '07:30',
        requireCardToken: false,
      );

      expect(jsonDecode(r.toJson()), {
        'late_time': '07:30',
        'require_card_token': false,
      });
      expect(r.isEmpty, isFalse);
      expect(SettingsUpdateRequestModel().isEmpty, isTrue);
    });

    test('SettingsModel menolak tipe data yang salah', () {
      expect(
        () => SettingsResponseModel.fromJson(jsonEncode({
          'success': true,
          'data': {
            'late_time': '07:15',
            'checkout_start': '12:00',
            'cooldown_seconds': '10',
            'lcd_idle': 'x',
            'require_card_token': false,
          },
        })),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('ambil setelan', () {
    test('berhasil: loading lalu loaded, dengan token admin', () async {
      final t = Rig((req) async => reply(200, body(initial)));

      final states =
          await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      expect(states[0], const SettingsState.loading());
      expect(states[1], const SettingsState.loaded(initial));
      expect(t.calls.single.method, 'GET');
      expect(t.calls.single.url.path, '/api/settings');
      expect(t.calls.single.headers['Authorization'], 'Bearer 5|adm');
    });

    test('bukan admin (403): pesan dari server', () async {
      final t = Rig((req) async => reply(403, {
            'success': false,
            'code': 'FORBIDDEN',
            'message': 'Anda tidak punya akses',
          }));

      final states =
          await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      expect(
        states[1],
        const SettingsState.loadFailed('Anda tidak punya akses'),
      );
    });

    test('jaringan putus: pesan jelas', () async {
      final t = Rig((req) async => throw http.ClientException('putus'));

      final states =
          await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      expect(states[1], const SettingsState.loadFailed(ApiHelper.networkError));
    });

    test('jawaban server rusak: pesan umum', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': {'late_time': '07:15'},
          }));

      final states =
          await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      expect(states[1], const SettingsState.loadFailed(ApiHelper.badResponse));
    });
  });

  group('simpan setelan', () {
    test('berhasil: saving lalu saved, hanya field yang berubah dikirim',
        () async {
      final t = Rig((req) async => req.method == 'PUT'
          ? reply(200, body(changed))
          : reply(200, body(initial)));
      await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      final states = await collect(
        t.bloc,
        SettingsEvent.update(SettingsUpdateRequestModel(lateTime: '07:30')),
        2,
      );

      expect(states[0], const SettingsState.saving(initial));
      expect(
          states[1], const SettingsState.saved(changed, 'Setelan tersimpan'));

      final put = t.calls.last;
      expect(put.method, 'PUT');
      expect(put.url.path, '/api/settings');
      expect(put.headers['Content-Type'], contains('application/json'));
      expect(jsonDecode(put.body), {'late_time': '07:30'});
    });

    test('ditolak server (422): pesan server, data lama tetap', () async {
      final t = Rig((req) async => req.method == 'PUT'
          ? reply(422, {
              'success': false,
              'code': 'SETTING_ORDER',
              'message':
                  'Batas terlambat tidak boleh lebih besar dari jam mulai pulang',
            })
          : reply(200, body(initial)));
      await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      final states = await collect(
        t.bloc,
        SettingsEvent.update(SettingsUpdateRequestModel(lateTime: '14:00')),
        2,
      );

      expect(states[0], const SettingsState.saving(initial));
      expect(
        states[1],
        const SettingsState.saveFailed(
          initial,
          'Batas terlambat tidak boleh lebih besar dari jam mulai pulang',
        ),
      );
    });

    test('tanpa data awal dari server: tidak memanggil server', () async {
      final t = Rig((req) async => fail('server tidak boleh dipanggil'));

      t.bloc.add(
        SettingsEvent.update(SettingsUpdateRequestModel(lateTime: '07:30')),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(t.calls, isEmpty);
      expect(t.bloc.state, const SettingsState.initial());
    });

    test('sesi berakhir saat menyimpan (401)', () async {
      final t = Rig((req) async => req.method == 'PUT'
          ? reply(401, {'message': 'Unauthenticated.'})
          : reply(200, body(initial)));
      await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      final states = await collect(
        t.bloc,
        SettingsEvent.update(SettingsUpdateRequestModel(lateTime: '07:30')),
        2,
      );

      expect(
        states[1],
        const SettingsState.saveFailed(initial, ApiHelper.sessionExpired),
      );
    });

    test('jaringan putus saat menyimpan: data lama utuh', () async {
      final t = Rig((req) async {
        if (req.method == 'PUT') throw http.ClientException('putus');
        return reply(200, body(initial));
      });
      await collect(t.bloc, const SettingsEvent.getSettings(), 2);

      final states = await collect(
        t.bloc,
        SettingsEvent.update(SettingsUpdateRequestModel(cooldownSeconds: 20)),
        2,
      );

      expect(
        states[1],
        const SettingsState.saveFailed(initial, ApiHelper.networkError),
      );
    });
  });
}
