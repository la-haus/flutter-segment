enum SegmentIntegrationItemType { amplitude, unknown }

class SegmentConfig {
  SegmentConfig({
    required this.writeKey,
    this.trackApplicationLifecycleEvents = false,
    this.debug = false,
    this.integrationItems,
  });

  final String writeKey;
  final bool trackApplicationLifecycleEvents;
  final List<SegmentIntegrationItemType>? integrationItems;
  final bool debug;

  Map<String, dynamic> toMap() {
    return {
      'writeKey': writeKey,
      'trackApplicationLifecycleEvents': trackApplicationLifecycleEvents,
      'debug': debug,
      'integrationItems':
          integrationItems?.map((e) => e.toString().split(".").last).toList(),
    };
  }
}
