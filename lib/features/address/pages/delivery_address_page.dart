import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/address/address_cubit.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_circle_icon_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/address_tile.dart';

/// Saved addresses (select / edit / delete) with a "+" to add one.
class DeliveryAddressPage extends StatelessWidget {
  const DeliveryAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.deliveryAddress,
      expand: true,
      cardPadding: EdgeInsets.fromLTRB(20.w, 30.h, 12.w, 30.h),
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 18.r, offset: Offset(0, 8.h))],
        ),
        child: CustomCircleIconButton(
          icon: Icons.add,
          size: 56,
          iconSize: 32,
          onTap: () => Go.to(context, Pager.newAddress()),
        ),
      ),
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          final cubit = context.read<AddressCubit>();
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 80.h),
            itemCount: state.addresses.length,
            itemBuilder: (_, i) => AddressTile(
              address: state.addresses[i],
              selected: i == state.selected,
              onSelect: () => cubit.select(i),
              onEdit: () => Go.to(context, Pager.newAddress(editIndex: i)),
              onDelete: () => cubit.remove(i),
            ),
          );
        },
      ),
    );
  }
}
