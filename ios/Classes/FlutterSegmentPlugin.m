#import "FlutterSegmentPlugin.h"
#import <Analytics/SEGAnalytics.h>

@implementation FlutterSegmentPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    @try {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"Info" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        NSString *writeKey = [dict objectForKey: @"com.claimsforce.segment.WRITE_KEY"];
        BOOL trackApplicationLifecycleEvents = [[dict objectForKey: @"com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS"] boolValue];
        SEGAnalyticsConfiguration *configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:writeKey];
        if (trackApplicationLifecycleEvents) {
            configuration.trackApplicationLifecycleEvents = YES;
        }
        [SEGAnalytics setupWithConfiguration:configuration];
        FlutterMethodChannel* channel = [FlutterMethodChannel
                                         methodChannelWithName:@"flutter_segment"
                                         binaryMessenger:[registrar messenger]];
        FlutterSegmentPlugin* instance = [[FlutterSegmentPlugin alloc] init];
        [registrar addMethodCallDelegate:instance channel:channel];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
    }
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"identify" isEqualToString:call.method]) {
        [self identify:call result:result];
    } else if ([@"track" isEqualToString:call.method]) {
        [self track:call result:result];
    } else if ([@"screen" isEqualToString:call.method]) {
        [self screen:call result:result];
    } else if ([@"group" isEqualToString:call.method]) {
        [self group:call result:result];
    } else if ([@"alias" isEqualToString:call.method]) {
        [self alias:call result:result];
    } else if ([@"getAnonymousId" isEqualToString:call.method]) {
        [self anonymousId:result];
    } else if ([@"reset" isEqualToString:call.method]) {
        [self reset:result];
    } else if ([@"disable" isEqualToString:call.method]) {
        [self disable:result];
    } else if ([@"enable" isEqualToString:call.method]) {
        [self enable:result];
    } else if ([@"debug" isEqualToString:call.method]) {
        [self debug:call result:result];
    } else if ([@"putDeviceToken" isEqualToString:call.method]) {
        [self putDeviceToken:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)identify:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *userId = call.arguments[@"userId"];
        NSDictionary *traits = call.arguments[@"traits"];
        NSDictionary *options = call.arguments[@"options"];
        [[SEGAnalytics sharedAnalytics] identify: userId
                                          traits: traits
                                         options: options];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)track:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *eventName = call.arguments[@"eventName"];
        NSDictionary *properties = call.arguments[@"properties"];
        NSDictionary *options = call.arguments[@"options"];
        [[SEGAnalytics sharedAnalytics] track: eventName
                                          properties: properties
                                         options: options];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)screen:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *screenName = call.arguments[@"screenName"];
        NSDictionary *properties = call.arguments[@"properties"];
        NSDictionary *options = call.arguments[@"options"];
        [[SEGAnalytics sharedAnalytics] screen: screenName
                                    properties: properties
                                       options: options];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)group:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *groupId = call.arguments[@"groupId"];
        NSDictionary *traits = call.arguments[@"traits"];
        NSDictionary *options = call.arguments[@"options"];
        [[SEGAnalytics sharedAnalytics] group: groupId
                                       traits: traits
                                      options: options];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)alias:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *alias = call.arguments[@"alias"];
        NSDictionary *options = call.arguments[@"options"];
        [[SEGAnalytics sharedAnalytics] alias: alias
                                      options: options];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)anonymousId:(FlutterResult)result {
    @try {
        NSString *anonymousId = [[SEGAnalytics sharedAnalytics] getAnonymousId];
        result(anonymousId);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)reset:(FlutterResult)result {
    @try {
        [[SEGAnalytics sharedAnalytics] reset];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)disable:(FlutterResult)result {
    @try {
        [[SEGAnalytics sharedAnalytics] disable];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)enable:(FlutterResult)result {
    @try {
        [[SEGAnalytics sharedAnalytics] enable];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

- (void)debug:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        BOOL enabled = call.arguments[@"debug"];
        [SEGAnalytics debug: enabled];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}


- (void)putDeviceToken:(FlutterMethodCall*)call result:(FlutterResult)result {
    @try {
        NSString *token = call.arguments[@"token"];
        NSData* data = [token dataUsingEncoding:NSUTF8StringEncoding];
        [[SEGAnalytics sharedAnalytics] registeredForRemoteNotificationsWithDeviceToken: data];
        result([NSNumber numberWithBool:YES]);
    }
    @catch (NSException *exception) {
        result([FlutterError errorWithCode:@"FlutterSegmentException" message:[exception reason] details: nil]);
    }
}

@end
