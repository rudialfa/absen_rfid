import 'dart:convert';

/// POST /api/devices dan PUT /api/devices/{id}
class DeviceNameRequestModel {
  final String name;

  DeviceNameRequestModel({required this.name});

  String toJson() => jsonEncode({'name': name.trim()});
}
