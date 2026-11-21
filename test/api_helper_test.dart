import 'dart:convert';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

http.Response reply(int status, Map<String, dynamic> data) =>
    http.Response(jsonEncode(data), status);

void main() {
  group('pesan error', () {
    test('404 bawaan Laravel: nama model tidak ditampilkan', () {
      final msg = ApiHelper.errorMessage(reply(404, {
        'message': 'No query results for model [App\\Models\\Student] 99',
      }));

      expect(msg, ApiHelper.notFound);
      expect(msg, isNot(contains('App')));
    });

    test('404 dari controller (punya code): pesan dipertahankan', () {
      final msg = ApiHelper.errorMessage(reply(404, {
        'success': false,
        'code': 'NOT_FOUND',
        'message': 'Wali tidak ditemukan',
      }));

      expect(msg, 'Wali tidak ditemukan');
    });

    test('403: pesan server dipertahankan', () {
      final msg = ApiHelper.errorMessage(reply(403, {
        'success': false,
        'code': 'FORBIDDEN',
        'message': 'Anda tidak punya akses',
      }));

      expect(msg, 'Anda tidak punya akses');
    });

    test('500: pesan umum tanpa detail server', () {
      final msg = ApiHelper.errorMessage(reply(500, {
        'message': 'SQLSTATE[42S02] tabel hilang',
      }));

      expect(msg, contains('500'));
      expect(msg, isNot(contains('SQLSTATE')));
    });
  });
}
