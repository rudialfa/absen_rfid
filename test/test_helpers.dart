import 'dart:convert';

import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

/// Penyimpanan palsu: selalu ada token admin
class AdminLocal extends AuthLocalDatsource {
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

http.Response reply(int status, Map<String, dynamic> data) => http.Response(
      jsonEncode(data),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

/// Mengirim satu event lalu mengumpulkan [count] state berikutnya
Future<List<S>> collect<E, S>(Bloc<E, S> bloc, E event, int count) {
  final future = bloc.stream.take(count).toList();
  bloc.add(event);
  return future.timeout(const Duration(seconds: 5));
}
