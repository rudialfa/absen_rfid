import 'dart:convert';

/// POST /api/students
/// class_id diutamakan. Kalau tidak ada, kelas dicari atau dibuat dari nama.
class StudentCreateRequestModel {
  final String name;
  final int? classId;
  final String? className;
  final String rfidUid;

  StudentCreateRequestModel({
    required this.name,
    this.classId,
    this.className,
    required this.rfidUid,
  });

  String toJson() {
    final cls = (className ?? '').trim();

    return jsonEncode({
      'name': name.trim(),
      'rfid_uid': rfidUid.trim().toUpperCase(),
      if (classId != null)
        'class_id': classId
      else if (cls.isNotEmpty)
        'class': cls,
    });
  }
}

/// PUT /api/students/{id}. Hanya field yang diisi yang dikirim.
/// UID tidak bisa diubah lewat sini (gunakan ganti kartu).
class StudentUpdateRequestModel {
  final String? name;
  final int? classId;
  final String? className;
  final bool? isActive;

  StudentUpdateRequestModel({
    this.name,
    this.classId,
    this.className,
    this.isActive,
  });

  bool get isEmpty =>
      name == null &&
      classId == null &&
      (className == null || className!.trim().isEmpty) &&
      isActive == null;

  String toJson() {
    final cls = (className ?? '').trim();

    return jsonEncode({
      if (name != null) 'name': name!.trim(),
      if (classId != null)
        'class_id': classId
      else if (cls.isNotEmpty)
        'class': cls,
      if (isActive != null) 'is_active': isActive,
    });
  }
}
