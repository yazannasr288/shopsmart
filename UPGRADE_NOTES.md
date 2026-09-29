# ShopSmart Upgrade Notes

## Fixed

- Removed outdated UI packages that depended on APIs no longer compatible with modern Flutter (`iconly`, `flutter_iconly`, `card_swiper`, `dynamic_height_grid_view`, `fancy_shimmer_image`, `shimmer`, `modal_progress_hud_nsn`).
- Replaced them with Flutter SDK widgets and native Material icons.
- Migrated Google Sign-In to `google_sign_in` 7.x (`GoogleSignIn.instance`, `initialize()`, `authenticate()`, ID-token credential).
- Removed recursive Google sign-in calls and duplicated Firebase sign-in calls.
- Centralized auth navigation through the auth state stream.
- Added email/password validation and password reset.
- Added proper controller disposal and async loading states.
- Fixed `pubspec.yaml` structure and launcher-icon configuration.
- Improved theme initialization and Material 3 theme setup.
- Reworked home carousel, search grid, product cards, cart cards and profile screen using Flutter SDK widgets.
- Fixed the widget test to reference `ShopSmartApp` instead of the removed `MyApp` class.

## Packages

The main runtime packages are intentionally kept small:

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `google_sign_in`
- `provider`
- `shared_preferences`

The verified stable versions used for this upgrade are listed in `pubspec.yaml`.

## Run

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run
```

The supplied archive did not contain platform folders (`android/`, `ios/`). Keep your existing platform folders when merging this source into the full project.
