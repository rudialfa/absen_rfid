import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/model/request/student/student_request_model.dart';
import 'package:absensi/data/model/response/student/student_response_model.dart';
import 'package:dartz/dartz.dart';

class StudentRemoteDatasource {
  StudentRemoteDatasource({ApiHelper? api}) : api = api ?? ApiHelper();

  final ApiHelper api;

  // GET /api/students?q=&active=1|0 (khusus admin)
  Future<Either<String, StudentListResponseModel>> list({
    String? q,
    bool? active,
  }) async {
    final query = <String, String>{
      if (q != null && q.trim().isNotEmpty) 'q': q.trim(),
      if (active != null) 'active': active ? '1' : '0',
    };

    final res = await api.send(
      'GET',
      '/students',
      query: query.isEmpty ? null : query,
    );
    return ApiHelper.handle(res, StudentListResponseModel.fromJson);
  }

  // POST /api/students
  Future<Either<String, StudentActionResponseModel>> create(
    StudentCreateRequestModel request,
  ) async {
    final res = await api.send('POST', '/students', body: request.toJson());
    return ApiHelper.handle(
      res,
      StudentActionResponseModel.fromJson,
      ok: const {200, 201},
    );
  }

  // PUT /api/students/{id}
  Future<Either<String, StudentActionResponseModel>> update(
    int id,
    StudentUpdateRequestModel request,
  ) async {
    final res = await api.send('PUT', '/students/$id', body: request.toJson());
    return ApiHelper.handle(res, StudentActionResponseModel.fromJson);
  }

  // POST /api/students/{id}/replace-card (tanpa body: UID diambil dari hasil scan)
  Future<Either<String, StudentActionResponseModel>> replaceCard(int id) async {
    final res = await api.send('POST', '/students/$id/replace-card');
    return ApiHelper.handle(res, StudentActionResponseModel.fromJson);
  }
}
