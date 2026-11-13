import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_sizes.dart';
import 'core/constants/app_texts.dart';
import 'core/constants/app_themes.dart';
import 'core/navigation/pager.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(AppSizes.designWidth, AppSizes.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        title: AppTexts.appName,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        home: Pager.splash,
      ),
    );
  }
}
