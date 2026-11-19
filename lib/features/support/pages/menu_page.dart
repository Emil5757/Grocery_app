import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_cubit.dart';
import '../../../common/widgets/custom_confirm_dialog.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/support_content_model.dart';
import '../widgets/support_scaffold.dart';
import '../widgets/support_tile.dart';

/// "Menu" (Drawer Page in the designs): links to the info pages, with
/// Logout set apart at the bottom.
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Future<void> _handle(BuildContext context, MenuAction action) async {
    switch (action) {
      case MenuAction.aboutUs:
        Go.to(context, Pager.aboutUs);
      case MenuAction.faqs:
        Go.to(context, Pager.faq);
      case MenuAction.terms:
        Go.to(context, Pager.terms);
      case MenuAction.helpCenter:
        Go.to(context, Pager.help);
      case MenuAction.contactUs:
        Go.to(context, Pager.contactUs);
      // TODO: share sheet, store review and privacy page need a plugin or
      // a design first.
      case MenuAction.inviteFriend || MenuAction.rateApp || MenuAction.privacyPolicy:
        context.showSnack(AppTexts.comingSoon);
      case MenuAction.logout:
        final ok = await Go.dialog<bool>(
          context,
          const CustomConfirmDialog(message: AppTexts.logOutConfirm),
        );
        if (ok == true && context.mounted) {
          context.read<CartCubit>().clear();
          Go.removeAll(context, Pager.welcome);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    SupportTile tile(MenuItemModel item) => SupportTile(
          title: item.label,
          onTap: () => _handle(context, item.action),
        );

    return SupportScaffold(
      title: AppTexts.menu,
      children: [
        for (final item in MenuItemModel.items) tile(item),
        // Logout sits 86 px lower than the next row would.
        86.verticalSpace,
        tile(MenuItemModel.logout),
      ],
    );
  }
}
