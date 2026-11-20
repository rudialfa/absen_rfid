import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Menyimpan data login di penyimpanan aman Android (Keystore).
class AuthLocalDatsource {
  AuthLocalDatsource({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'auth_data';
  final FlutterSecureStorage _storage;

  Future<void> saveAuthData(AuthResponseModel data) =>
      _storage.write(key: _key, value: data.toJson());

  Future<AuthResponseModel?> getAuthData() async {
    try {
      final raw = await _storage.read(key: _key);
      if (raw == null || raw.isEmpty) return null;
      return AuthResponseModel.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> removeAuthData() => _storage.delete(key: _key);

  Future<bool> isAuth() async => (await getAuthData()) != null;
}
