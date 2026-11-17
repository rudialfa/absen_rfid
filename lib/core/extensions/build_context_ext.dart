import 'package:flutter/material.dart';

import '../constants/colors.dart';

extension BuildContextExt on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;
}

extension AlertDialogExt on BuildContext {
  void showDialogSuccess(String title, String subtitle) {
    _showCustomDialog(
      title: title,
      subtitle: subtitle,
      icon: Icons.check_circle_outline,
      color: AppColors.success,
    );
  }

  void showDialogError(String title, String subtitle) {
    _showCustomDialog(
      title: title,
      subtitle: subtitle,
      icon: Icons.error_outline,
      color: AppColors.error,
    );
  }

  void _showCustomDialog({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 90, color: color),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.gray),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension NavigatorExt on BuildContext {
  void pop<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }

  void popToRoot() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }

  Future<T?> push<T extends Object?>(Widget widget, [String? name]) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: name),
      ),
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget widget,
  ) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget widget,
    bool Function(Route<dynamic> route) predicate,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }
}
