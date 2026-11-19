import '../../../../core/constants/app_texts.dart';

/// Static copy for the Menu and its info pages, transcribed from the designs.
/// Swap these for API data once a backend exists.

/// What a Menu row does when tapped.
enum MenuAction {
  inviteFriend,
  aboutUs,
  faqs,
  terms,
  helpCenter,
  rateApp,
  privacyPolicy,
  contactUs,
  logout,
}

class MenuItemModel {
  const MenuItemModel({required this.label, required this.action});

  final String label;
  final MenuAction action;

  /// Rows above the gap.
  static const List<MenuItemModel> items = [
    MenuItemModel(label: AppTexts.inviteFriend, action: MenuAction.inviteFriend),
    MenuItemModel(label: AppTexts.aboutUs, action: MenuAction.aboutUs),
    MenuItemModel(label: AppTexts.faqs, action: MenuAction.faqs),
    MenuItemModel(label: AppTexts.termsAndConditions, action: MenuAction.terms),
    MenuItemModel(label: AppTexts.helpCenter, action: MenuAction.helpCenter),
    MenuItemModel(label: AppTexts.rateThisApp, action: MenuAction.rateApp),
    MenuItemModel(label: AppTexts.privacyPolicy, action: MenuAction.privacyPolicy),
    MenuItemModel(label: AppTexts.contactUs, action: MenuAction.contactUs),
  ];

  /// Sits apart at the bottom.
  static const MenuItemModel logout =
      MenuItemModel(label: AppTexts.logout, action: MenuAction.logout);
}

abstract final class AboutContent {
  static const List<String> paragraphs = [
    'In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum '
        'felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus '
        'elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, '
        'porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus '
        'in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius '
        'laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. '
        'Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus.',
    _maecenas,
    _aliquam,
  ];
}

class FaqModel {
  const FaqModel({required this.question, required this.answer});

  final String question;

  /// One string per paragraph.
  final List<String> answer;

  /// Space above the 2nd, 3rd ... answer paragraph, as drawn in the design
  /// (the last value repeats for longer answers).
  static const List<double> paragraphGaps = [15.6, 27];

  static const List<FaqModel> items = [
    FaqModel(question: 'How it will take to delivery?', answer: [_shortAnswer]),
    FaqModel(
      question: 'What is refund system?',
      answer: [_shortAnswer, _maecenas, _aliquam],
    ),
  ];
}

class TermsSectionModel {
  const TermsSectionModel({required this.title, required this.body});

  final String title;
  final String body;

  /// Two lines, broken where the design breaks them.
  static const String heading = 'General site usage last revised\nDecember 12-01-2020.';

  static const String intro =
      'Welcome to www.saydulmoon.info. Officia irure irure anim nisi exercitation '
      'velit cupidatat qui Lorem id ad. Amet quis occaecat quis voluptate cupidatat '
      'quis irure irure consequat irure.';

  static const List<TermsSectionModel> sections = [
    TermsSectionModel(title: 'Agreement', body: _officia),
    TermsSectionModel(title: 'Account', body: _officia),
    TermsSectionModel(
      title: 'Relationship With Groceries',
      body: '$_officia Officia irure irure anim nisi exercitation velit cupidatat qui '
          'Lorem id ad. Amet quis occaecat quis',
    ),
  ];
}

abstract final class HelpContent {
  static const List<String> topQuestions = [
    'How do I return my items?',
    'How to use collection point?',
    'What is Grocery?',
    'How can i add new delivery address?',
    'How can i avail Sticker Price?',
  ];

  static const List<String> topics = [
    'My Account',
    'Payments & Wallet',
    'Shipping & Delivery',
    'Vouchers & Promotions',
    'Ordering',
  ];
}

abstract final class ContactContent {
  static const List<String> phones = ['+8801710000000', '+8801710000000'];
  static const String email = 'Jonarban45@gmail.com';
  static const String address = '26/C Mohammadpur\nDhaka, Bangladesh';
}

const String _shortAnswer =
    'In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum '
    'felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus '
    'elementum semper nisi.';

const String _maecenas =
    'Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit '
    'amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus '
    'pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. '
    'Donec vitae sapien.';

const String _aliquam =
    'Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus '
    'viverra nulla ut metus varius laoreet.';

const String _officia =
    'Officia irure irure anim nisi exercitation velit cupidatat qui Lorem id ad. '
    'Amet quis occaecat quis voluptate cupidatat quis irure irure consequat irure.';
