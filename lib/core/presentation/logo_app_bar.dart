import 'package:flutter/cupertino.dart';

import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class LogoAppBar extends StatelessWidget {
  const LogoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.colorFFE5E7EB,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Assets.appIcon.image(width: 48, height: 48),
          const SizedBox(width: 8),
          const Text(
            'Repeat Tutor',
            style: AppTextStyle.inter24w500,
          ),
        ],
      ),
    );
  }
}
