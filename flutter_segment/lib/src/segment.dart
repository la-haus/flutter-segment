import 'dart:async';

import 'package:flutter_segment_platform_interface/flutter_segment_platform_interface.dart';

class Segment {
  static FlutterSegmentPlatform get _platform => FlutterSegmentPlatform.instance;

  static Future<void> configure(String writeKey, {
    bool trackApplicationLifecycleEvents = false,
    bool debug = false,
  }) {
    return _platform.configure(
      writeKey,
      trackApplicationLifecycleEvents: trackApplicationLifecycleEvents,
      debug: debug,
    );
  }

  static Future<void> identify(String userId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    return _platform.identify(
        userId,
        traits: traits,
        options: options
    );
  }

  static Future<void> track(String eventName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    return _platform.track(
        eventName,
        properties: properties,
        options: options
    );
  }

  static Future<void> screen(String screenName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    return _platform.screen(
        screenName,
        properties: properties,
        options: options
    );
  }

  static Future<void> group(String groupId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    return _platform.group(
        groupId,
        traits: traits,
        options: options
    );
  }

  static Future<void> alias(String alias, {
    Map<String, dynamic> options,
  }) {
    return _platform.alias(
        alias,
        options: options
    );
  }

  static Future<String> get getAnonymousId {
    return _platform.getAnonymousId;
  }

  static Future<void> reset() {
    return _platform.reset();
  }

  static Future<void> disable() {
    return _platform.disable();
  }

  static Future<void> enable() {
    return _platform.enable();
  }

  static Future<void> debug(bool enabled) {
    return _platform.debug(enabled);
  }

  static Future<void> setContext(Map<String, dynamic> context) {
    return _platform.setContext(context);
  }
}
