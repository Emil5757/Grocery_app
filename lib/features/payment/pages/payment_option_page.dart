import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/payment_model.dart';
import '../widgets/bank_card.dart';
import '../widgets/payment_option_tile.dart';

/// "Payment Option": saved cards in a horizontal strip with a "+" to add
/// one, then PayPal / Cash On Delivery / Apple Pay.
class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  // TODO: load and save cards through a repository once a backend exists.
  final List<SavedCardModel> _cards = [...SavedCardModel.demo];

  Future<void> _addCard() async {
    final card = await Go.to<SavedCardModel>(context, Pager.addCard);
    if (card == null || !mounted) return;
    setState(() => _cards.insert(0, card));
    context.showSnack(AppTexts.cardAdded);
  }

  @override
  Widget build(BuildContext context) {
    final side = AppSizes.pagePadding.w;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(title: AppTexts.paymentOption),
        body: ListView(
          padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: side),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppTexts.myCard,
                      style: AppTextStyles.section18Bold,
                    ),
                  ),
                  Material(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                    child: InkWell(
                      onTap: _addCard,
                      borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                      child: SizedBox(
                        width: 40.w,
                        height: 32.w,
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 24.r,
                          semanticLabel: AppTexts.addNewCard,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            22.verticalSpace,
            SizedBox(
              height: 190.w,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: side),
                itemCount: _cards.length,
                separatorBuilder: (_, _) => 20.horizontalSpace,
                // The next card is drawn a little shorter and centred, as in
                // the design.
                itemBuilder: (_, i) => Center(
                  child: BankCard(card: _cards[i], height: i == 0 ? 190 : 170),
                ),
              ),
            ),
            50.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: side),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.otherPaymentOption,
                    style: AppTextStyles.section18Bold,
                  ),
                  20.verticalSpace,
                  for (final option in OtherPaymentModel.all) ...[
                    PaymentOptionTile(option: option),
                    14.verticalSpace,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
