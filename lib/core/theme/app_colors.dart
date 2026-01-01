import 'package:flutter/material.dart';

/// Централизованные цвета для всего приложения.
///
/// Пример использования:
/// ```dart
/// Container(
///   color: AppColors.colorFF5856D6,
/// )
/// ```
class AppColors {
  AppColors._();

  // Primary Colors
  /// Индиго (Indigo) - основной цвет приложения
  static const Color colorFF5856D6 = Color(0xFF5856D6);

  // Background Colors
  /// Белый (White) - светлый фон
  static const Color colorFFFFFFFF = Color(0xFFFFFFFF);

  /// Светло-синий (Blue 50) - светло-синий фон
  static const Color colorFFEFF6FF = Color(0xFFEFF6FF);

  // Text Colors
  /// Серый текст (Text Gray) - вторичный текст
  static const Color colorFF8E8E93 = Color(0xFF8E8E93);
}
