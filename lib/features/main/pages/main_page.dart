import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/main_nav_bar.dart';

/// Bottom-navigation shell. Tab bodies come from `Pager` so this feature
/// never imports another feature.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: IndexedStack(
          index: _index,
          children: [
            Pager.home,
            Pager.category,
            Pager.favorites(onBack: () => _select(0)),
            // TODO: replace with Pager.profile once the profile designs are built.
            Center(
              child: Text(
                AppTexts.navProfile,
                style: AppTextStyles.headline24Bold,
              ),
            ),
          ],
        ),
        bottomNavigationBar: MainNavBar(
          currentIndex: _index,
          onTabTap: _select,
          onBasketTap: () => Go.to(context, Pager.cart),
        ),
      ),
    );
  }
}
