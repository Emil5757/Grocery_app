import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Labelled input from Log In / Sign up / Profile: grey label above a white
/// box with a light border. `isPassword` adds the eye toggle.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.maxLines = 1,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final int maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure = widget.isPassword;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius8.r),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.label14Grey),
          10.verticalSpace,
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          obscureText: _obscure,
          obscuringCharacter: '*',
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          style: AppTextStyles.body16Regular,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
            errorStyle: AppTextStyles.caption12Regular.copyWith(color: AppColors.error),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.textPrimary,
                      size: AppSizes.icon20.r,
                    ),
                  )
                : widget.suffix,
          ),
        ),
      ],
    );
  }
}
