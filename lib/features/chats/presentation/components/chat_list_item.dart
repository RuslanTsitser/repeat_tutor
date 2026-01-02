import 'package:flutter/cupertino.dart';

import '../../../../core/domain/enums/difficulty_level.dart';
import '../../../../core/domain/models/chat.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

enum ChatListItemStyle {
  badge,
}

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onDeletePressed,
    this.style = ChatListItemStyle.badge,
  });

  final Chat chat;
  final VoidCallback onTap;
  final VoidCallback onDeletePressed;
  final ChatListItemStyle style;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            onDeletePressed();
          },
          trailingIcon: CupertinoIcons.delete,
          child: Text(S.of(context).delete),
        ),
      ],
      builder: (context, animation) => Semantics(
        button: true,
        label: '${chat.topic}. ${chat.lastMessage?.text ?? ''}',
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: _BadgeStyle(
            chat: chat,
          ),
        ),
      ),
    );
  }
}

// Вариант с бейджем уровня
class _BadgeStyle extends StatelessWidget {
  const _BadgeStyle({
    required this.chat,
  });

  final Chat chat;

  static const double _padding = 16.0;
  static const double _borderRadius = 16.0;
  static const double _spacing = 4.0;
  static const double _badgeHorizontalPadding = 8.0;
  static const double _badgeVerticalPadding = 4.0;
  static const double _badgeBorderRadius = 8.0;

  Color _getLevelColor() {
    switch (chat.level) {
      case DifficultyLevel.beginner:
        return const Color(0xFF10B981);
      case DifficultyLevel.elementary:
        return const Color(0xFF22C55E);
      case DifficultyLevel.intermediate:
        return const Color(0xFFF59E0B);
      case DifficultyLevel.upperIntermediate:
        return const Color(0xFFF97316);
      case DifficultyLevel.advanced:
        return const Color(0xFFEF4444);
      case DifficultyLevel.proficiency:
        return const Color(0xFFDC2626);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: _spacing,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    chat.topic,
                    style: AppTextStyle.inter16w500.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _badgeHorizontalPadding,
                      vertical: _badgeVerticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(_badgeBorderRadius),
                    ),
                    child: Text(
                      chat.chatLanguage.localizedName,
                      style: AppTextStyle.inter12w500.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _badgeHorizontalPadding,
                      vertical: _badgeVerticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: _getLevelColor().withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(_badgeBorderRadius),
                    ),
                    child: Text(
                      chat.level.shortLocalizedName,
                      style: AppTextStyle.inter12w600.copyWith(
                        color: _getLevelColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Flexible(
            child: Text(
              chat.lastMessage?.text ?? '',
              style: AppTextStyle.inter14w500.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
