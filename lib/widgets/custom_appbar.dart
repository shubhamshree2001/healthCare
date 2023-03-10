import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';

import '../theme/app_color.dart';

class CustomAppbar extends GetWidget implements PreferredSizeWidget {
  final VoidCallback voidCallback;
  const CustomAppbar({Key? key, required this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorAppBar,
      elevation: 0,
      leading: IconButton(
        splashRadius: 18,
        icon: ImagesConstant.back.toSvg(),
        onPressed: voidCallback,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0.h);
}

class CustomDarkAppbar extends GetWidget implements PreferredSizeWidget {
  final VoidCallback voidCallback;
  const CustomDarkAppbar({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DarkThemeAppColors.colorAppBar,
      elevation: 0,
      leading: IconButton(
        splashRadius: 18,
        icon: ImagesConstant.back.toSvg(color: DarkThemeAppColors.colorWhite),
        onPressed: voidCallback,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0.h);
}

class CustomDarkCloseAppbar extends GetWidget implements PreferredSizeWidget {
  final VoidCallback voidCallback;
  const CustomDarkCloseAppbar({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: DarkThemeAppColors.colorAppBar,
      elevation: 0,
      leading: IconButton(
        splashRadius: 18,
        icon: Icon(
          Icons.close,
          color: AppColors.colorWhite,
        ),
        onPressed: voidCallback,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0.h);
}

class SettingCustomAppbar extends GetWidget implements PreferredSizeWidget {
  final VoidCallback voidCallback;
  const SettingCustomAppbar({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorBlueChalk,
      elevation: 0,
      leading: IconButton(
        splashRadius: 18,
        icon:
            const Icon(Icons.arrow_back, color: AppColors.colorBlack, size: 24),
        onPressed: voidCallback,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(76.0.h);
}

class CommunityCustomAppbar extends GetWidget implements PreferredSizeWidget {
  final VoidCallback voidCallback;
  const CommunityCustomAppbar({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorWhite,
      elevation: 0,
      actions: [
        IconButton(
          splashRadius: 18,
          icon: const Icon(Icons.close, color: AppColors.colorBlack, size: 30),
          onPressed: voidCallback,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(76.0.h);
}
