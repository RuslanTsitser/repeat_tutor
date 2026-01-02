import 'package:flutter/cupertino.dart';

import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'pro_button.dart';

class LogoAppBar extends StatelessWidget {
  const LogoAppBar({super.key, this.showProButton = true});
  final bool showProButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Assets.appIcon.image(width: 48, height: 48),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Repeat Tutor',
              style: AppTextStyle.inter24w500,
            ),
          ),
          if (showProButton) const ProButton(),
        ],
      ),
    );
  }
}
