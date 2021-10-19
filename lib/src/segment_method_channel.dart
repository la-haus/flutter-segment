import 'package:flutter/services.dart';
import 'package:flutter_segment/src/segment_config.dart';
import 'package:flutter_segment/src/segment_platform_interface.dart';

const MethodChannel _channel = MethodChannel('flutter_segment');

class SegmentMethodChannel extends SegmentPlatform {
  Future<void> config({
    required SegmentConfig options,
  }) async {
    try {
      await _channel.invokeMethod('config', {
        'options': options.toMap(),
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> identify({
    String? userId,
    required Map<String, dynamic> traits,
    required Map<String, dynamic> options,
  }) async {
    try {
      await _channel.invokeMethod('identify', {
        'userId': userId,
        'traits': traits,
        'options': options,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> track({
    required String eventName,
    required Map<String, dynamic> properties,
    required Map<String, dynamic> options,
  }) async {
    try {
      await _channel.invokeMethod('track', {
        'eventName': eventName,
        'properties': properties,
        'options': options,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> screen({
    required String screenName,
    required Map<String, dynamic> properties,
    required Map<String, dynamic> options,
  }) async {
    try {
      await _channel.invokeMethod('screen', {
        'screenName': screenName,
        'properties': properties,
        'options': options,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> group({
    required String groupId,
    required Map<String, dynamic> traits,
    required Map<String, dynamic> options,
  }) async {
    try {
      await _channel.invokeMethod('group', {
        'groupId': groupId,
        'traits': traits,
        'options': options,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> alias({
    required String alias,
    required Map<String, dynamic> options,
  }) async {
    try {
      await _channel.invokeMethod('alias', {
        'alias': alias,
        'options': options,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<String?> get getAnonymousId async {
    return await _channel.invokeMethod('getAnonymousId');
  }

  Future<void> reset() async {
    try {
      await _channel.invokeMethod('reset');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> disable() async {
    try {
      await _channel.invokeMethod('disable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> enable() async {
    try {
      await _channel.invokeMethod('enable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> debug(bool enabled) async {
    try {
      await _channel.invokeMethod('debug', {
        'debug': enabled,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> setContext(Map<String, dynamic> context) async {
    try {
      await _channel.invokeMethod('setContext', {
        'context': context,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }
}
