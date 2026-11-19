import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/address/address_cubit.dart';
import '../../../common/models/address_model.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/validator_utils.dart';

/// "New Address" form. With `editIndex` it edits a saved address instead.
class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key, this.editIndex});

  final int? editIndex;

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _line1 = TextEditingController();
  final _line2 = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _zip = TextEditingController();
  bool _makeDefault = true;

  AddressModel? _editing;

  @override
  void initState() {
    super.initState();
    final i = widget.editIndex;
    if (i == null) return;
    final a = context.read<AddressCubit>().state.addresses[i];
    _editing = a;
    _name.text = a.fullName;
    _phone.text = a.phone;
    _line1.text = a.title;
    _line2.text = a.address;
    _city.text = a.city;
    _state.text = a.state;
    _zip.text = a.zipCode;
  }

  @override
  void dispose() {
    for (final c in [_name, _phone, _line1, _line2, _city, _state, _zip]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    final city = _city.text.trim();
    final line1 = _line1.text.trim();
    final address = AddressModel(
      title: city.isEmpty || line1.contains(city) ? line1 : '$line1, $city',
      address: _line2.text.trim(),
      phone: _phone.text.trim(),
      fullName: _name.text.trim(),
      city: city,
      state: _state.text.trim(),
      zipCode: _zip.text.trim(),
      location: _editing?.location ?? AddressModel.chhatak,
    );
    final cubit = context.read<AddressCubit>();
    if (widget.editIndex != null) {
      cubit.update(widget.editIndex!, address);
      if (_makeDefault) cubit.select(widget.editIndex!);
    } else {
      cubit.add(address, makeDefault: _makeDefault);
    }
    Go.back(context);
  }

  Widget _field(String label, TextEditingController c, {FormFieldValidator<String>? validator, TextInputType? type}) =>
      CustomTextField(
        label: label,
        controller: c,
        validator: validator,
        keyboardType: type,
        textInputAction: TextInputAction.next,
      );

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.newAddress,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _field(AppTexts.fullName, _name, validator: ValidatorUtils.required),
            20.verticalSpace,
            _field(AppTexts.phoneNumber, _phone, validator: ValidatorUtils.phone, type: TextInputType.phone),
            20.verticalSpace,
            _field(AppTexts.addressLine1, _line1, validator: ValidatorUtils.required),
            20.verticalSpace,
            _field(AppTexts.addressLine2, _line2),
            20.verticalSpace,
            _field(AppTexts.city, _city, validator: ValidatorUtils.required),
            20.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _field(AppTexts.state, _state)),
                20.horizontalSpace,
                Expanded(child: _field(AppTexts.zipCode, _zip, type: TextInputType.number)),
              ],
            ),
            24.verticalSpace,
            InkWell(
              onTap: () => setState(() => _makeDefault = !_makeDefault),
              child: Row(
                children: [
                  Icon(
                    _makeDefault ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: _makeDefault ? AppColors.primary : AppColors.textGrey,
                    size: AppSizes.icon24.r,
                  ),
                  14.horizontalSpace,
                  Expanded(child: Text(AppTexts.makeDefaultAddress, style: AppTextStyles.body16Regular)),
                ],
              ),
            ),
            30.verticalSpace,
            CustomButton(text: AppTexts.saveAddress, onTap: _save),
          ],
        ),
      ),
    );
  }
}
