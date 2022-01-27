// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:flutter_segment/src/segment_config.dart';
import 'package:flutter_segment/src/segment_platform_interface.dart';

const MethodChannel _channel = MethodChannel('flutter_segment');

class SegmentMethodChannel extends SegmentPlatform {
  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
  Future<String?> get getAnonymousId {
    return _channel.invokeMethod('getAnonymousId');
  }

  @override
  Future<void> reset() async {
    try {
      await _channel.invokeMethod('reset');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  @override
  Future<void> disable() async {
    try {
      await _channel.invokeMethod('disable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  @override
  Future<void> enable() async {
    try {
      await _channel.invokeMethod('enable');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  @override
  Future<void> flush() async {
    try {
      await _channel.invokeMethod('flush');
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  @override
  Future<void> debug(bool enabled) async {
    try {
      await _channel.invokeMethod('debug', {
        'debug': enabled,
      });
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  @override
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
