import 'dart:convert';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/device_remote_datasource.dart';
import 'package:absensi/data/model/request/device/device_request_model.dart';
import 'package:absensi/data/model/response/device/device_response_model.dart';
import 'package:absensi/presentation/bloc/device/device_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'test_helpers.dart';

const created = '2026-11-14T10:00:00+07:00';
const keyUji = 'KEY-UJI-1234567890-ABCDEFGHIJKLMNOPQRST';

Map<String, dynamic> deviceMap({int id = 1, String name = 'Gerbang Utama'}) => {
      'id': id,
      'name': name,
      'created_at': created,
    };

DeviceModel device({int id = 1, String name = 'Gerbang Utama'}) =>
    DeviceModel(id: id, name: name, createdAt: created);

final rigs = <Rig>[];

class Rig {
  Rig(Future<http.Response> Function(http.Request) handler) {
    final client = MockClient((req) async {
      calls.add(req);
      return handler(req);
    });
    bloc = DeviceBloc(
      DeviceRemoteDatasource(
        api: ApiHelper(local: AdminLocal(), client: client),
      ),
    );
    rigs.add(this);
  }

  final calls = <http.Request>[];
  late final DeviceBloc bloc;
}

void main() {
  tearDown(() async {
    for (final r in rigs) {
      await r.bloc.close();
    }
    rigs.clear();
  });

  group('model', () {
    test('nama perangkat dirapikan sebelum dikirim', () {
      expect(
        jsonDecode(DeviceNameRequestModel(name: '  Gerbang  ').toJson()),
        {'name': 'Gerbang'},
      );
    });

    test('DeviceModel menolak tipe data yang salah', () {
      expect(
        () => DeviceModel.fromMap({'id': '1', 'name': 'x'}),
        throwsA(isA<FormatException>()),
      );
    });

    test('device_key dibaca kalau ada dan kosong kalau tidak ada', () {
      final withKey = DeviceActionResponseModel.fromJson(jsonEncode({
        'success': true,
        'data': deviceMap(),
        'device_key': 'abc',
      }));
      final withoutKey = DeviceActionResponseModel.fromJson(jsonEncode({
        'success': true,
        'data': deviceMap(),
      }));

      expect(withKey.deviceKey, 'abc');
      expect(withoutKey.deviceKey, isNull);
    });
  });

  group('daftar perangkat', () {
    test('berhasil: memakai token admin', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': [deviceMap(), deviceMap(id: 2, name: 'Pintu Samping')],
          }));

      final states = await collect(t.bloc, const DeviceEvent.getList(), 2);

      expect(states[0], const DeviceState.listLoading());

      final items = states[1].maybeWhen<List<DeviceModel>>(
        listLoaded: (i) => i,
        orElse: () => const [],
      );
      expect(items.map((d) => d.name), ['Gerbang Utama', 'Pintu Samping']);

      final req = t.calls.single;
      expect(req.method, 'GET');
      expect(req.url.path, '/api/devices');
      expect(req.headers['Authorization'], 'Bearer 5|adm');
    });

    test('bukan admin (403): pesan dari server', () async {
      final t = Rig((req) async => reply(403, {
            'success': false,
            'code': 'FORBIDDEN',
            'message': 'Anda tidak punya akses',
          }));

      final states = await collect(t.bloc, const DeviceEvent.getList(), 2);

      expect(states[1], const DeviceState.listFailed('Anda tidak punya akses'));
    });

    test('jaringan putus: pesan jelas', () async {
      final t = Rig((req) async => throw http.ClientException('putus'));

      final states = await collect(t.bloc, const DeviceEvent.getList(), 2);

      expect(states[1], const DeviceState.listFailed(ApiHelper.networkError));
    });
  });

  group('tambah perangkat', () {
    test('berhasil: saving lalu keyIssued, key hanya ada di state itu',
        () async {
      final t = Rig((req) async => reply(201, {
            'success': true,
            'data': deviceMap(id: 9, name: 'Uji'),
            'device_key': keyUji,
          }));

      final states = await collect(
        t.bloc,
        DeviceEvent.create(DeviceNameRequestModel(name: ' Uji ')),
        2,
      );

      expect(states[0], const DeviceState.saving());
      expect(
        states[1],
        DeviceState.keyIssued(device(id: 9, name: 'Uji'), keyUji, false),
      );

      final req = t.calls.single;
      expect(req.method, 'POST');
      expect(req.url.path, '/api/devices');
      expect(jsonDecode(req.body), {'name': 'Uji'});
    });

    test('nama ditolak server (422): pesan dari server', () async {
      final t = Rig((req) async => reply(422, {
            'success': false,
            'code': 'VALIDATION',
            'message': 'Nama perangkat wajib diisi (maksimal 100 karakter)',
          }));

      final states = await collect(
        t.bloc,
        DeviceEvent.create(DeviceNameRequestModel(name: '')),
        2,
      );

      expect(
        states[1],
        const DeviceState.saveFailed(
          'Nama perangkat wajib diisi (maksimal 100 karakter)',
        ),
      );
    });

    test('jawaban tanpa device_key dianggap rusak', () async {
      final t = Rig((req) async => reply(201, {
            'success': true,
            'data': deviceMap(id: 9),
          }));

      final states = await collect(
        t.bloc,
        DeviceEvent.create(DeviceNameRequestModel(name: 'Uji')),
        2,
      );

      expect(states[1], const DeviceState.saveFailed(ApiHelper.badResponse));
    });

    test('dobel tekan: hanya satu permintaan terkirim', () async {
      final t = Rig((req) async {
        await Future<void>.delayed(const Duration(milliseconds: 80));
        return reply(201, {
          'success': true,
          'data': deviceMap(id: 9),
          'device_key': keyUji,
        });
      });

      final event = DeviceEvent.create(DeviceNameRequestModel(name: 'Uji'));
      t.bloc.add(event);
      t.bloc.add(event);

      await Future<void>.delayed(const Duration(milliseconds: 300));

      expect(t.calls.where((c) => c.method == 'POST').length, 1);
    });
  });

  group('ganti nama', () {
    test('berhasil: PUT dengan nama baru', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': deviceMap(id: 3, name: 'Gerbang Baru'),
          }));

      final states = await collect(
        t.bloc,
        DeviceEvent.rename(3, DeviceNameRequestModel(name: ' Gerbang Baru ')),
        2,
      );

      expect(states[1], const DeviceState.saved('Nama perangkat diperbarui'));

      final req = t.calls.single;
      expect(req.method, 'PUT');
      expect(req.url.path, '/api/devices/3');
      expect(jsonDecode(req.body), {'name': 'Gerbang Baru'});
    });
  });

  group('ganti key', () {
    test('berhasil: keyIssued dengan penanda rotated, POST tanpa body',
        () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': deviceMap(id: 3),
            'device_key': 'KEY-BARU',
          }));

      final states = await collect(t.bloc, const DeviceEvent.rotateKey(3), 2);

      expect(
        states[1],
        DeviceState.keyIssued(device(id: 3), 'KEY-BARU', true),
      );

      final req = t.calls.single;
      expect(req.method, 'POST');
      expect(req.url.path, '/api/devices/3/rotate-key');
      expect(req.body, isEmpty);
    });

    test(
        'perangkat tidak ada (404 bawaan Laravel): pesan umum, tanpa nama model',
        () async {
      final t = Rig((req) async => reply(404, {
            'message': 'No query results for model [App\\Models\\Device] 99',
          }));

      final states = await collect(t.bloc, const DeviceEvent.rotateKey(99), 2);

      expect(states[1], const DeviceState.saveFailed(ApiHelper.notFound));
    });
  });

  group('hapus perangkat', () {
    test('berhasil: DELETE ke perangkat itu', () async {
      final t = Rig((req) async => reply(200, {'success': true}));

      final states = await collect(t.bloc, const DeviceEvent.delete(3), 2);

      expect(states[1], const DeviceState.saved('Perangkat dihapus'));

      final req = t.calls.single;
      expect(req.method, 'DELETE');
      expect(req.url.path, '/api/devices/3');
    });

    test('perangkat terakhir (422, LAST_DEVICE): pesan dari server', () async {
      final t = Rig((req) async => reply(422, {
            'success': false,
            'code': 'LAST_DEVICE',
            'message': 'Perangkat terakhir tidak boleh dihapus',
          }));

      final states = await collect(t.bloc, const DeviceEvent.delete(1), 2);

      expect(
        states[1],
        const DeviceState.saveFailed('Perangkat terakhir tidak boleh dihapus'),
      );
    });

    test('sesi berakhir saat menghapus (401)', () async {
      final t = Rig((req) async => reply(401, {'message': 'Unauthenticated.'}));

      final states = await collect(t.bloc, const DeviceEvent.delete(3), 2);

      expect(states[1], const DeviceState.saveFailed(ApiHelper.sessionExpired));
    });
  });
}
