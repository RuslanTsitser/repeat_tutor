import 'package:ab_test_service/ab_test_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/localization/generated/l10n.dart';
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
  String productLabel(S localizations) {
    final subscriptionPeriod = this.subscriptionPeriod;
    return switch (subscriptionPeriod) {
      DefaultSubscriptionPeriodEnum.week => localizations.week,
      DefaultSubscriptionPeriodEnum.month => localizations.month,
      DefaultSubscriptionPeriodEnum.year => localizations.year,
      _ => '',
    };
  }

  /// Возвращает полный лейбл периода (Weekly, Monthly, Yearly)
  String productLabelFull(S localizations) {
    final subscriptionPeriod = this.subscriptionPeriod;
    return switch (subscriptionPeriod) {
      DefaultSubscriptionPeriodEnum.week => localizations.weekly,
      DefaultSubscriptionPeriodEnum.month => localizations.monthly,
      DefaultSubscriptionPeriodEnum.year => localizations.yearly,
      _ => '',
    };
  }
}

/// Экстеншен для получения текстового лейбла периода по количеству дней
extension PeriodLabelExtension on int {
  /// Возвращает текстовый лейбл периода (week, month, year)
  String periodLabel(S localizations) {
    if (this == 7) return localizations.week;
    if (this == 30) return localizations.month;
    if (this == 365) return localizations.year;
    return localizations.period;
  }
}
