import 'package:meta/meta.dart';
import 'package:flutter_segment/segment_platform_interface.dart';

class FlutterSegment {
  static SegmentPlatform get _segment => SegmentPlatform.instance;

  static Future<void> identify({
    @required userId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    return _segment.identify(
      userId: userId,
      traits: traits,
      options: options,
    );
  }

  static Future<void> track({
    @required String eventName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    return _segment.track(
      eventName: eventName,
      properties: properties,
      options: options,
    );
  }

  static Future<void> screen({
    @required String screenName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    return _segment.screen(
      screenName: screenName,
      properties: properties,
      options: options,
    );
  }

  static Future<void> group({
    @required String groupId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    return _segment.group(
      groupId: groupId,
      traits: traits,
      options: options,
    );
  }

  static Future<void> alias({
    @required String alias,
    Map<String, dynamic> options,
  }) {
    return _segment.alias(
      alias: alias,
      options: options,
    );
  }

  static Future<String> get getAnonymousId {
    return _segment.getAnonymousId;
  }

  static Future<void> reset() {
    return _segment.reset();
  }

  static Future<void> disable() {
    return _segment.disable();
  }

  static Future<void> enable() {
    return _segment.enable();
  }

  static Future<void> debug(bool enabled) {
    return _segment.debug(enabled);
  }

  static Future<void> putDeviceToken(String token) {
    return _segment.putDeviceToken(token);
  }
}
