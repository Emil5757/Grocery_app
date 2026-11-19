import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';

/// Where a new photo comes from.
enum PhotoSource { camera, gallery }

/// Wraps `image_picker` + `image_cropper` so pages never touch the plugins.
/// Returns the cropped image as bytes (works on mobile and web), or `null`
/// when the user cancels at any step.
abstract final class ImagePickerUtil {
  static final _picker = ImagePicker();

  /// Pick a photo, then crop it to a square shown as a circle.
  static Future<Uint8List?> pickSquare(
    BuildContext context, {
    required PhotoSource source,
    required String cropTitle,
    int maxSize = 800,
  }) async {
    final picked = await _picker.pickImage(
      source: source == PhotoSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: 2000,
      maxHeight: 2000,
    );
    if (picked == null || !context.mounted) return null;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: maxSize,
      maxHeight: maxSize,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: cropTitle,
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: AppColors.white,
          statusBarLight: false,
          activeControlsWidgetColor: AppColors.primary,
          cropStyle: CropStyle.circle,
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: cropTitle,
          cropStyle: CropStyle.circle,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
        if (context.mounted)
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: const CropperSize(width: 400, height: 400),
          ),
      ],
    );
    return cropped?.readAsBytes();
  }
}
