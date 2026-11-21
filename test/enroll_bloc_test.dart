import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/enroll_remote_datasource.dart';
import 'package:absensi/presentation/bloc/enroll/enroll_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'test_helpers.dart';

Map<String, dynamic> capturedMap({
  String uid = 'AABBCCDD',
  bool registered = false,
  String? owner,
  String? type,
}) =>
    {
      'uid': uid,
      'registered': registered,
      'owner_type': type,
      'student': owner,
      'is_active': registered ? true : null,
      'at': '2026-11-14T10:00:00+07:00',
    };

Map<String, dynamic> statusMap({
  bool active = true,
  int expires = 60,
  Map<String, dynamic>? captured,
  bool? confirmed,
}) =>
    {
      'success': true,
      'active': active,
      'expires_in': expires,
      'captured': captured,
      'card_token': confirmed == null ? null : {'confirmed': confirmed},
    };

/// Server palsu: jawaban status diambil berurutan, yang terakhir diulang
Future<http.Response> Function(http.Request) server(
  List<Map<String, dynamic>> statuses,
) {
  var i = 0;

  return (req) async {
    switch (req.url.path) {
      case '/api/enroll/start':
        return reply(200, {'success': true, 'active': true, 'expires_in': 60});
      case '/api/enroll/status':
        final s = statuses[i < statuses.length ? i : statuses.length - 1];
        i++;
        return reply(200, s);
      case '/api/enroll/cancel':
        return reply(200, {'success': true, 'active': false});
    }
    return reply(404, {});
  };
}

final rigs = <Rig>[];

class Rig {
  Rig(
    Future<http.Response> Function(http.Request) handler, {
    Duration writeTimeout = const Duration(seconds: 5),
  }) {
    final client = MockClient((req) async {
      calls.add(req);
      return handler(req);
    });
    bloc = EnrollBloc(
      EnrollRemoteDatasource(
        api: ApiHelper(local: AdminLocal(), client: client),
      ),
      pollInterval: const Duration(milliseconds: 10),
      writeTimeout: writeTimeout,
    );
    rigs.add(this);
  }

  final calls = <http.Request>[];
  late final EnrollBloc bloc;

  int get statusCalls =>
      calls.where((c) => c.url.path == '/api/enroll/status').length;
}

const wait = Duration(seconds: 5);

void main() {
  tearDown(() async {
    for (final r in rigs) {
      await r.bloc.close();
    }
    rigs.clear();
  });

  test('kartu baru: waiting, writing, ready, lalu pemeriksaan berhenti',
      () async {
    final t = Rig(server([
      statusMap(expires: 55),
      statusMap(active: false, captured: capturedMap(), confirmed: false),
      statusMap(active: false, captured: capturedMap(), confirmed: true),
    ]));

    final states = <EnrollState>[];
    t.bloc.stream.listen(states.add);
    final ready = t.bloc.stream
        .firstWhere((s) => s == const EnrollState.ready('AABBCCDD'))
        .timeout(wait);

    t.bloc.add(const EnrollEvent.start());
    await ready;

    expect(states, [
      const EnrollState.starting(),
      const EnrollState.waiting(60),
      const EnrollState.waiting(55),
      const EnrollState.writing('AABBCCDD'),
      const EnrollState.ready('AABBCCDD'),
    ]);

    final polls = t.statusCalls;
    await Future<void>.delayed(const Duration(milliseconds: 150));
    expect(t.statusCalls, polls);
  });

  test('kartu sudah dipakai murid: alreadyUsed beserta pemiliknya', () async {
    final t = Rig(server([
      statusMap(
        active: false,
        captured: capturedMap(
          uid: 'F15E2F8E',
          registered: true,
          owner: 'Budi',
          type: 'student',
        ),
      ),
    ]));

    final used = t.bloc.stream
        .firstWhere((s) =>
            s.maybeWhen(alreadyUsed: (_, __, ___) => true, orElse: () => false))
        .timeout(wait);

    t.bloc.add(const EnrollEvent.start());

    expect(
      await used,
      const EnrollState.alreadyUsed(
        uid: 'F15E2F8E',
        ownerName: 'Budi',
        ownerType: 'student',
      ),
    );
  });

  test('tidak ada kartu sampai mode mati: expired', () async {
    final t = Rig(server([statusMap(active: false)]));

    final expired = t.bloc.stream
        .firstWhere((s) => s == const EnrollState.expired())
        .timeout(wait);

    t.bloc.add(const EnrollEvent.start());

    expect(await expired, const EnrollState.expired());
  });

  test('jaringan putus saat memeriksa status: failed', () async {
    final t = Rig((req) async {
      if (req.url.path == '/api/enroll/start') {
        return reply(200, {'success': true, 'active': true, 'expires_in': 60});
      }
      throw http.ClientException('putus');
    });

    final failed = t.bloc.stream
        .firstWhere(
            (s) => s.maybeWhen(failed: (_) => true, orElse: () => false))
        .timeout(wait);

    t.bloc.add(const EnrollEvent.start());

    expect(await failed, const EnrollState.failed(ApiHelper.networkError));
  });

  test('bukan admin (403) saat memulai: starting lalu failed', () async {
    final t = Rig((req) async => reply(403, {
          'success': false,
          'code': 'FORBIDDEN',
          'message': 'Anda tidak punya akses',
        }));

    final states = await collect(t.bloc, const EnrollEvent.start(), 2);

    expect(states[0], const EnrollState.starting());
    expect(states[1], const EnrollState.failed('Anda tidak punya akses'));
  });

  test('token tidak kunjung ditulis: failed dengan pesan jelas', () async {
    final t = Rig(
      server([
        statusMap(active: false, captured: capturedMap(), confirmed: false)
      ]),
      writeTimeout: const Duration(milliseconds: 50),
    );

    final failed = t.bloc.stream
        .firstWhere(
            (s) => s.maybeWhen(failed: (_) => true, orElse: () => false))
        .timeout(wait);

    t.bloc.add(const EnrollEvent.start());

    expect(
        await failed, const EnrollState.failed(EnrollBloc.writeTimeoutMessage));
  });

  test('batal: server diberi tahu dan pemeriksaan berhenti', () async {
    final t = Rig(server([statusMap(expires: 50)]));

    final waiting = t.bloc.stream
        .firstWhere((s) => s == const EnrollState.waiting(60))
        .timeout(wait);
    t.bloc.add(const EnrollEvent.start());
    await waiting;

    final initial = t.bloc.stream
        .firstWhere((s) => s == const EnrollState.initial())
        .timeout(wait);
    t.bloc.add(const EnrollEvent.cancel());
    await initial;

    expect(
      t.calls
          .any((c) => c.method == 'POST' && c.url.path == '/api/enroll/cancel'),
      isTrue,
    );

    final polls = t.statusCalls;
    await Future<void>.delayed(const Duration(milliseconds: 150));
    expect(t.statusCalls, polls);
  });
}
