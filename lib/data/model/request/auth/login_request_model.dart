import 'dart:convert';

class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  String toJson() => jsonEncode({
        'email': email.trim(),
        'password': password,
      });
}