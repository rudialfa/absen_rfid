import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/response/class/class_response_model.dart';
import 'package:dartz/dartz.dart';

class ClassRemoteDatasource {
  ClassRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // GET /api/classes (khusus admin)
  Future<Either<String, ClassListResponseModel>> list() async {
    final res = await api.send('GET', '/classes');
    return ApiHelper.handle(res, ClassListResponseModel.fromJson);
  }
}
