import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterSegment {
  static const MethodChannel _channel =
      const MethodChannel('flutter_segment');

  static identify({@required userId, Map<String, dynamic> traits, Map<String, dynamic> options}) async {
    try {
      await _channel.invokeMethod('identify', {
        "userId": userId,
        "traits": traits ?? {},
        "options": options ?? {},
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static track({@required String eventName, Map<String, dynamic> properties, Map<String, dynamic> options}) async {
    try {
      await _channel.invokeMethod('track', {
        "eventName": eventName,
        "properties": properties ?? {},
        "options": options ?? {},
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static screen({@required String screenName, Map<String, dynamic> properties, Map<String, dynamic> options}) async {
    try {
      await _channel.invokeMethod('screen', {
        "screenName": screenName,
        "properties": properties ?? {},
        "options": options ?? {},
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static group({@required String groupId, Map<String, dynamic> traits, Map<String, dynamic> options}) async {
    try {
      await _channel.invokeMethod('group', {
        "groupId": groupId,
        "traits": traits ?? {},
        "options": options ?? {},
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static alias({@required String alias, Map<String, dynamic> options}) async {
    try {
      await _channel.invokeMethod('alias', {
        "alias": alias,
        "options": options ?? {},
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static Future<String> get getAnonymousId async {
    return await _channel.invokeMethod('getAnonymousId');
  }

  static Future<void> reset() async {
    try {
      await _channel.invokeMethod('reset');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static Future<void> disable() async {
    try {
      await _channel.invokeMethod('disable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static Future<void> enable() async {
    try {
      await _channel.invokeMethod('enable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  static Future<void> debug(bool enabled) async {
    try {
      await _channel.invokeMethod('debug', {
        "debug": enabled,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }
}
