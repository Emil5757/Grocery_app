import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/onboard_model.dart';
import '../widgets/onboard_next_button.dart';
import '../widgets/onboard_slide.dart';

/// One page for all three onboarding slides. Swiping (or the arrow) changes
/// the picture and text; the arrow's progress ring follows the slide index.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == OnboardModel.pages.length - 1;

  void _next() {
    if (_isLast) {
      Go.replace(context, Pager.welcome);
      return;
    }
    _controller.nextPage(duration: AppDurations.normal, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              74.verticalSpace,
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: OnboardModel.pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) => OnboardSlide(model: OnboardModel.pages[i]),
                ),
              ),
              60.verticalSpace,
              OnboardNextButton(
                progress: (_index + 1) / OnboardModel.pages.length,
                onTap: _next,
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
