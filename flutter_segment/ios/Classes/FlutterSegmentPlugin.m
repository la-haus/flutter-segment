#import "FlutterSegmentPlugin.h"
#if __has_include(<flutter_segment/flutter_segment-Swift.h>)
#import <flutter_segment/flutter_segment-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_segment-Swift.h"
#endif

@implementation FlutterSegmentPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSegmentPlugin registerWithRegistrar:registrar];
}
@end
