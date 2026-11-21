import 'dart:convert';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/class_remote_datasource.dart';
import 'package:absensi/data/datasources/student_remote_datasource.dart';
import 'package:absensi/data/model/request/student/student_request_model.dart';
import 'package:absensi/data/model/response/class/class_response_model.dart';
import 'package:absensi/data/model/response/student/student_response_model.dart';
import 'package:absensi/presentation/bloc/class/class_bloc.dart';
import 'package:absensi/presentation/bloc/student/student_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'test_helpers.dart';

Map<String, dynamic> studentMap({
  int id = 1,
  String name = 'Budi',
  String uid = 'F15E2F8E',
  bool token = true,
  bool active = true,
}) =>
    {
      'id': id,
      'name': name,
      'class': 'X-A',
      'class_id': 5,
      'rfid_uid': uid,
      'is_active': active,
      'has_token': token,
    };

final rigs = <Rig>[];

class Rig {
  Rig(Future<http.Response> Function(http.Request) handler) {
    final client = MockClient((req) async {
      calls.add(req);
      return handler(req);
    });
    final api = ApiHelper(local: AdminLocal(), client: client);
    students = StudentBloc(StudentRemoteDatasource(api: api));
    classes = ClassBloc(ClassRemoteDatasource(api: api));
    rigs.add(this);
  }

  final calls = <http.Request>[];
  late final StudentBloc students;
  late final ClassBloc classes;
}

String? messageOf(StudentState s) => s.maybeWhen(
      saved: (m) => m,
      saveFailed: (m) => m,
      orElse: () => null,
    );

void main() {
  tearDown(() async {
    for (final r in rigs) {
      await r.students.close();
      await r.classes.close();
    }
    rigs.clear();
  });

  group('model', () {
    test('tambah murid dengan class_id: UID jadi huruf besar, nama dirapikan',
        () {
      final json = jsonDecode(
        StudentCreateRequestModel(
          name: ' Ani ',
          classId: 5,
          className: 'X-Z',
          rfidUid: ' f15e2f8e ',
        ).toJson(),
      );

      expect(json, {'name': 'Ani', 'rfid_uid': 'F15E2F8E', 'class_id': 5});
    });

    test('tambah murid dengan nama kelas: dikirim sebagai class', () {
      final json = jsonDecode(
        StudentCreateRequestModel(
          name: 'Ani',
          className: ' X-B ',
          rfidUid: 'F15E2F8E',
        ).toJson(),
      );

      expect(json, {'name': 'Ani', 'rfid_uid': 'F15E2F8E', 'class': 'X-B'});
    });

    test('ubah murid: hanya field yang diisi', () {
      final r = StudentUpdateRequestModel(name: 'A', isActive: false);

      expect(jsonDecode(r.toJson()), {'name': 'A', 'is_active': false});
      expect(r.isEmpty, isFalse);
      expect(StudentUpdateRequestModel().isEmpty, isTrue);
    });

    test('StudentModel menolak tipe data yang salah', () {
      expect(
        () => StudentModel.fromMap({
          ...studentMap(),
          'is_active': 'ya',
        }),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('daftar murid', () {
    test('berhasil: dengan pencarian dan filter, memakai token admin',
        () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': [
              studentMap(),
              studentMap(id: 2, name: 'Siti', uid: 'A1B2C3D4'),
            ],
          }));

      final states = await collect(
        t.students,
        const StudentEvent.getList(q: ' bud ', active: true),
        2,
      );

      expect(states[0], const StudentState.listLoading());

      final items = states[1].maybeWhen<List<StudentModel>>(
        listLoaded: (i) => i,
        orElse: () => const [],
      );
      expect(items.map((s) => s.name), ['Budi', 'Siti']);

      final req = t.calls.single;
      expect(req.method, 'GET');
      expect(req.url.path, '/api/students');
      expect(req.url.queryParameters, {'q': 'bud', 'active': '1'});
      expect(req.headers['Authorization'], 'Bearer 5|adm');
    });

    test('tanpa pencarian dan filter: tidak ada query', () async {
      final t = Rig((req) async => reply(200, {'success': true, 'data': []}));

      await collect(
        t.students,
        const StudentEvent.getList(q: '   '),
        2,
      );

      expect(t.calls.single.url.queryParameters, isEmpty);
    });

    test('bukan admin (403): pesan dari server', () async {
      final t = Rig((req) async => reply(403, {
            'success': false,
            'code': 'FORBIDDEN',
            'message': 'Anda tidak punya akses',
          }));

      final states = await collect(t.students, const StudentEvent.getList(), 2);

      expect(
          states[1], const StudentState.listFailed('Anda tidak punya akses'));
    });
  });

  group('simpan murid', () {
    test('tambah berhasil: saving lalu saved, isi permintaan benar', () async {
      final t = Rig((req) async => reply(
          201, {'success': true, 'data': studentMap(id: 9, name: 'Ani')}));

      final states = await collect(
        t.students,
        StudentEvent.create(
          StudentCreateRequestModel(
            name: ' Ani ',
            classId: 5,
            rfidUid: 'f15e2f8e',
          ),
        ),
        2,
      );

      expect(states[0], const StudentState.saving());
      expect(states[1], const StudentState.saved('Murid tersimpan'));

      final req = t.calls.single;
      expect(req.method, 'POST');
      expect(req.url.path, '/api/students');
      expect(
        jsonDecode(req.body),
        {'name': 'Ani', 'rfid_uid': 'F15E2F8E', 'class_id': 5},
      );
    });

    test('tambah berhasil tanpa token: ada peringatan', () async {
      final t = Rig((req) async => reply(201, {
            'success': true,
            'data': studentMap(id: 9, token: false),
          }));

      final states = await collect(
        t.students,
        StudentEvent.create(
          StudentCreateRequestModel(
              name: 'Ani', classId: 5, rfidUid: 'F15E2F8E'),
        ),
        2,
      );

      expect(messageOf(states[1]), contains('belum bertoken'));
    });

    test('kartu sudah dipakai (422): pesan dari server', () async {
      final t = Rig((req) async => reply(422, {
            'success': false,
            'code': 'UID_TAKEN',
            'message': 'Kartu ini sudah dipakai orang lain',
          }));

      final states = await collect(
        t.students,
        StudentEvent.create(
          StudentCreateRequestModel(
              name: 'Ani', classId: 5, rfidUid: 'F15E2F8E'),
        ),
        2,
      );

      expect(
        states[1],
        const StudentState.saveFailed('Kartu ini sudah dipakai orang lain'),
      );
    });

    test('ubah murid: PUT hanya field yang berubah', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': studentMap(id: 3, active: false),
          }));

      final states = await collect(
        t.students,
        StudentEvent.update(3, StudentUpdateRequestModel(isActive: false)),
        2,
      );

      expect(states[1], const StudentState.saved('Perubahan tersimpan'));

      final req = t.calls.single;
      expect(req.method, 'PUT');
      expect(req.url.path, '/api/students/3');
      expect(jsonDecode(req.body), {'is_active': false});
    });

    test('ganti kartu berhasil: POST tanpa body', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': studentMap(id: 3, uid: '11112222'),
            'old_uid': 'F15E2F8E',
          }));

      final states =
          await collect(t.students, const StudentEvent.replaceCard(3), 2);

      expect(states[1], const StudentState.saved('Kartu berhasil diganti'));

      final req = t.calls.single;
      expect(req.method, 'POST');
      expect(req.url.path, '/api/students/3/replace-card');
      expect(req.body, isEmpty);
    });

    test('ganti kartu tanpa scan (422, NO_SCAN): pesan dari server', () async {
      final t = Rig((req) async => reply(422, {
            'success': false,
            'code': 'NO_SCAN',
            'message': 'Belum ada kartu baru yang di-scan.',
          }));

      final states =
          await collect(t.students, const StudentEvent.replaceCard(3), 2);

      expect(
        states[1],
        const StudentState.saveFailed('Belum ada kartu baru yang di-scan.'),
      );
    });

    test('dobel tekan simpan: hanya satu permintaan terkirim', () async {
      final t = Rig((req) async {
        await Future<void>.delayed(const Duration(milliseconds: 80));
        return reply(201, {'success': true, 'data': studentMap(id: 9)});
      });

      final event = StudentEvent.create(
        StudentCreateRequestModel(name: 'Ani', classId: 5, rfidUid: 'F15E2F8E'),
      );
      t.students.add(event);
      t.students.add(event);

      await Future<void>.delayed(const Duration(milliseconds: 300));

      expect(t.calls.where((c) => c.method == 'POST').length, 1);
    });
  });

  group('daftar kelas', () {
    test('berhasil: loading lalu loaded', () async {
      final t = Rig((req) async => reply(200, {
            'success': true,
            'data': [
              {'id': 5, 'name': 'X-A', 'student_count': 3},
            ],
          }));

      final states = await collect(t.classes, const ClassEvent.getList(), 2);

      expect(states[0], const ClassState.loading());
      expect(
        states[1],
        const ClassState.loaded(
            [ClassModel(id: 5, name: 'X-A', studentCount: 3)]),
      );
      expect(t.calls.single.url.path, '/api/classes');
    });

    test('jaringan putus: pesan jelas', () async {
      final t = Rig((req) async => throw http.ClientException('putus'));

      final states = await collect(t.classes, const ClassEvent.getList(), 2);

      expect(states[1], const ClassState.error(ApiHelper.networkError));
    });
  });
}
