import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/cubits/cart/cart_cubit.dart';
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
      // The cart is read and written from many routes, so it sits above
      // the navigator.
      builder: (_, _) => BlocProvider(
        create: (_) => CartCubit(),
        child: MaterialApp(
          title: AppTexts.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          home: Pager.splash,
        ),
      ),
    );
  }
}
