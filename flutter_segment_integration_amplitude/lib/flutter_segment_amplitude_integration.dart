import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_segment_platform_interface/flutter_segment_platform_interface.dart';

class FlutterSegmentAmplitudeIntegration {
  static FlutterSegmentPlatform _platform = FlutterSegmentPlatform.instance;

  static const MethodChannel _channel =
      const MethodChannel('flutter_segment_amplitude_integration');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
