# flutter_segment

Flutter plugin to support iOS and Android Sources at https://segment.com.

# Example

1. Import flutter-segment
2. Setup your Android and iOS Sources as described at Segment.com and generate your write keys
3. Android: Add your write key to AndroidManifest Meta Data:
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.flutter_segment_example">

    <!-- io.flutter.app.FlutterApplication is an android.app.Application that
         calls FlutterMain.startInitialization(this); in its onCreate method.
         In most cases you can leave this as-is, but you if you want to provide
         additional functionality it is fine to subclass or reimplement
         FlutterApplication and put your custom class here. -->
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="flutter_segment_example"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- This keeps the window background of the activity showing
                 until Flutter renders its first frame. It can be removed if
                 there is no splash screen (such as the default splash screen
                 defined in @style/LaunchTheme). -->
            <meta-data
                android:name="io.flutter.app.android.SplashScreenUntilFirstFrame"
                android:value="true" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data android:name="com.claimsforce.segment.WRITE_KEY" android:value="<YOUR_WRITE_KEY_GOES_HERE>" />
    </application>
</manifest>
```
4. iOS: Add your write key to Info.plist
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>flutter_segment_example</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>com.claimsforce.segment.WRITE_KEY</key>
	<string>YOUR_WRITE_KEY_GOES_HERE</string>
	<key>UIViewControllerBasedStatusBarAppearance</key>
	<false/>
</dict>
</plist>
```
5. Start tracking events

```dart
FlutterSegment.track(
                eventName: 'TestEvent',
                properties: {
                  'price': 12.22,
                  'product': 'TestProduct',
                },
              );
```

# Sending device tokens for push notifications

Segment integrates with 3rd parties that allow sending push notifications.
In order to do that you will need to provide it with the device token - which can be obtained using one of the several Flutter libraries.

As soon as you obtain the device token, you need to add it to Segment's context and then emit a tracking event named `Application Opened` or `Application Installed`. The tracking event is needed because it is the [only moment when Segment propagates it to 3rd parties](https://segment.com/docs/connections/destinations/catalog/customer-io/).

Both calls (`putDeviceToken` and `track`) can be done sequentially at startup time, given that the token exists.
Nonetheless, if you don't want to delay the token propagation and don't mind having an extra `Application Opened` event in the middle of your app's events, it can be done right away when the token is acquired.

```dart
await FlutterSegment.putDeviceToken(token);
/// the token is only propagated when one of two events are called:
/// - Application Installed
/// - Application Opened
///
await FlutterSegment.track(
	eventName: 'Application Opened'
);
```

# Setting integration options

If you intend to use any specific integrations with third parties, such as custom Session IDs for Amplitude, you'll need to set it using options for each call (or globally) when the application was started.

## Setting the options in every call

The methods below support `options` as parameters:
- `identify({@required userId, Map<String, dynamic> traits, Map<String, dynamic> options})`
- `track({@required String eventName, Map<String, dynamic> properties, Map<String, dynamic> options})`
- `screen({@required String screenName, Map<String, dynamic> properties, Map<String, dynamic> options})`
- `group({@required String groupId, Map<String, dynamic> traits, Map<String, dynamic> options})`
- `alias({@required String alias, Map<String, dynamic> options})`

An example of a screen being tracked as part of a session, which will be communicated to Amplitude:

```dart
FlutterSegment.screen(
	screenName: screenName,
	properties: {},
	options: {
		'integrations': {
			'Amplitude': {
				'session_id': '1578083527'
			}
		}
	}
```

## Setting the options globally

You can also set the default options to be used in every method call, if the call omits the options parameter. Just set `FlutterSegmentDefaultOptions.instance.options`. For example:

```dart
FlutterSegmentDefaultOptions.instance.options = {
	'integrations': {
		'Amplitude': {
			'session_id': '1578083527'
		}
	}
}
```

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
