import 'package:flutter/services.dart';

import 'flutter_segment_platform_interface.dart';

const MethodChannel _channel = MethodChannel('com.claimsforce.flutter_segment');

class MethodChannelFlutterSegment extends FlutterSegmentPlatform {
  Future<void> configure(String writeKey, {
    bool trackApplicationLifecycleEvents,
    bool debug,
  }) async {
    await _channel.invokeMethod('configure', {
      'writeKey': writeKey,
      'trackApplicationLifecycleEvents': trackApplicationLifecycleEvents,
      'debug': debug,
    });
  }

  Future<void> identify(String userId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    await _channel.invokeMethod('identify', {
      'userId': userId,
      'traits': traits ?? {},
      'options': options ?? {},
    });
  }

  Future<void> track(String eventName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    await _channel.invokeMethod('track', {
      'eventName': eventName,
      'properties': properties ?? {},
      'options': options ?? {},
    });
  }

  Future<void> screen(String screenName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    await _channel.invokeMethod('screen', {
      'screenName': screenName,
      'properties': properties ?? {},
      'options': options ?? {},
    });
  }

  Future<void> group(String groupId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    await _channel.invokeMethod('group', {
      'groupId': groupId,
      'traits': traits ?? {},
      'options': options ?? {},
    });
  }

  Future<void> alias(String alias, {
    Map<String, dynamic> options,
  }) async {
    await _channel.invokeMethod('alias', {
      'alias': alias,
      'options': options ?? {},
    });
  }

  Future<String> get getAnonymousId async {
    return await _channel.invokeMethod('getAnonymousId');
  }

  Future<void> reset() async {
    await _channel.invokeMethod('reset');
  }

  Future<void> disable() async {
    await _channel.invokeMethod('disable');
  }

  Future<void> enable() async {
    await _channel.invokeMethod('enable');
  }

  Future<void> debug(bool enabled) async {
    await _channel.invokeMethod('debug', {
      'debug': enabled,
    });
  }

  Future<void> setContext(Map<String, dynamic> context) async {
    await _channel.invokeMethod('setContext', {
      'context': context,
    });
  }
}
