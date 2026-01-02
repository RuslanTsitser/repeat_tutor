import 'package:flutter/material.dart';

/// Централизованные цвета для всего приложения.
///
/// Цветовая система построена вокруг ощущения спокойной поддержки,
/// интеллектуального AI и мягкой мотивации к действию.
///
/// Пример использования:
/// ```dart
/// Container(
///   color: AppColors.primary,
/// )
/// ```
class AppColors {
  AppColors._();

  static const Color transparent = Color(0x00000000);

  // Brand Colors

  /// Primary - основной цвет для CTA, действий и премиум элементов
  /// Используется экономно для кнопок, активных состояний
  static const Color primary = Color(0xFF7B6CF6);

  /// Accent Blue - цвет поддержки, спокойствия, обучения
  /// Используется для иконок преимуществ, иллюстраций, визуальных акцентов
  static const Color accentBlue = Color(0xFF6FAAF5);

  // Background & Surface Colors

  /// Background Light - основной фон экранов (Paywall, Onboarding)
  static const Color backgroundLight = Color(0xFFF7F8FC);

  /// Surface / Card - карточки, контейнеры, модальные окна
  static const Color surface = Color(0xFFFFFFFF);

  /// Divider / Border - разделители, обводки, неактивные состояния
  static const Color divider = Color(0xFFE6E9F0);

  // Text Colors

  /// Primary Text - заголовки, основной текст
  static const Color textPrimary = Color(0xFF1F2430);

  /// Secondary Text - пояснения, подписи, вторичный текст
  static const Color textSecondary = Color(0xFF6B7280);

  /// Muted / Disabled Text - неактивные элементы, служебные подписи
  static const Color textMuted = Color(0xFF8E8E93);

  // CTA States

  /// Primary CTA Pressed / Active - состояние нажатия основной кнопки
  static const Color primaryCtaPressed = Color(0xFF6A5BE0);

  /// Secondary CTA Background - фон вторичной кнопки
  static const Color secondaryCtaBackground = Color(0xFFF0F2F8);
}
