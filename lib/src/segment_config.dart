
import 'dart:io';

class SegmentConfig {
  
  SegmentConfig({
    this.androidWriteKey,
    this.iosWriteKey,
    this.trackApplicationLifecycleEvents = false,
    this.amplitudeIntegrationEnabled = false,
    this.appsflyerIntegrationEnabled = false,
    this.debug = false,
  }) {
    if (Platform.isIOS) {
      assert(iosWriteKey != null, 'Provide an right Write Key to IOS platform');
    } else if (Platform.isAndroid) {
      assert(androidWriteKey != null, 'Provide an right Write Key to Android platform');
    }
  }

  final bool trackApplicationLifecycleEvents;

  final bool amplitudeIntegrationEnabled;

  final bool appsflyerIntegrationEnabled;

  final bool debug;

  final String? androidWriteKey;

  final String? iosWriteKey;

  String get writeKey {
    return Platform.isIOS ? iosWriteKey! : androidWriteKey!;
  }

  Map<String, dynamic> toMap() {
    return {
      'writeKey': writeKey,
      'trackApplicationLifecycleEvents': trackApplicationLifecycleEvents,
      'amplitudeIntegrationEnabled': amplitudeIntegrationEnabled,
      'appsflyerIntegrationEnabled': appsflyerIntegrationEnabled,
      'debug': debug,
    };
  }
}
