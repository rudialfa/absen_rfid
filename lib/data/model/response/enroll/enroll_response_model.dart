import 'dart:convert';

/// Kartu yang tertangkap perangkat saat mode daftar
class EnrollCapturedModel {
  const EnrollCapturedModel({
    required this.uid,
    required this.registered,
    this.ownerType,
    this.ownerName,
  });

  final String uid;
  final bool registered; // true = kartu sudah dipakai murid atau guru
  final String? ownerType; // student | teacher
  final String? ownerName;

  factory EnrollCapturedModel.fromMap(Map<String, dynamic> json) {
    final uid = json['uid'];
    final registered = json['registered'];

    if (uid is! String || registered is! bool) {
      throw const FormatException('Data kartu tidak lengkap');
    }

    final type = json['owner_type'];
    final name = json['student'];

    return EnrollCapturedModel(
      uid: uid,
      registered: registered,
      ownerType: type is String ? type : null,
      ownerName: name is String ? name : null,
    );
  }
}

/// Jawaban POST /api/enroll/start
class EnrollStartResponseModel {
  const EnrollStartResponseModel({
    required this.success,
    required this.active,
    required this.expiresIn,
  });

  final bool success;
  final bool active;
  final int expiresIn;

  factory EnrollStartResponseModel.fromJson(String str) =>
      EnrollStartResponseModel.fromMap(jsonDecode(str));

  factory EnrollStartResponseModel.fromMap(Map<String, dynamic> json) {
    final active = json['active'];
    final expires = json['expires_in'];

    if (active is! bool || expires is! int) {
      throw const FormatException('Jawaban scan tidak lengkap');
    }

    return EnrollStartResponseModel(
      success: json['success'] == true,
      active: active,
      expiresIn: expires,
    );
  }
}

/// Jawaban GET /api/enroll/status
class EnrollStatusResponseModel {
  const EnrollStatusResponseModel({
    required this.success,
    required this.active,
    required this.expiresIn,
    this.captured,
    this.cardTokenConfirmed,
  });

  final bool success;
  final bool active;
  final int expiresIn;
  final EnrollCapturedModel? captured;

  /// null = tidak ada token tertunda, false = menunggu ESP32, true = token tertulis
  final bool? cardTokenConfirmed;

  factory EnrollStatusResponseModel.fromJson(String str) =>
      EnrollStatusResponseModel.fromMap(jsonDecode(str));

  factory EnrollStatusResponseModel.fromMap(Map<String, dynamic> json) {
    final active = json['active'];
    final expires = json['expires_in'];

    if (active is! bool || expires is! int) {
      throw const FormatException('Status scan tidak lengkap');
    }

    final captured = json['captured'];
    final token = json['card_token'];
    final confirmed = token is Map ? token['confirmed'] : null;

    return EnrollStatusResponseModel(
      success: json['success'] == true,
      active: active,
      expiresIn: expires,
      captured: captured is Map
          ? EnrollCapturedModel.fromMap(Map<String, dynamic>.from(captured))
          : null,
      cardTokenConfirmed: confirmed is bool ? confirmed : null,
    );
  }
}
