import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

/// Централизованные стили текста для всего приложения.
/// Использует шрифт Inter с различными размерами и весами.
///
/// Пример использования:
/// ```dart
/// Text(
///   'Hello',
///   style: AppTextStyle.inter12w500,
/// )
/// ```
class AppTextStyle {
  AppTextStyle._();

  // Константы для шрифта
  static const String _fontFamily = FontFamily.inter;
  static const double _lineHeightBody = 1.5;
  static const double _lineHeightTitle = 1.1;

  // Tag/Label - 12px
  static const TextStyle inter12w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightBody,
  );

  static const TextStyle inter12w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightBody,
  );

  static const TextStyle inter12w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightBody,
  );

  static const TextStyle inter12w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightBody,
  );

  // Body Small - 14px
  static const TextStyle inter14w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightBody,
  );

  static const TextStyle inter14w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightBody,
  );

  static const TextStyle inter14w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightBody,
  );

  static const TextStyle inter14w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightBody,
  );

  // Body - 16px
  static const TextStyle inter16w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightBody,
  );

  static const TextStyle inter16w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightBody,
  );

  static const TextStyle inter16w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightBody,
  );

  static const TextStyle inter16w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightBody,
  );

  // Body Large - 18px
  static const TextStyle inter18w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightBody,
  );

  static const TextStyle inter18w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightBody,
  );

  static const TextStyle inter18w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightBody,
  );

  static const TextStyle inter18w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightBody,
  );

  // Title - 20px
  static const TextStyle inter20w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightTitle,
  );

  static const TextStyle inter20w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightTitle,
  );

  static const TextStyle inter20w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightTitle,
  );

  static const TextStyle inter20w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightTitle,
  );

  // Title Large - 24px
  static const TextStyle inter24w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightTitle,
  );

  static const TextStyle inter24w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightTitle,
  );

  static const TextStyle inter24w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightTitle,
  );

  static const TextStyle inter24w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightTitle,
  );

  // Headline - 28px
  static const TextStyle inter28w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightTitle,
  );

  static const TextStyle inter28w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightTitle,
  );

  static const TextStyle inter28w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightTitle,
  );

  static const TextStyle inter28w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightTitle,
  );

  // Headline Large - 32px
  static const TextStyle inter32w400 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w400,
    height: _lineHeightTitle,
  );

  static const TextStyle inter32w500 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w500,
    height: _lineHeightTitle,
  );

  static const TextStyle inter32w600 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    height: _lineHeightTitle,
  );

  static const TextStyle inter32w700 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    height: _lineHeightTitle,
  );

  /// Создает TextStyle с поддержкой динамического масштабирования текста.
  ///
  /// Пример использования:
  /// ```dart
  /// Text(
  ///   'Hello',
  ///   style: AppTextStyle.inter16w500.scaled(context),
  /// )
  /// ```
  static TextStyle scaled(
    BuildContext context,
    TextStyle baseStyle,
  ) {
    final textScaler = MediaQuery.textScalerOf(context);
    final baseFontSize = baseStyle.fontSize ?? 16.0;
    return baseStyle.copyWith(
      fontSize: textScaler.scale(baseFontSize),
    );
  }
}

/// Расширение для TextStyle для удобного использования динамического масштабирования.
extension TextStyleExtension on TextStyle {
  /// Применяет динамическое масштабирование текста на основе системных настроек.
  ///
  /// Пример использования:
  /// ```dart
  /// Text(
  ///   'Hello',
  ///   style: AppTextStyle.inter16w500.scaled(context),
  /// )
  /// ```
  TextStyle scaled(BuildContext context) {
    return AppTextStyle.scaled(context, this);
  }
}
