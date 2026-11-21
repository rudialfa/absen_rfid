import 'dart:async';
import 'dart:convert';
import 'dart:io' show HandshakeException, SocketException;

import 'package:absensi/core/constants/variables.dart';
import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper({AuthLocalDatsource? local, http.Client? client})
      : local = local ?? AuthLocalDatsource(),
        client = client ?? http.Client();

  final AuthLocalDatsource local;
  final http.Client client;

  static const sessionExpired = 'Sesi berakhir. Silakan masuk lagi.';
  static const networkError =
      'Tidak bisa terhubung ke server. Cek Wi-Fi dan alamat server.';
  static const timeoutError = 'Server tidak merespons. Coba lagi sebentar.';
  static const secureError =
      'Koneksi aman ke server gagal. Cek alamat dan sertifikat server.';
  static const badResponse = 'Server mengirim jawaban yang tidak dikenali.';
  static const notFound = 'Data tidak ditemukan.';

  /// Terpicu saat server menolak token yang sedang dipakai (401).
  /// AuthBloc mendengarkan ini supaya aplikasi otomatis kembali ke login.
  static final StreamController<void> _unauthorized =
      StreamController<void>.broadcast();
  static Stream<void> get onUnauthorized => _unauthorized.stream;

  Uri uri(String path, [Map<String, String>? query]) =>
      Uri.parse('${Variables.baseUrl}/api$path')
          .replace(queryParameters: query);

  /// Left hanya untuk masalah jaringan, timeout, atau sesi berakhir.
  /// Status HTTP lain tetap Right(response) dan diputuskan oleh datasource.
  Future<Either<String, http.Response>> send(
    String method,
    String path, {
    Map<String, String>? query,
    String? body,
    bool auth = true,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final headers = <String, String>{'Accept': 'application/json'};
    if (body != null) headers['Content-Type'] = 'application/json';

    String? token;
    if (auth) {
      final raw = (await local.getAuthData())?.token;
      token = (raw == null || raw.isEmpty) ? null : raw;
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }

    try {
      final res =
          await _call(method, uri(path, query), headers, body).timeout(timeout);

      if (res.statusCode == 401 && token != null) {
        _unauthorized.add(null);
        return Left(sessionExpired);
      }
      return Right(res);
    } on TimeoutException {
      return Left(timeoutError);
    } on HandshakeException {
      return Left(secureError);
    } on SocketException {
      return Left(networkError);
    } on http.ClientException {
      return Left(networkError);
    }
  }

  Future<http.Response> _call(
    String method,
    Uri u,
    Map<String, String> headers,
    String? body,
  ) {
    switch (method) {
      case 'POST':
        return client.post(u, headers: headers, body: body);
      case 'PUT':
        return client.put(u, headers: headers, body: body);
      case 'DELETE':
        return client.delete(u, headers: headers, body: body);
      default:
        return client.get(u, headers: headers);
    }
  }

  /// Pesan untuk pengguna. Detail error server (misalnya SQL atau nama model)
  /// tidak ditampilkan.
  static String errorMessage(http.Response res) {
    final s = res.statusCode;
    if (s == 429) {
      return 'Terlalu banyak percobaan. Tunggu sebentar lalu coba lagi.';
    }
    if (s >= 500) return 'Terjadi kesalahan di server (HTTP $s).';

    String? message;
    var hasCode = false;
    try {
      final d = jsonDecode(utf8.decode(res.bodyBytes));
      if (d is Map) {
        final m = d['message'];
        if (m is String && m.isNotEmpty) message = m;
        hasCode = d['code'] is String;
      }
    } catch (_) {}

    // 404 bawaan Laravel memuat nama model dan tidak punya `code`.
    // Jawaban 404 dari controller kita selalu membawa `code`.
    if (s == 404 && !hasCode) return notFound;

    if (message != null) return message;
    return 'Permintaan ditolak (HTTP $s).';
  }

  /// Mengubah response menjadi model. Status di luar [ok] menjadi Left(pesan).
  static Either<String, T> handle<T>(
    Either<String, http.Response> res,
    T Function(String body) fromJson, {
    Set<int> ok = const {200},
  }) {
    return res.fold<Either<String, T>>(
      (l) => Left(l),
      (r) {
        if (!ok.contains(r.statusCode)) return Left(errorMessage(r));
        try {
          return Right(fromJson(utf8.decode(r.bodyBytes)));
        } catch (_) {
          return Left(badResponse);
        }
      },
    );
  }
}
