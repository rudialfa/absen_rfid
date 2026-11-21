import 'dart:convert';

class StudentModel {
  const StudentModel({
    required this.id,
    required this.name,
    required this.className,
    required this.classId,
    required this.rfidUid,
    required this.isActive,
    required this.hasToken,
  });

  final int id;
  final String name;
  final String className;
  final int? classId;
  final String rfidUid;
  final bool isActive;
  final bool hasToken;

  factory StudentModel.fromMap(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final cls = json['class'];
    final classId = json['class_id'];
    final uid = json['rfid_uid'];
    final active = json['is_active'];
    final token = json['has_token'];

    if (id is! int ||
        name is! String ||
        uid is! String ||
        active is! bool ||
        token is! bool ||
        (classId != null && classId is! int)) {
      throw const FormatException('Data murid tidak lengkap');
    }

    return StudentModel(
      id: id,
      name: name,
      className: cls is String ? cls : '',
      classId: classId as int?,
      rfidUid: uid,
      isActive: active,
      hasToken: token,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is StudentModel &&
      other.id == id &&
      other.name == name &&
      other.className == className &&
      other.classId == classId &&
      other.rfidUid == rfidUid &&
      other.isActive == isActive &&
      other.hasToken == hasToken;

  @override
  int get hashCode =>
      Object.hash(id, name, className, classId, rfidUid, isActive, hasToken);
}

/// Jawaban GET /api/students
class StudentListResponseModel {
  const StudentListResponseModel({required this.success, required this.data});

  final bool success;
  final List<StudentModel> data;

  factory StudentListResponseModel.fromJson(String str) =>
      StudentListResponseModel.fromMap(jsonDecode(str));

  factory StudentListResponseModel.fromMap(Map<String, dynamic> json) {
    final list = json['data'];

    if (list is! List) {
      throw const FormatException('Daftar murid tidak lengkap');
    }

    return StudentListResponseModel(
      success: json['success'] == true,
      data: list
          .map((e) => StudentModel.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

/// Jawaban POST dan PUT /api/students, serta replace-card (memuat old_uid)
class StudentActionResponseModel {
  const StudentActionResponseModel({
    required this.success,
    required this.data,
    this.oldUid,
  });

  final bool success;
  final StudentModel data;
  final String? oldUid;

  factory StudentActionResponseModel.fromJson(String str) =>
      StudentActionResponseModel.fromMap(jsonDecode(str));

  factory StudentActionResponseModel.fromMap(Map<String, dynamic> json) {
    final data = json['data'];

    if (data is! Map) {
      throw const FormatException('Jawaban murid tidak lengkap');
    }

    final old = json['old_uid'];

    return StudentActionResponseModel(
      success: json['success'] == true,
      data: StudentModel.fromMap(Map<String, dynamic>.from(data)),
      oldUid: old is String ? old : null,
    );
  }
}
