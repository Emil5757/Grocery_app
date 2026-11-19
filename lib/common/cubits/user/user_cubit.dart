import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_data.dart';
import '../../models/user_model.dart';

/// The signed-in user. Profile, Edit Profile, Change Phone and Profile Photo
/// all read or change it, so the Cubit is app-wide (provided above
/// `MaterialApp`).
class UserCubit extends Cubit<UserModel> {
  UserCubit([UserModel? user]) : super(user ?? UserData.demo);

  /// Saves the Profile form.
  void updateInfo({
    required String firstName,
    required String lastName,
    required String gender,
    required String birthday,
  }) => emit(
    state.copyWith(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      gender: gender.trim(),
      birthday: birthday,
    ),
  );

  void updatePhone(String phone) => emit(state.copyWith(phone: phone.trim()));

  void setPhoto(Uint8List bytes) => emit(state.copyWith(photo: bytes));

  void removePhoto() => emit(state.copyWith(clearPhoto: true));

  /// Log out: back to the mock user.
  void reset() => emit(UserData.demo);
}
