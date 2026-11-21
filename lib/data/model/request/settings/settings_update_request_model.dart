import 'dart:convert';

/// PUT /api/settings. Hanya field yang diisi yang dikirim.
class SettingsUpdateRequestModel {
  final String? lateTime;
  final String? checkoutStart;
  final int? cooldownSeconds;
  final String? lcdIdle;
  final bool? requireCardToken;

  SettingsUpdateRequestModel({
    this.lateTime,
    this.checkoutStart,
    this.cooldownSeconds,
    this.lcdIdle,
    this.requireCardToken,
  });

  bool get isEmpty =>
      lateTime == null &&
      checkoutStart == null &&
      cooldownSeconds == null &&
      lcdIdle == null &&
      requireCardToken == null;

  String toJson() => jsonEncode({
        if (lateTime != null) 'late_time': lateTime,
        if (checkoutStart != null) 'checkout_start': checkoutStart,
        if (cooldownSeconds != null) 'cooldown_seconds': cooldownSeconds,
        if (lcdIdle != null) 'lcd_idle': lcdIdle,
        if (requireCardToken != null) 'require_card_token': requireCardToken,
      });
}
