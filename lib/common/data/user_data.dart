import '../../core/constants/app_assets.dart';
import '../models/user_model.dart';

/// Mock signed-in user (no backend yet). Edit these to change what Profile
/// shows on start; edits made in the app live in `UserCubit`.
abstract final class UserData {
  static const UserModel demo = UserModel(
    firstName: 'Shakibul',
    lastName: 'Islam',
    id: '1540580',
    phone: '+8801710000000',
    gender: 'Male',
    birthday: '05.09.1990',
    avatar: AppAssets.avatarRonti,
  );
}
