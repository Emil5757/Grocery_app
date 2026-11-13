# eGrocery — "your daily needs"

A grocery shopping app built with Flutter from the designs in `grocery_app_pages/`
(about 65 screens: onboarding, auth, categories, search and filter, product, cart,
checkout, orders, wishlist, profile and support).

The UI comes first and data is local. There is no backend layer yet.

| | |
|---|---|
| Flutter / Dart | 3.44 / 3.12 |
| State | `flutter_bloc` (Cubit only when another route has to read the state, otherwise `setState`) |
| Sizing | `flutter_screenutil`, design frame **414 × 896** |
| Icons | `flutter_svg` |
| Font | **Gilroy** (see [Fonts](#fonts)) |

## Getting started

```bash
flutter pub get
flutter run
```

## Architecture

The app is organised by feature, with three layers. Imports only point inward:

```
features/  ──►  common/  ──►  core/
```

```
lib/
├── main.dart               ScreenUtilInit → MaterialApp(AppThemes.light) → Pager.splash
├── core/                   app-wide foundation; imports nothing from common/ or features/
│   ├── constants/
│   │   ├── app_colors.dart        every colour (sampled from the designs)
│   │   ├── app_text_styles.dart   Gilroy type scale
│   │   ├── app_themes.dart        ThemeData
│   │   ├── app_button_style.dart  ElevatedButton / OutlinedButton styles
│   │   ├── app_sizes.dart         design numbers: padding, radii, heights
│   │   ├── app_assets.dart        every asset path
│   │   ├── app_texts.dart         shared strings
│   │   └── app_durations.dart     animation / splash durations
│   ├── extensions/
│   │   ├── context_extension.dart   context.theme, screenSize, hideKeyboard(), showSnack()
│   │   ├── color_extensions.dart    color.toColorFilter (for SvgPicture)
│   │   └── num_extensions.dart      20.toPrice → "$20"
│   ├── navigation/
│   │   ├── go.dart      Go.to / replace / removeAll / back / sheet / dialog
│   │   └── pager.dart   registry of every page
│   └── utils/
│       └── validator_utils.dart   required, phone, password, confirmPassword, otp
├── common/widgets/         design-system widgets used by 2+ features
└── features/<domain>/
    ├── pages/              <name>_page.dart, one screen each
    ├── widgets/            pieces only this feature uses
    ├── cubits/<x>/         <x>_cubit.dart (+ <x>_state.dart)
    └── data/models/        <x>_model.dart with static const demo lists
```

### Feature folders → design screens

| Feature | Screens |
|---|---|
| `splash` | Onboarding (green logo screen) |
| `onboarding` | Onboarding (1)–(3) |
| `auth` | Login or signup, Log In, Sign up, Number verification, Verification Successful, Forget Password, New Password, Error pages |
| `main` | Bottom nav shell (Home, Menu, Save, Profile, centre cart button) and Drawer |
| `category` | Category, Vegetable Category |
| `search` | Search, Search result, Filter Popup / Full |
| `product` | Product details, Bundle Details, Review page, Comments |
| `cart` | Cart page, Empty Cart, coupons |
| `checkout` | Checkout, Delivery Address, New Address, Payment Method, Order Successfully, Sorry Order is Failed |
| `orders` | My Order (All / Running / Previous), My Order Details, Order Tracking, No order yet, Delivered Successful |
| `wishlist` | Favorite list, Empty wishlist |
| `profile` | Profile, Setting, Change Password, Change phone Number, Language Setting |
| `notification` | Notification |
| `support` | About Us, Contact Us, FAQ, Help, Term & Conditions |

## Design tokens

### Colours (`AppColors`)

| Token | Hex | Used for |
|---|---|---|
| `primary` | `#40AA54` | buttons, prices, active tab, add buttons |
| `primaryDark` | `#369147` | filter button |
| `primaryLight` | `#E8F7EB` | product image background, illustration cards |
| `textPrimary` | `#16162E` | headings and body text |
| `textSecondary` | `#323247` | icons, chevrons |
| `textGrey` | `#A2A2AC` | labels, hints, secondary text |
| `background` | `#F7F7F7` | auth page background, search field |
| `scaffoldGrey` | `#F2F2F2` | grey page behind white cards |
| `divider` / `disabled` | `#ECECEC` | hairlines, disabled button |
| `border` | `#E0E0E0` | input and counter borders |
| `confirmed` | `#4044AA` | order status |
| `shipped` | `#E09605` | order status |
| `error` | `#FF2020` | cancelled order, validation |
| `star` | `#FFC107` | ratings |

### Text styles (`AppTextStyles`)

Names follow `<role><size><weight>`: `display32Bold`, `headline24Bold`,
`title20Bold`, `section18Bold`, `body16Regular`, `body16Grey`, `label14Grey`,
`caption12Regular`, `button18Bold`, `price28Bold`, `oldPrice16` and others.
Every style already applies `.sp`. For a different colour use
`.copyWith(color: …)` instead of adding a new style.

## Common widgets

| Widget | What it is |
|---|---|
| `CustomAppBar` | back arrow, centred title, hairline underneath |
| `CustomButton` | full-width green button; `onTap: null` gives the grey disabled state |
| `CustomOutlinedButton` | bordered button ("See All") |
| `CustomArrowButton` | green square → submit (Log In / Sign up) |
| `CustomTextField` | grey label above a bordered input, with an optional password eye |
| `CustomSearchField` | grey search box, optional green filter button |
| `CustomOtpField` | 4-digit code boxes with auto focus |
| `CustomQuantityCounter` | [–] n [+] |
| `CustomCircleIconButton` | round "+" / heart buttons |
| `CustomPriceText` | struck-through old price followed by the green price |
| `CustomProductCard` | product grid card |
| `CustomWhiteCard` | rounded white panel on a grey page |
| `CustomListTile` | row with a chevron and divider (settings, drawer) |
| `CustomRatingStars` | 5 stars, optionally tappable |
| `CustomChip` | selectable category chip (filter) |
| `CustomRichTextAction` | "Don't Have Account? **Sign up**" |
| `CustomSummaryRow` | label … value row (cart / checkout totals) |
| `CustomDashedDivider` | dashed line above totals |
| `CustomDotsIndicator` | carousel / onboarding dots |
| `CustomEmptyState` | illustration, title, subtitle, button (empty and result screens) |
| `CustomBottomSheet` | handle, [X] / title / action header (Filter) |

Common widgets take plain values and callbacks, never feature models, so
`common/` never imports `features/`.

## Rules

1. **Every visual value is a token.** No `Color(0x…)`, raw `TextStyle(...)` or
   `'assets/...'` string outside `core/constants/`.
2. **Every size is scaled.** Figma numbers go in unchanged with `.w .h .r .sp`,
   and spacing uses `16.verticalSpace` / `12.horizontalSpace`.
3. **Every move goes through `Go` + `Pager`.** No `Navigator.` or `MaterialPageRoute`
   outside `go.dart`.
4. **Imports are relative** inside `lib/`. Use `package:` only for third-party packages.
5. **One feature never imports another.** Navigate through `Pager`, or move the
   shared piece to `common/`.
6. **Promote a widget to `common/widgets/`** when a second feature needs it, not before.

## Adding a page

1. Add any new colours, strings or assets to `core/constants/` first.
2. Put static/demo data in `features/<x>/data/models/<x>_model.dart` as `static const`.
3. Build `features/<x>/pages/<name>_page.dart` from `Custom*` widgets first.
4. Register it in `Pager`, then navigate with `Go.to / replace / removeAll`.
5. Run `flutter analyze`.

## Fonts

All text uses the `Gilroy` family (`AppTextStyles.fontFamily`, also set as the
theme `fontFamily`). Gilroy is a **commercial** typeface by Radomir Tinkov, so
the font files are not included in the repo.

1. Get licensed files (for example from Fontspring or the foundry).
2. Copy them to `assets/fonts/gilroy/` with these names:
   `Gilroy-Regular.ttf` (400), `Gilroy-Medium.ttf` (500),
   `Gilroy-SemiBold.ttf` (600), `Gilroy-Bold.ttf` (700).
3. Uncomment the `fonts:` block in `pubspec.yaml`, then run `flutter pub get`.

Until the files are added, Flutter uses the platform font in place of Gilroy,
and the app still builds and runs.
