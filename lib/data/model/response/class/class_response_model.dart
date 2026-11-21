import 'dart:convert';

class ClassModel {
  const ClassModel({
    required this.id,
    required this.name,
    required this.studentCount,
  });

  final int id;
  final String name;
  final int studentCount;

  factory ClassModel.fromMap(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final count = json['student_count'];

    if (id is! int || name is! String || count is! int) {
      throw const FormatException('Data kelas tidak lengkap');
    }

    return ClassModel(id: id, name: name, studentCount: count);
  }

  @override
  bool operator ==(Object other) =>
      other is ClassModel &&
      other.id == id &&
      other.name == name &&
      other.studentCount == studentCount;

  @override
  int get hashCode => Object.hash(id, name, studentCount);
}

/// Jawaban GET /api/classes
class ClassListResponseModel {
  const ClassListResponseModel({required this.success, required this.data});

  final bool success;
  final List<ClassModel> data;

  factory ClassListResponseModel.fromJson(String str) =>
      ClassListResponseModel.fromMap(jsonDecode(str));

  factory ClassListResponseModel.fromMap(Map<String, dynamic> json) {
    final list = json['data'];

    if (list is! List) {
      throw const FormatException('Daftar kelas tidak lengkap');
    }

    return ClassListResponseModel(
      success: json['success'] == true,
      data: list
          .map((e) => ClassModel.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}
