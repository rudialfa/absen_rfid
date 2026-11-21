import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/request/device/device_request_model.dart';
import 'package:absensi/data/model/response/device/device_response_model.dart';
import 'package:dartz/dartz.dart';

class DeviceRemoteDatasource {
  DeviceRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // GET /api/devices (khusus admin, tanpa key dan hash)
  Future<Either<String, DeviceListResponseModel>> list() async {
    final res = await api.send('GET', '/devices');
    return ApiHelper.handle(res, DeviceListResponseModel.fromJson);
  }

  // POST /api/devices: key dibuat server dan tampil sekali
  Future<Either<String, DeviceActionResponseModel>> create(
    DeviceNameRequestModel request,
  ) async {
    final res = await api.send('POST', '/devices', body: request.toJson());
    return _requireKey(
      ApiHelper.handle(
        res,
        DeviceActionResponseModel.fromJson,
        ok: const {200, 201},
      ),
    );
  }

  // PUT /api/devices/{id}
  Future<Either<String, DeviceActionResponseModel>> rename(
    int id,
    DeviceNameRequestModel request,
  ) async {
    final res = await api.send('PUT', '/devices/$id', body: request.toJson());
    return ApiHelper.handle(res, DeviceActionResponseModel.fromJson);
  }

  // POST /api/devices/{id}/rotate-key: key lama langsung mati
  Future<Either<String, DeviceActionResponseModel>> rotateKey(int id) async {
    final res = await api.send('POST', '/devices/$id/rotate-key');
    return _requireKey(
      ApiHelper.handle(res, DeviceActionResponseModel.fromJson),
    );
  }

  // DELETE /api/devices/{id}: perangkat terakhir ditolak server (LAST_DEVICE)
  Future<Either<String, String>> delete(int id) async {
    final res = await api.send('DELETE', '/devices/$id');
    return ApiHelper.handle(res, (_) => 'OK');
  }

  /// Jawaban pembuatan dan ganti key tanpa device_key dianggap rusak, supaya
  /// aplikasi tidak pernah mengatakan "berhasil" tanpa key untuk ditampilkan.
  Either<String, DeviceActionResponseModel> _requireKey(
    Either<String, DeviceActionResponseModel> result,
  ) {
    return result.flatMap(
      (m) => m.deviceKey == null
          ? Left<String, DeviceActionResponseModel>(ApiHelper.badResponse)
          : Right<String, DeviceActionResponseModel>(m),
    );
  }
}
