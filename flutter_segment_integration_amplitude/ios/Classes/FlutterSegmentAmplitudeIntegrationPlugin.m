#import "FlutterSegmentAmplitudeIntegrationPlugin.h"
#if __has_include(<flutter_segment_amplitude_integration/flutter_segment_amplitude_integration-Swift.h>)
#import <flutter_segment_amplitude_integration/flutter_segment_amplitude_integration-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_segment_amplitude_integration-Swift.h"
#endif

@implementation FlutterSegmentAmplitudeIntegrationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSegmentAmplitudeIntegrationPlugin registerWithRegistrar:registrar];
}
@end
