import 'dart:async';
import 'dart:js';

import 'package:flutter_segment_platform_interface/flutter_segment_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class FlutterSegmentPlugin extends FlutterSegmentPlatform {
  final JsObject _analytics;

  FlutterSegmentPlugin() : _analytics = JsObject.fromBrowserObject(context['analytics']);

  static void registerWith(Registrar registrar) {
    FlutterSegmentPlatform.instance = FlutterSegmentPlugin();
  }

  @override
  Future<void> identify(String userId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    _analytics.callMethod('identify', [
      userId,
      JsObject.jsify(traits),
      JsObject.jsify(options),
    ]);
  }

  @override
  Future<void> track(String eventName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    _analytics.callMethod('track', [
      eventName,
      JsObject.jsify(properties),
      JsObject.jsify(options),
    ]);
  }

  @override
  Future<void> screen(String screenName, {
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    _analytics.callMethod('page', [
      screenName,
      JsObject.jsify(properties),
      JsObject.jsify(options),
    ]);
  }

  @override
  Future<void> group(String groupId, {
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    _analytics.callMethod('group', [
      groupId,
      JsObject.jsify(traits),
      JsObject.jsify(options),
    ]);
  }

  @override
  Future<void> alias(String alias, {
    Map<String, dynamic> options,
  }) async {
    _analytics.callMethod('alias', [
      alias,
      JsObject.jsify(options),
    ]);
  }

  @override
  Future<String> get getAnonymousId {
    final user = _analytics.callMethod('user');
    final anonymousId = user.callMethod('anonymousId');
    return anonymousId;
  }

  @override
  Future<void> reset() async {
    _analytics.callMethod('reset');
  }

  @override
  Future<void> disable() {
    throw UnimplementedError('disable() has not been implemented.');
  }

  @override
  Future<void> enable() {
    throw UnimplementedError('enable() has not been implemented.');
  }

  @override
  Future<void> debug(bool enabled) async {
    _analytics.callMethod('debug', [
      enabled,
    ]);
  }

  @override
  Future<void> setContext(Map<String, dynamic> context) {
    throw UnimplementedError('setContext() has not been implemented.');
  }
}
