import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_flutter_segment.dart';

abstract class FlutterSegmentPlatform extends PlatformInterface {
  FlutterSegmentPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSegmentPlatform _instance = MethodChannelFlutterSegment();

  static FlutterSegmentPlatform get instance => _instance;

  static set instance(FlutterSegmentPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> configure(String writeKey, {
    bool trackApplicationLifecycleEvents,
    bool debug,
  }) {
    throw UnimplementedError('configure() has not been implemented.');
  }

  Future<void> identify(String userId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    throw UnimplementedError('identify() has not been implemented.');
  }

  Future<void> track(String eventName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    throw UnimplementedError('track() has not been implemented.');
  }

  Future<void> screen(String screenName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) {
    throw UnimplementedError('screen() has not been implemented.');
  }

  Future<void> group(String groupId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) {
    throw UnimplementedError('group() has not been implemented.');
  }

  Future<void> alias(String alias, {
    Map<String, dynamic> options,
  }) {
    throw UnimplementedError('alias() has not been implemented.');
  }

  Future<String> get getAnonymousId {
    throw UnimplementedError('getAnonymousId() has not been implemented.');
  }

  Future<void> reset() {
    throw UnimplementedError('reset() has not been implemented.');
  }

  Future<void> disable() {
    throw UnimplementedError('disable() has not been implemented.');
  }

  Future<void> enable() {
    throw UnimplementedError('enable() has not been implemented.');
  }

  Future<void> debug(bool enabled) {
    throw UnimplementedError('debug() has not been implemented.');
  }

  Future<void> setContext(Map<String, dynamic> context) {
    throw UnimplementedError('setContext() has not been implemented.');
  }
}
