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

  Future<void> handleMethodCall(MethodCall call) async {
    final analytics = JsObject.fromBrowserObject(context['analytics']);
    switch (call.method) {
      case 'track':
        analytics.callMethod('track', [
          call.arguments['eventName'],
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
