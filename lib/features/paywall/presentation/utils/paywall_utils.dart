import 'package:ab_test_service/ab_test_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';

/// Обертка для отображения кнопки закрытия в правом верхнем углу
class CloseButtonWrapper extends StatelessWidget {
  const CloseButtonWrapper({
    super.key,
    required this.child,
    required this.onClose,
  });
  final Widget child;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CupertinoButton(
            color: CupertinoColors.transparent,
            foregroundColor: AppColors.textPrimary,
            onPressed: onClose,
            child: const Icon(CupertinoIcons.xmark),
          ),
        ),
      ],
    );
  }
}

/// Экстеншен для получения лейбла продукта из периода подписки
extension PaywallProductLabelExtension on PaywallProduct {
  /// Возвращает короткий лейбл периода (Week, Month, Year)
  String get productLabel {
    final subscriptionPeriod = this.subscriptionPeriod;
    return switch (subscriptionPeriod) {
      DefaultSubscriptionPeriodEnum.week => 'Week',
      DefaultSubscriptionPeriodEnum.month => 'Month',
      DefaultSubscriptionPeriodEnum.year => 'Year',
      _ => '',
    };
  }

  /// Возвращает полный лейбл периода (Weekly, Monthly, Yearly)
  String get productLabelFull {
    final subscriptionPeriod = this.subscriptionPeriod;
    return switch (subscriptionPeriod) {
      DefaultSubscriptionPeriodEnum.week => 'Weekly',
      DefaultSubscriptionPeriodEnum.month => 'Monthly',
      DefaultSubscriptionPeriodEnum.year => 'Yearly',
      _ => '',
    };
  }
}

/// Экстеншен для получения текстового лейбла периода по количеству дней
extension PeriodLabelExtension on int {
  /// Возвращает текстовый лейбл периода (week, month, year)
  String get periodLabel {
    if (this == 7) return 'week';
    if (this == 30) return 'month';
    if (this == 365) return 'year';
    return 'period';
  }
}
