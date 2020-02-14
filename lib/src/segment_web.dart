import 'dart:js';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class SegmentWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_segment',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    final SegmentWeb instance = SegmentWeb();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    final analytics = JsObject.fromBrowserObject(context['analytics']);
    switch (call.method) {
      case 'identify':
        analytics.callMethod('identify', [
          call.arguments['userId'],
          JsObject.jsify(call.arguments['traits']),
          JsObject.jsify(call.arguments['options']),
        ]);
        break;
      case 'track':
        analytics.callMethod('track', [
          call.arguments['eventName'],
          JsObject.jsify(call.arguments['properties']),
          JsObject.jsify(call.arguments['options']),
        ]);
        break;
      case 'screen':
        analytics.callMethod('page', [
          call.arguments['screenName'],
          JsObject.jsify(call.arguments['properties']),
          JsObject.jsify(call.arguments['options']),
        ]);
        break;
      case 'group':
        analytics.callMethod('group', [
          call.arguments['groupId'],
          JsObject.jsify(call.arguments['traits']),
          JsObject.jsify(call.arguments['options']),
        ]);
        break;
      case 'alias':
        analytics.callMethod('alias', [
          call.arguments['alias'],
          JsObject.jsify(call.arguments['options']),
        ]);
        break;
      case 'getAnonymousId':
        final user = analytics.callMethod('user');
        final anonymousId = user.callMethod('anonymousId');
        return anonymousId;
        break;
      case 'reset':
        analytics.callMethod('reset');
        break;
      case 'debug':
        analytics.callMethod('debug', [
          call.arguments['debug'],
        ]);
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              "The segment plugin for web doesn't implement the method '${call.method}'",
        );
    }
  }
}
