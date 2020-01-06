package com.example.flutter_segment;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

import com.segment.analytics.Analytics;
import com.segment.analytics.AnalyticsContext;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;
import com.segment.analytics.Options;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterSegmentPlugin */
public class FlutterSegmentPlugin implements MethodCallHandler {
  Context context;

  public FlutterSegmentPlugin(Context context) {
    this.context = context;
  }
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    Context context = registrar.activity().getApplicationContext();

    try {
      ApplicationInfo ai = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
      Bundle bundle = ai.metaData;
      String writeKey = bundle.getString("com.claimsforce.segment.WRITE_KEY");
      Analytics analytics = new Analytics.Builder(registrar.activity(), writeKey)
              .trackApplicationLifecycleEvents() // Enable this to record certain application events automatically!
              .build();
// Set the initialized instance as a globally accessible instance.
      Analytics.setSingletonInstance(analytics);
      Analytics.with(registrar.activity()).track("Application Started");
    } catch (Exception e) {
      Log.e("FlutterSegment", e.getMessage());
    }

    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_segment");
    channel.setMethodCallHandler(new FlutterSegmentPlugin(context));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if(call.method.equals("identify")) {
      this.identify(call, result);
    } else if (call.method.equals("track")) {
      this.track(call, result);
    } else if (call.method.equals("screen")) {
      this.screen(call, result);
    } else if (call.method.equals("group")) {
      this.group(call, result);
    } else if (call.method.equals("alias")) {
      this.alias(call, result);
    } else if (call.method.equals("getAnonymousId")) {
      this.anonymousId(result);
    } else if (call.method.equals("reset")) {
      this.reset(result);
    } else if (call.method.equals("putDeviceToken")) {
      this.putDeviceToken(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void identify(MethodCall call, Result result) {
    try {
      String userId = call.argument("userId");
      HashMap<String, Object> traitsData = call.argument("traits");
      HashMap<String, Object> options = call.argument("options");
      this.callIdentify(userId, traitsData, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callIdentify(
    String userId,
    HashMap<String, Object> traitsData,
    HashMap<String, Object> optionsData
  ) {
    Traits traits = new Traits();
    Options options = this.buildOptions(optionsData);

    for(Map.Entry<String, Object> trait : traitsData.entrySet()) {
      String key = trait.getKey();
      Object value = trait.getValue();
      traits.putValue(key, value);
    }

    Analytics.with(this.context).identify(userId, traits, options);
  }

  private void track(MethodCall call, Result result) {
    try {
      String eventName = call.argument("eventName");
      HashMap<String, Object> propertiesData = call.argument("properties");
      HashMap<String, Object> options = call.argument("options");
      this.callTrack(eventName, propertiesData, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callTrack(
    String eventName,
    HashMap<String, Object> propertiesData,
    HashMap<String, Object> optionsData
  ) {
    Properties properties = new Properties();
    Options options = this.buildOptions(optionsData);

    for(Map.Entry<String, Object> property : propertiesData.entrySet()) {
      String key = property.getKey();
      Object value = property.getValue();
      properties.putValue(key, value);
    }

    Analytics.with(this.context).track(eventName, properties, options);
  }

  private void screen(MethodCall call, Result result) {
    try {
      String screenName = call.argument("screenName");
      HashMap<String, Object> propertiesData = call.argument("properties");
      HashMap<String, Object> options = call.argument("options");
      this.callScreen(screenName, propertiesData, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callScreen(
    String screenName,
    HashMap<String, Object> propertiesData,
    HashMap<String, Object> optionsData
  ) {
    Properties properties = new Properties();
    Options options = this.buildOptions(optionsData);

    for(Map.Entry<String, Object> property : propertiesData.entrySet()) {
      String key = property.getKey();
      Object value = property.getValue();
      properties.putValue(key, value);
    }

    Analytics.with(this.context).screen(null, screenName, properties, options);
  }

  private void group(MethodCall call, Result result) {
    try {
      String groupId = call.argument("groupId");
      HashMap<String, Object> traitsData = call.argument("traits");
      HashMap<String, Object> options = call.argument("options");
      this.callGroup(groupId, traitsData, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callGroup(
    String groupId,
    HashMap<String, Object> traitsData,
    HashMap<String, Object> optionsData
  ) {
    Traits traits = new Traits();
    Options options = this.buildOptions(optionsData);

    for(Map.Entry<String, Object> trait : traitsData.entrySet()) {
      String key = trait.getKey();
      Object value = trait.getValue();
      traits.putValue(key, value);
    }

    Analytics.with(this.context).group(groupId, traits, options);
  }

  private void alias(MethodCall call, Result result) {
    try {
      String alias = call.argument("alias");
      HashMap<String, Object> optionsData = call.argument("options");
      Options options = this.buildOptions(optionsData);
      Analytics.with(this.context).alias(alias, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void anonymousId(Result result) {
    try {
      String anonymousId = Analytics.with(this.context).getAnalyticsContext().traits().anonymousId();
      result.success(anonymousId);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void reset(Result result) {
    try {
      Analytics.with(this.context).reset();
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void putDeviceToken(MethodCall call, Result result) {
    try {
      String token = call.argument("token");
      AnalyticsContext analyticsContext = Analytics.with(context).getAnalyticsContext();
      analyticsContext.putDeviceToken(token);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  /**
   * Enables / disables / sets custom integration properties so Segment can properly
   * interact with 3rd parties, such as Amplitude.
   * @see https://segment.com/docs/connections/sources/catalog/libraries/mobile/android/#selecting-destinations
   * @see https://github.com/segmentio/analytics-android/blob/master/analytics/src/main/java/com/segment/analytics/Options.java
   */
  private Options buildOptions(HashMap<String, Object> optionsData) {
    Options options = new Options();

    if (optionsData != null &&
      optionsData.containsKey("integrations") &&
      (optionsData.get("integrations") instanceof HashMap)) {
      for (Map.Entry<String, Object> integration : ((HashMap<String,Object>)optionsData.get("integrations")).entrySet()) {
        String key = integration.getKey();

        if (integration.getValue() instanceof HashMap) {
          HashMap<String, Object> values = ((HashMap<String, Object>)integration.getValue());
          options.setIntegrationOptions(key, values);
        } else if (integration.getValue() instanceof Boolean) {
          Boolean value = ((Boolean)integration.getValue());
          options.setIntegration(key, value);
        }
      }
    }

    return options;
  }
}
