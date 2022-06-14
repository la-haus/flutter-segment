## 3.9.0
- Android: update segment dependencies and [Google Play policies violation in flutter_segment 3.7.0](https://github.com/la-haus/flutter-segment/issues/30) thanks @vbuberen
- Android: Upgrade gradle build config for android [PR](https://github.com/la-haus/flutter-segment/pull/29) thanks @vbuberen
- iOS: Fix userId nil throws "unrecognized selector sent to instance" thanks @zenled
- Add apps flyer integration [PR](https://github.com/la-haus/flutter-segment/pull/19) thanks @johnsouza-loftbr

## 3.7.0
* Android/iOS: add `Segment.flush` for debug environments (https://github.com/la-haus/flutter-segment/pull/9).
* iOS: improve logging (https://github.com/claimsforce-gmbh/flutter-segment/pull/111)

## 3.5.0
* iOS: we are forcing to use `use_frameworks!`

## 3.4.1
* iOS: re-add `s.static_framework = true` in `podspec`

## 3.4.0
* iOS: fix immediate crash on iOS
* iOS: set min deployment target to `11.0` (previous it was `8.0`)

## 3.3.0
* Android: upgrade Segment SDK to `4.10.0`
* iOS: upgrade Segment SDK to `4.1.6`

## 3.2.1
* fix null safety

## 3.2.0
* added installation via Dart Code

## 3.1.3
* iOS: fix incorrect `Segment-Amplitude` import

## 3.1.2
* Android: allow nested properties for event properties (with Null Safety)

## 3.1.1
* make `userId` nullable

## 3.1.0
* migrate to null safety

## 3.0.0
### BREAKING CHANGE
* removed branch io integration as the package is in the maintenance mode

## 2.2.2
* fixed segment-amplitude incorrect import path on iOS

## 2.2.1
* fixed segment-branch incorrect import path on iOS

## 2.2.0
* added `ENABLE_AMPLITUDE_INTEGRATION` configuration option
* fixed segment-branch incorrect import path on iOS

## 2.1.1
* fixed `context` overwriting (using `segment.setContext(...)`) for `iOS` devices

## 2.1.0
* added `ENABLE_BRANCH_IO_INTEGRATION` configuration option

## 2.0.2
* added `disable` and `enable` methods for Android
* added `DEBUG` configuration option for Android (used on `AndroidManifest.xml`)

## 2.0.1
* fixed method channel issue

## 2.0.0
### BREAKING CHANGE
* removed `putDeviceToken` call
* added `setContext` as a better and more general approach to setting context variables

### Feature
* added support to the new [Android plugins APIs](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration)

## 1.0.0
### BREAKING CHANGE
* the name was changed from `FlutterSegment` to `Segment`
* set flutter version to `>=1.12.13+hotfix.4 <2.0.0`

### Feature
* added web support

## 0.0.8
* added support for integration options in Android (iOS was already supported in previous versions)
* added a configuration parameter for enabling/disabling automatic application lifecycle tracking (only for Android, iOS)
* removed `Application Started` tracking event from Android plugin registration

## 0.0.7
* initialize plugin along with FirebaseMessaging

## 0.0.6
* added support for device token

## 0.0.5
* improved dependencies

## 0.0.4
* added NavigatorObserver to automatically track named screen transitions

## 0.0.3
* added package fixes and missing license

## 0.0.2
* extended README

## 0.0.1
* initial implementation to support general Segment API for iOS and Android
