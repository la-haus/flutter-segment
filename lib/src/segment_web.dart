import 'dart:js';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class SegmentWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_segment',
      const StandardMethodCodec(),
      registrar, // the registrar is used as the BinaryMessenger
    );
    final SegmentWeb instance = SegmentWeb();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    final analytics =
        JsObject.fromBrowserObject(context['analytics'] as Object);
    switch (call.method) {
      case 'identify':
        analytics.callMethod('identify', [
          call.arguments['userId'],
          JsObject.jsify(call.arguments['traits'] as Object),
          JsObject.jsify(call.arguments['options'] as Object),
        ]);
        break;
      case 'track':
        analytics.callMethod('track', [
          call.arguments['eventName'],
          JsObject.jsify(call.arguments['properties'] as Object),
          JsObject.jsify(call.arguments['options'] as Object),
        ]);
        break;
      case 'screen':
        analytics.callMethod('page', [
          call.arguments['screenName'],
          JsObject.jsify(call.arguments['properties'] as Object),
          JsObject.jsify(call.arguments['options'] as Object),
        ]);
        break;
      case 'group':
        analytics.callMethod('group', [
          call.arguments['groupId'],
          JsObject.jsify(call.arguments['traits'] as Object),
          JsObject.jsify(call.arguments['options'] as Object),
        ]);
        break;
      case 'alias':
        analytics.callMethod('alias', [
          call.arguments['alias'],
          JsObject.jsify(call.arguments['options'] as Object),
        ]);
        break;
      case 'getAnonymousId':
        final user = analytics.callMethod('user');
        final anonymousId = user.callMethod('anonymousId');
        return anonymousId;
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
