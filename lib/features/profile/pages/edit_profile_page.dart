import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';
import '../data/models/profile_model.dart';

/// "Profile" form (My Profile). Phone and password open their own change
/// screens.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final _first = TextEditingController(text: _user.firstName);
  late final _last = TextEditingController(text: _user.lastName);
  late final _phone = TextEditingController(text: _user.phone);
  late final _gender = TextEditingController(text: _user.gender);
  late final _birthday = TextEditingController(text: _user.birthday);
  final _password = TextEditingController(text: '**********');

  static const _user = UserModel.demo;

  @override
  void dispose() {
    for (final c in [_first, _last, _phone, _gender, _birthday, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 9, 5),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked == null) return;
    String two(int v) => v.toString().padLeft(2, '0');
    _birthday.text = '${two(picked.day)}.${two(picked.month)}.${picked.year}';
  }

  void _save() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    // TODO: send to the backend once it exists.
    context.showSnack(AppTexts.profileSaved);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.profile,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(label: AppTexts.firstName, controller: _first, validator: ValidatorUtils.required),
            24.verticalSpace,
            CustomTextField(label: AppTexts.lastName, controller: _last, validator: ValidatorUtils.required),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.phoneNumber,
              controller: _phone,
              readOnly: true,
              onTap: () => Go.to(context, Pager.changePhone),
            ),
            24.verticalSpace,
            CustomTextField(label: AppTexts.gender, controller: _gender),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.birthday,
              controller: _birthday,
              readOnly: true,
              onTap: _pickBirthday,
            ),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.password,
              controller: _password,
              readOnly: true,
              onTap: () => Go.to(context, Pager.changePassword),
            ),
            30.verticalSpace,
            CustomButton(text: AppTexts.save, onTap: _save),
          ],
        ),
      ),
    );
  }
}
