import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/user/user_cubit.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_outlined_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/image_picker_util.dart';

/// "Profile Photo": preview in a green ring, take or choose a photo (then
/// crop it to a circle), remove it, and Save to `UserCubit`.
class ProfilePhotoPage extends StatefulWidget {
  const ProfilePhotoPage({super.key});

  @override
  State<ProfilePhotoPage> createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  /// Photo being edited; starts as the saved one.
  late Uint8List? _photo = context.read<UserCubit>().state.photo;
  bool _busy = false;

  bool get _changed =>
      !identical(_photo, context.read<UserCubit>().state.photo);

  Future<void> _pick(PhotoSource source) async {
    setState(() => _busy = true);
    try {
      final bytes = await ImagePickerUtil.pickSquare(
        context,
        source: source,
        cropTitle: AppTexts.cropPhoto,
      );
      if (bytes != null && mounted) setState(() => _photo = bytes);
    } catch (_) {
      // Permission denied, no camera, plugin missing on this platform...
      if (mounted) context.showSnack(AppTexts.photoPickFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _save() {
    final cubit = context.read<UserCubit>();
    final photo = _photo;
    photo == null ? cubit.removePhoto() : cubit.setPhoto(photo);
    context.showSnack(AppTexts.photoUpdated);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return CustomCardScaffold(
      title: AppTexts.profilePhoto,
      cardPadding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 30.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: CustomAvatar(
                image: user.avatar,
                photo: _photo,
                size: 180,
                background: AppColors.avatarPink,
              ),
            ),
          ),
          24.verticalSpace,
          Text(
            user.fullName,
            textAlign: TextAlign.center,
            style: AppTextStyles.headline24Bold,
          ),
          10.verticalSpace,
          Text(
            AppTexts.profilePhotoHint,
            textAlign: TextAlign.center,
            style: AppTextStyles.body16Grey,
          ),
          36.verticalSpace,
          CustomButton(
            text: AppTexts.takePhoto,
            icon: Icon(
              Icons.photo_camera_outlined,
              color: AppColors.white,
              size: 22.r,
            ),
            onTap: _busy ? null : () => _pick(PhotoSource.camera),
          ),
          16.verticalSpace,
          CustomOutlinedButton(
            text: AppTexts.chooseFromGallery,
            textStyle: AppTextStyles.body16SemiBold.copyWith(
              color: AppColors.primary,
            ),
            onTap: _busy ? null : () => _pick(PhotoSource.gallery),
          ),
          if (_photo != null) ...[
            8.verticalSpace,
            TextButton(
              onPressed: _busy ? null : () => setState(() => _photo = null),
              child: Text(
                AppTexts.removePhoto,
                style: AppTextStyles.body16Medium.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ],
          24.verticalSpace,
          CustomButton(
            text: AppTexts.save,
            onTap: _changed && !_busy ? _save : null,
          ),
        ],
      ),
    );
  }
}
