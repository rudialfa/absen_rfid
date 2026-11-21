import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/request/settings/settings_update_request_model.dart';
import 'package:absensi/data/model/response/settings/settings_response_model.dart';
import 'package:dartz/dartz.dart';

class SettingsRemoteDatasource {
  SettingsRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // GET /api/settings (khusus admin)
  Future<Either<String, SettingsResponseModel>> get() async {
    final res = await api.send('GET', '/settings');
    return ApiHelper.handle(res, SettingsResponseModel.fromJson);
  }

  // PUT /api/settings (khusus admin, boleh sebagian field)
  Future<Either<String, SettingsResponseModel>> update(
    SettingsUpdateRequestModel request,
  ) async {
    final res = await api.send('PUT', '/settings', body: request.toJson());
    return ApiHelper.handle(res, SettingsResponseModel.fromJson);
  }
}
