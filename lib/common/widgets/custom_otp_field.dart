import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Row of rounded digit boxes (Number verification). Focus moves forward on
/// input and back on delete. `onCompleted` fires when every box is filled.
class CustomOtpField extends StatefulWidget {
  const CustomOtpField({
    super.key,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  late final List<TextEditingController> _controllers =
      List.generate(widget.length, (_) => TextEditingController());
  late final List<FocusNode> _nodes = List.generate(widget.length, (_) => FocusNode());

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
    final code = _code;
    widget.onChanged?.call(code);
    if (code.length == widget.length) {
      FocusScope.of(context).unfocus();
      widget.onCompleted?.call(code);
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius24.r),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        return SizedBox.square(
          dimension: 68.r,
          child: TextField(
            controller: _controllers[i],
            focusNode: _nodes[i],
            onChanged: (v) => _onChanged(i, v),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.headline24SemiBold.copyWith(fontSize: 32.sp),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.zero,
              border: _border(AppColors.border),
              enabledBorder: _border(AppColors.border),
              focusedBorder: _border(AppColors.primary),
            ),
          ),
        );
      }),
    );
  }
}
