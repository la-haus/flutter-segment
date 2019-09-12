#import "FlutterSegmentPlugin.h"
#import <Analytics/SEGAnalytics.h>

@implementation FlutterSegmentPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_segment"
            binaryMessenger:[registrar messenger]];
  FlutterSegmentPlugin* instance = [[FlutterSegmentPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"identify" isEqualToString:call.method]) {
      NSString *userId = call.arguments[@"userId"];
      NSDictionary *traits = call.arguments[@"traits"];
      NSDictionary *options = call.arguments[@"options"];
      [[SEGAnalytics sharedAnalytics] identify: userId
                                 traits: traits
                                    options: options];
  } else if ([@"track" isEqualToString:call.method]) {
      NSString *eventName = call.arguments[@"eventName"];
      NSDictionary *properties = call.arguments[@"properties"];
      NSDictionary *options = call.arguments[@"options"];
      [[SEGAnalytics sharedAnalytics] track: eventName
                                 properties: properties
                                    options: options];
  } else if ([@"screen" isEqualToString:call.method]) {
      NSString *screenName = call.arguments[@"screenName"];
      NSDictionary *properties = call.arguments[@"properties"];
      NSDictionary *options = call.arguments[@"options"];
      [[SEGAnalytics sharedAnalytics] screen: screenName
                                 properties: properties
                                    options: options];
  } else if ([@"group" isEqualToString:call.method]) {
      NSString *groupId = call.arguments[@"groupId"];
      NSDictionary *traits = call.arguments[@"traits"];
      NSDictionary *options = call.arguments[@"options"];
      [[SEGAnalytics sharedAnalytics] group: groupId
                                      traits: traits
                                     options: options];
  } else if ([@"alias" isEqualToString:call.method]) {
      NSString *alias = call.arguments[@"alias"];
      NSDictionary *options = call.arguments[@"options"];
      [[SEGAnalytics sharedAnalytics] alias: alias
                                    options: options];
  } else if ([@"getAnonymousId" isEqualToString:call.method]) {
    result([[SEGAnalytics sharedAnalytics] getAnonymousId]);
  } else if ([@"reset" isEqualToString:call.method]) {
      [[SEGAnalytics sharedAnalytics] reset];
  } else if ([@"disable" isEqualToString:call.method]) {
      [[SEGAnalytics sharedAnalytics] disable];
  } else if ([@"enable" isEqualToString:call.method]) {
      [[SEGAnalytics sharedAnalytics] enable];
  } else if ([@"debug" isEqualToString:call.method]) {
      BOOL enabled = call.arguments[@"debug"];
      [SEGAnalytics debug: enabled];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
