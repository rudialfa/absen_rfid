import 'dart:convert';

class DeviceModel {
  const DeviceModel({
    required this.id,
    required this.name,
    this.createdAt,
  });

  final int id;
  final String name;
  final String? createdAt; // ISO 8601

  factory DeviceModel.fromMap(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final created = json['created_at'];

    if (id is! int || name is! String) {
      throw const FormatException('Data perangkat tidak lengkap');
    }

    return DeviceModel(
      id: id,
      name: name,
      createdAt: created is String ? created : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DeviceModel &&
      other.id == id &&
      other.name == name &&
      other.createdAt == createdAt;

  @override
  int get hashCode => Object.hash(id, name, createdAt);
}

/// Jawaban GET /api/devices
class DeviceListResponseModel {
  const DeviceListResponseModel({required this.success, required this.data});

  final bool success;
  final List<DeviceModel> data;

  factory DeviceListResponseModel.fromJson(String str) =>
      DeviceListResponseModel.fromMap(jsonDecode(str));

  factory DeviceListResponseModel.fromMap(Map<String, dynamic> json) {
    final list = json['data'];

    if (list is! List) {
      throw const FormatException('Daftar perangkat tidak lengkap');
    }

    return DeviceListResponseModel(
      success: json['success'] == true,
      data: list
          .map((e) => DeviceModel.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

/// Jawaban POST, PUT, dan rotate-key.
/// [deviceKey] hanya ada saat perangkat dibuat atau key diganti, dan hanya
/// tampil sekali.
class DeviceActionResponseModel {
  const DeviceActionResponseModel({
    required this.success,
    required this.data,
    this.deviceKey,
  });

  final bool success;
  final DeviceModel data;
  final String? deviceKey;

  factory DeviceActionResponseModel.fromJson(String str) =>
      DeviceActionResponseModel.fromMap(jsonDecode(str));

  factory DeviceActionResponseModel.fromMap(Map<String, dynamic> json) {
    final data = json['data'];

    if (data is! Map) {
      throw const FormatException('Jawaban perangkat tidak lengkap');
    }

    final key = json['device_key'];

    return DeviceActionResponseModel(
      success: json['success'] == true,
      data: DeviceModel.fromMap(Map<String, dynamic>.from(data)),
      deviceKey: key is String && key.isNotEmpty ? key : null,
    );
  }
}
