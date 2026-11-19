import 'dart:typed_data';

/// The signed-in user. Profile, Edit Profile, Change Phone and the profile
/// photo page read and change it through `UserCubit`, so it lives in
/// `common/`. Mock data: `UserData`.
class UserModel {
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.avatar,
    this.photo,
  });

  final String firstName;
  final String lastName;
  final String id;
  final String phone;
  final String gender;

  /// dd.MM.yyyy, as on the Profile form.
  final String birthday;

  /// Default portrait (asset path), shown until the user picks a photo.
  final String avatar;

  /// Cropped photo the user picked (PNG/JPEG bytes). Bytes rather than a
  /// file path so it works on web too.
  final Uint8List? photo;

  String get fullName => '$firstName $lastName';
  String get initials =>
      '${firstName.isEmpty ? '' : firstName[0]}${lastName.isEmpty ? '' : lastName[0]}';

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? gender,
    String? birthday,
    Uint8List? photo,
    bool clearPhoto = false,
  }) => UserModel(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    id: id,
    phone: phone ?? this.phone,
    gender: gender ?? this.gender,
    birthday: birthday ?? this.birthday,
    avatar: avatar,
    photo: clearPhoto ? null : (photo ?? this.photo),
  );
}
