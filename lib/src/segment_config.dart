class SegmentConfig {
  final String writeKey;
  final bool trackApplicationLifecycleEvents;
  final bool amplitudeIntegrationEnabled;
  final bool debug;

  SegmentConfig({
    required this.writeKey,
    this.trackApplicationLifecycleEvents = false,
    this.amplitudeIntegrationEnabled = false,
    this.debug = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'writeKey': writeKey,
      'trackApplicationLifecycleEvents': trackApplicationLifecycleEvents,
      'amplitudeIntegrationEnabled': amplitudeIntegrationEnabled,
      'debug': debug,
    };
  }
}
