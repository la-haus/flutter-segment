import 'dart:js';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

final window = JsObject.fromBrowserObject(context['window']);
final analytics = window['analytics'];

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
    switch (call.method) {
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              "The segment plugin for web doesn't implement the method '${call.method}'",
        );
    }
  }
}
