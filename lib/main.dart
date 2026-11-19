import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/cubits/address/address_cubit.dart';
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
      // Cart and saved addresses are read and written from many routes, so
      // they sit above the navigator.
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => AddressCubit()),
        ],
        child: MaterialApp(
          title: AppTexts.appName,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          home: Pager.splash,
          onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => Pager.error()),
        ),
      ),
    );
  }
}
