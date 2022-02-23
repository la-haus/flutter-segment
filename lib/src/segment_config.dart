class SegmentConfig {
  SegmentConfig({
    required this.writeKey,
    this.trackApplicationLifecycleEvents = false,
    this.amplitudeIntegrationEnabled = false,
    this.appsFlyerIntegrationEnabled = false,
    this.trackAttributionInformation = false,
    this.debug = false,
  });

  final String writeKey;
  final bool trackApplicationLifecycleEvents;
  final bool amplitudeIntegrationEnabled;
  final bool appsFlyerIntegrationEnabled;
  final bool trackAttributionInformation;
  final bool debug;

  Map<String, dynamic> toMap() {
    return {
      'writeKey': writeKey,
      'trackApplicationLifecycleEvents': trackApplicationLifecycleEvents,
      'amplitudeIntegrationEnabled': amplitudeIntegrationEnabled,
      'appsFlyerIntegrationEnabled': appsFlyerIntegrationEnabled,
      'trackAttributionInformation': trackAttributionInformation,
      'debug': debug,
    };
  }
}