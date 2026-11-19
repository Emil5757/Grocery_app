import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

/// The signed-in user (demo data until there is a backend).
class UserModel {
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.phone,
    required this.gender,
    required this.birthday,
    this.avatar = AppAssets.avatarRonti,
  });

  final String firstName;
  final String lastName;
  final String id;
  final String phone;
  final String gender;
  final String birthday;
  final String avatar;

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';

  static const demo = UserModel(
    firstName: 'Shakibul',
    lastName: 'Islam',
    id: '1540580',
    phone: '+8801710000000',
    gender: 'Male',
    birthday: '05.09.1990',
  );
}

enum ProfileAction {
  orders,
  voucher,
  address,
  myProfile,
  notification,
  setting,
  payment,
  logOut,
}

/// One entry of the profile quick-action card or menu list.
class ProfileMenuItem {
  const ProfileMenuItem({required this.icon, required this.label, required this.action});

  final String icon;
  final String label;
  final ProfileAction action;

  static const List<ProfileMenuItem> quickActions = [
    ProfileMenuItem(icon: AppAssets.icProfileOrders, label: AppTexts.allOrder, action: ProfileAction.orders),
    ProfileMenuItem(icon: AppAssets.icProfileVoucher, label: AppTexts.voucher, action: ProfileAction.voucher),
    ProfileMenuItem(icon: AppAssets.icProfileAddress, label: AppTexts.address, action: ProfileAction.address),
  ];

  static const List<ProfileMenuItem> menu = [
    ProfileMenuItem(icon: AppAssets.icProfileUser, label: AppTexts.myProfile, action: ProfileAction.myProfile),
    ProfileMenuItem(icon: AppAssets.icProfileBell, label: AppTexts.notification, action: ProfileAction.notification),
    ProfileMenuItem(icon: AppAssets.icProfileSetting, label: AppTexts.setting, action: ProfileAction.setting),
    ProfileMenuItem(icon: AppAssets.icProfileWallet, label: AppTexts.payment, action: ProfileAction.payment),
    ProfileMenuItem(icon: AppAssets.icProfileLogout, label: AppTexts.logOut, action: ProfileAction.logOut),
  ];
}

enum SettingAction { language, changePassword, editHomeAddress, location, profileSettings, deactivate }

class SettingItem {
  const SettingItem(this.label, this.action);

  final String label;
  final SettingAction action;

  static const List<SettingItem> all = [
    SettingItem(AppTexts.language, SettingAction.language),
    SettingItem(AppTexts.changePassword, SettingAction.changePassword),
    SettingItem(AppTexts.editHomeAddress, SettingAction.editHomeAddress),
    SettingItem(AppTexts.location, SettingAction.location),
    SettingItem(AppTexts.profileSettings, SettingAction.profileSettings),
    SettingItem(AppTexts.deactivateAccount, SettingAction.deactivate),
  ];
}

/// "Select Language" lists (copy kept as in the design: country names).
abstract final class LanguageModel {
  static const List<String> suggested = ['Bangladesh', 'Canada', 'Australia', 'United States'];
  static const List<String> all = [
    'Bangladesh', 'Canada', 'Australia', 'Cuba', 'Span', 'Greece', 'United States',
  ];
}
