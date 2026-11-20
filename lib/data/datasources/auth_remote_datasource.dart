import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/request/auth/login_request_model.dart';
import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteDatasource {
  AuthRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // POST /api/login
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final res = await api.send(
      'POST',
      '/login',
      body: request.toJson(),
      auth: false,
    );
    return ApiHelper.handle(res, AuthResponseModel.fromJson);
  }

  // GET /api/me
  Future<Either<String, MeResponseModel>> me() async {
    final res = await api.send('GET', '/me');
    return ApiHelper.handle(res, MeResponseModel.fromJson);
  }

  // POST /api/logout
  Future<Either<String, String>> logout() async {
    final res = await api.send(
      'POST',
      '/logout',
      timeout: const Duration(seconds: 5),
    );
    return ApiHelper.handle(res, (_) => 'OK');
  }
}
