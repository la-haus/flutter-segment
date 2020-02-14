# Segment plugin
![Pub Version](https://img.shields.io/pub/v/flutter_segment)

Flutter plugin to support iOS, Android and Web sources at https://segment.com.

## Usage
To use this plugin, add `flutter_segment` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Supported methods
| Method | Android | iOS | Web |
|---|---|---|---|
| `identify` | X | X | X |
| `track` | X | X | X |
| `screen` | X | X | X |
| `group` | X | X | X |
| `alias` | X | X | X |
| `getAnonymousId` | X | X | X |
| `reset` | X | X | X |
| `disable` | X | X | |
| `enable` | X | X | |
| `debug` | X | X | X |
| `putDeviceToken` | X | X | |

### Example
``` dart
import 'package:flutter/material.dart';
import 'package:flutter_segment/segment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Segment.screen(
      screenName: 'Example Screen',
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Segment example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('TRACK ACTION WITH SEGMENT'),
            onPressed: () {
              Segment.track(
                eventName: 'ButtonClicked',
                properties: {
                  'foo': 'bar',
                  'number': 1337,
                  'clicked': true,
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
```

## Installation
Setup your Android, iOS and/or sources as described at Segment.com and generate your write keys.

Set your Segment write key and change the automatic event tracking (only Android and iOS) on if you wish the library to take care of it for you. 
Remember that the application lifecycle events won't have any special context set for you by the time it is initialized.

### Android
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.flutter_segment_example">
    <application>
        <activity>
            [...]
        </activity>
        <meta-data android:name="com.claimsforce.segment.WRITE_KEY" android:value="YOUR_WRITE_KEY_GOES_HERE" />
        <meta-data android:name="com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS" android:value="false" />
    </application>
</manifest>
```

### iOS
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	[...]
	<key>com.claimsforce.segment.WRITE_KEY</key>
	<string>YOUR_WRITE_KEY_GOES_HERE</string>
	<key>com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS</key>
	<false/>
	[...]
</dict>
</plist>
```

### Web
```html
<!DOCTYPE html>
<html>
<head>
  [...]
</head>
<body>
<script>
  !function(){ ...;
    analytics.load("YOUR_WRITE_KEY_GOES_HERE");
    analytics.page();
  }}();
</script>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>

```
For more informations please check: https://segment.com/docs/connections/sources/catalog/libraries/website/javascript/quickstart/

## Sending device tokens for push notifications
Segment integrates with 3rd parties that allow sending push notifications.
In order to do that you will need to provide it with the device token - which can be obtained using one of the several Flutter libraries.

As soon as you obtain the device token, you need to add it to Segment's context and then emit a tracking event named `Application Opened` or `Application Installed`. The tracking event is needed because it is the [only moment when Segment propagates it to 3rd parties](https://segment.com/docs/connections/destinations/catalog/customer-io/).

Both calls (`putDeviceToken` and `track`) can be done sequentially at startup time, given that the token exists.
Nonetheless, if you don't want to delay the token propagation and don't mind having an extra `Application Opened` event in the middle of your app's events, it can be done right away when the token is acquired.

```dart
await Segment.putDeviceToken(token);
// the token is only propagated when one of two events are called:
// - Application Installed
// - Application Opened
await Segment.track(eventName: 'Application Opened');
```

## Setting integration options
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
Segment.screen(
  screenName: screenName,
  properties: {},
  options: {
    'integrations': {
      'Amplitude': {'session_id': '1578083527'}
    }
  },
)
```

## Setting the options globally
You can also set the default options to be used in every method call, if the call omits the options parameter. Just set `FlutterSegmentDefaultOptions.instance.options`. For example:

```dart
SegmentDefaultOptions.instance.options = {
  'integrations': {
    'Amplitude': {
      'session_id': '1578083527'
    }
  }
}
```

## Issues
Please file any issues, bugs, or feature requests in the [GitHub repo](https://github.com/claimsforce-gmbh/flutter-segment/issues/new).

## Contributing
If you wish to contribute a change to this repo, please send a [pull request](https://github.com/claimsforce-gmbh/flutter-segment/pulls).
