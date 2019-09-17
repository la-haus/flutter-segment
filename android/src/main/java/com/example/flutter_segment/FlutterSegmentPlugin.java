package com.example.flutter_segment;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

import com.segment.analytics.Analytics;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;

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
    } else {
      result.notImplemented();
    }
  }

  private void identify(MethodCall call, Result result) {
    try {
      String userId = call.argument("userId");
      HashMap<String, Object> traitsData = call.argument("traits");
      this.callIdentify(userId, traitsData);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callIdentify(String userId, HashMap<String, Object> traitsData) {
    Traits traits = new Traits();

    for(Map.Entry<String, Object> trait : traitsData.entrySet()) {
      String key = trait.getKey();
      Object value = trait.getValue();
      traits.putValue(key, value);
    }

    Analytics.with(this.context).identify(userId, traits, null);
  }

  private void track(MethodCall call, Result result) {
    try {
      String eventName = call.argument("eventName");
      HashMap<String, Object> propertiesData = call.argument("properties");
      this.callTrack(eventName, propertiesData);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callTrack(String eventName, HashMap<String, Object> propertiesData) {
    Properties properties = new Properties();

    for(Map.Entry<String, Object> property : propertiesData.entrySet()) {
      String key = property.getKey();
      Object value = property.getValue();
      properties.putValue(key, value);
    }

    Analytics.with(this.context).track(eventName, properties);
  }

  private void screen(MethodCall call, Result result) {
    try {
      String screenName = call.argument("screenName");
      HashMap<String, Object> propertiesData = call.argument("properties");
      this.callScreen(screenName, propertiesData);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callScreen(String screenName, HashMap<String, Object> propertiesData) {
    Properties properties = new Properties();

    for(Map.Entry<String, Object> property : propertiesData.entrySet()) {
      String key = property.getKey();
      Object value = property.getValue();
      properties.putValue(key, value);
    }

    Analytics.with(this.context).screen(screenName, properties);
  }

  private void group(MethodCall call, Result result) {
    try {
      String groupId = call.argument("groupId");
      HashMap<String, Object> traitsData = call.argument("traits");
      this.callGroup(groupId, traitsData);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void callGroup(String groupId, HashMap<String, Object> traitsData) {
    Traits traits = new Traits();

    for(Map.Entry<String, Object> trait : traitsData.entrySet()) {
      String key = trait.getKey();
      Object value = trait.getValue();
      traits.putValue(key, value);
    }

    Analytics.with(this.context).group(groupId, traits);
  }

  private void alias(MethodCall call, Result result) {
    try {
      String alias = call.argument("alias");
      Analytics.with(this.context).alias(alias);
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
}
