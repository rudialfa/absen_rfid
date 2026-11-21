import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/response/enroll/enroll_response_model.dart';
import 'package:dartz/dartz.dart';

class EnrollRemoteDatasource {
  EnrollRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // POST /api/enroll/start: mode daftar aktif 60 detik
  Future<Either<String, EnrollStartResponseModel>> start() async {
    final res = await api.send('POST', '/enroll/start');
    return ApiHelper.handle(res, EnrollStartResponseModel.fromJson);
  }

  // GET /api/enroll/status
  Future<Either<String, EnrollStatusResponseModel>> status() async {
    final res = await api.send('GET', '/enroll/status');
    return ApiHelper.handle(res, EnrollStatusResponseModel.fromJson);
  }

  // POST /api/enroll/cancel
  Future<Either<String, String>> cancel() async {
    final res = await api.send(
      'POST',
      '/enroll/cancel',
      timeout: const Duration(seconds: 5),
    );
    return ApiHelper.handle(res, (_) => 'OK');
  }
}
