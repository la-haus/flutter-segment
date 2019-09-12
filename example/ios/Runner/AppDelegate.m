#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Analytics/SEGAnalytics.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  SEGAnalyticsConfiguration *configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:@"V4uYzulgU7uwytaIhz96vzcxPUnjUWON"];
    configuration.trackApplicationLifecycleEvents = YES;
    [SEGAnalytics setupWithConfiguration:configuration];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
