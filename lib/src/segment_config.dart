class SegmentConfig {
  SegmentConfig({
    required this.writeKey,
    this.trackApplicationLifecycleEvents = false,
    this.amplitudeIntegrationEnabled = false,
    this.appsflyerIntegrationEnabled = false,
    this.debug = false,
  });

  final String writeKey;
  final bool trackApplicationLifecycleEvents;
  final bool amplitudeIntegrationEnabled;
  final bool appsflyerIntegrationEnabled;
  final bool debug;

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
