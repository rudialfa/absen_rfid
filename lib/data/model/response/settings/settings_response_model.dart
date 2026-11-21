import 'dart:convert';

class SettingsModel {
  const SettingsModel({
    required this.lateTime,
    required this.checkoutStart,
    required this.cooldownSeconds,
    required this.lcdIdle,
    required this.requireCardToken,
  });

  final String lateTime; // HH:MM, batas terlambat
  final String checkoutStart; // HH:MM, mulai jam pulang
  final int cooldownSeconds; // diambil ESP32
  final String lcdIdle; // diambil ESP32
  final bool requireCardToken;

  factory SettingsModel.fromMap(Map<String, dynamic> json) {
    final lateTime = json['late_time'];
    final checkoutStart = json['checkout_start'];
    final cooldownSeconds = json['cooldown_seconds'];
    final lcdIdle = json['lcd_idle'];
    final requireCardToken = json['require_card_token'];

    if (lateTime is! String ||
        checkoutStart is! String ||
        cooldownSeconds is! int ||
        lcdIdle is! String ||
        requireCardToken is! bool) {
      throw const FormatException('Data setelan tidak lengkap');
    }

    return SettingsModel(
      lateTime: lateTime,
      checkoutStart: checkoutStart,
      cooldownSeconds: cooldownSeconds,
      lcdIdle: lcdIdle,
      requireCardToken: requireCardToken,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is SettingsModel &&
      other.lateTime == lateTime &&
      other.checkoutStart == checkoutStart &&
      other.cooldownSeconds == cooldownSeconds &&
      other.lcdIdle == lcdIdle &&
      other.requireCardToken == requireCardToken;

  @override
  int get hashCode => Object.hash(
        lateTime,
        checkoutStart,
        cooldownSeconds,
        lcdIdle,
        requireCardToken,
      );
}

/// Jawaban GET dan PUT /api/settings
class SettingsResponseModel {
  const SettingsResponseModel({required this.success, required this.data});

  final bool success;
  final SettingsModel data;

  factory SettingsResponseModel.fromJson(String str) =>
      SettingsResponseModel.fromMap(jsonDecode(str));

  factory SettingsResponseModel.fromMap(Map<String, dynamic> json) {
    final data = json['data'];

    if (data is! Map) {
      throw const FormatException('Jawaban setelan tidak lengkap');
    }

    return SettingsResponseModel(
      success: json['success'] == true,
      data: SettingsModel.fromMap(Map<String, dynamic>.from(data)),
    );
  }
}
