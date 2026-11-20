import 'dart:convert';

class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  final int id;
  final String name;
  final String email;
  final String role; // admin | teacher | guardian

  factory AuthUserModel.fromMap(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];
    final role = json['role'];

    if (id is! int || name is! String || email is! String || role is! String) {
      throw const FormatException('Data user tidak lengkap');
    }

    return AuthUserModel(id: id, name: name, email: email, role: role);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
      };

  bool get isAdmin => role == 'admin';
  bool get isTeacher => role == 'teacher';
  bool get isGuardian => role == 'guardian';

  String get roleLabel => switch (role) {
        'admin' => 'Admin sekolah',
        'teacher' => 'Guru',
        'guardian' => 'Wali murid',
        _ => 'Peran tidak dikenal',
      };

  @override
  bool operator ==(Object other) =>
      other is AuthUserModel &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.role == role;

  @override
  int get hashCode => Object.hash(id, name, email, role);
}

/// Jawaban POST /api/login
class AuthResponseModel {
  const AuthResponseModel({
    required this.success,
    required this.token,
    required this.user,
  });

  final bool success;
  final String token;
  final AuthUserModel user;

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(jsonDecode(str));

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) {
    final token = json['token'];
    final user = json['user'];

    if (token is! String || token.isEmpty || user is! Map) {
      throw const FormatException('Jawaban login tidak lengkap');
    }

    return AuthResponseModel(
      success: json['success'] == true,
      token: token,
      user: AuthUserModel.fromMap(Map<String, dynamic>.from(user)),
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'token': token,
        'user': user.toMap(),
      };

  /// Yang disimpan hanya token dan data akun, tidak pernah password.
  String toJson() => jsonEncode(toMap());
}

/// Jawaban GET /api/me
class MeResponseModel {
  const MeResponseModel({required this.success, required this.user});

  final bool success;
  final AuthUserModel user;

  factory MeResponseModel.fromJson(String str) =>
      MeResponseModel.fromMap(jsonDecode(str));

  factory MeResponseModel.fromMap(Map<String, dynamic> json) {
    final user = json['user'];

    if (user is! Map) {
      throw const FormatException('Jawaban /me tidak lengkap');
    }

    return MeResponseModel(
      success: json['success'] == true,
      user: AuthUserModel.fromMap(Map<String, dynamic>.from(user)),
    );
  }
}
