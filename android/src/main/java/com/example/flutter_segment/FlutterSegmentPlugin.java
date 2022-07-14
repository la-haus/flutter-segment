package com.example.flutter_segment;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

import com.segment.analytics.Analytics;
import com.segment.analytics.Middleware;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;
import com.segment.analytics.Options;
import com.segment.analytics.integrations.BasePayload;
import com.segment.analytics.android.integrations.amplitude.AmplitudeIntegration;
import com.segment.analytics.android.integrations.appsflyer.AppsflyerIntegration;
import static com.segment.analytics.Analytics.LogLevel;

import androidx.annotation.NonNull;

import java.util.LinkedHashMap;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/** FlutterSegmentPlugin */
public class FlutterSegmentPlugin implements MethodCallHandler, FlutterPlugin {
  private Context applicationContext;
  private MethodChannel methodChannel;
  private final PropertiesMapper propertiesMapper = new PropertiesMapper();

  static HashMap<String, Object> appendToContextMiddleware;

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    setupChannels(binding.getApplicationContext(), binding.getBinaryMessenger());
  }

  private void setupChannels(Context applicationContext, BinaryMessenger messenger) {
    this.applicationContext = applicationContext;

    methodChannel = new MethodChannel(messenger, "flutter_segment");
    // register the channel to receive calls
    methodChannel.setMethodCallHandler(this);

    try {
      ApplicationInfo ai = applicationContext.getPackageManager()
              .getApplicationInfo(applicationContext.getPackageName(), PackageManager.GET_META_DATA);

      Bundle bundle = ai.metaData;

      FlutterSegmentOptions options = FlutterSegmentOptions.create(bundle);
      setupChannels(options);
    } catch (Exception e) {
      Log.e("FlutterSegment", e.getMessage());
    }
  }

  private void setupChannels(FlutterSegmentOptions options) {
    try {
      Analytics.Builder analyticsBuilder = new Analytics.Builder(applicationContext, options.getWriteKey());
      if (options.getTrackApplicationLifecycleEvents()) {
        Log.i("FlutterSegment", "Lifecycle events enabled");

        analyticsBuilder.trackApplicationLifecycleEvents();
      } else {
        Log.i("FlutterSegment", "Lifecycle events are not been tracked");
      }

      if (options.getDebug()) {
        analyticsBuilder.logLevel(LogLevel.DEBUG);
      }

      if (options.isAmplitudeIntegrationEnabled()) {
        analyticsBuilder.use(AmplitudeIntegration.FACTORY);
      }

      if (options.isAppsflyerIntegrationEnabled()) {
        analyticsBuilder.use(AppsflyerIntegration.FACTORY);
      }

      // Here we build a middleware that just appends data to the current context
      // using the [deepMerge] strategy.
      analyticsBuilder.useSourceMiddleware(
              new Middleware() {
                @Override
                public void intercept(Chain chain) {
                  try {
                    if (appendToContextMiddleware == null) {
                      chain.proceed(chain.payload());
                      return;
                    }

                    BasePayload payload = chain.payload();
                    Map<String, Object> originalContext = new LinkedHashMap<>(payload.context());
                    Map<String, Object> mergedContext = FlutterSegmentPlugin.deepMerge(
                            originalContext,
                            appendToContextMiddleware
                    );

                    BasePayload newPayload = payload.toBuilder()
                            .context(mergedContext)
                            .build();

                    chain.proceed(newPayload);
                  } catch (Exception e) {
                    Log.e("FlutterSegment", e.getMessage());
                    chain.proceed(chain.payload());
                  }
                }
              }
      );

      // Set the initialized instance as globally accessible.
      // It may throw an exception if we are trying to re-register a singleton Analytics instance.
      // This state may happen after the app is popped (back button until the app closes)
      // and opened again from the TaskManager.
      try {
        Analytics.setSingletonInstance(analyticsBuilder.build());
      } catch (IllegalStateException e) {
        Log.w("FlutterSegment", e.getMessage());
      }
    } catch (Exception e) {
      Log.e("FlutterSegment", e.getMessage());
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "config":
        this.config(call, result);
        break;
      case "identify":
        this.identify(call, result);
        break;
      case "track":
        this.track(call, result);
        break;
      case "screen":
        this.screen(call, result);
        break;
      case "group":
        this.group(call, result);
        break;
      case "alias":
        this.alias(call, result);
        break;
      case "getAnonymousId":
        this.anonymousId(result);
        break;
      case "reset":
        this.reset(result);
        break;
      case "setContext":
        this.setContext(call, result);
        break;
      case "disable":
        this.disable(call, result);
        break;
      case "enable":
        this.enable(call, result);
        break;
      case "flush":
        this.flush(call, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void config(MethodCall call, Result result) {
    try {
      HashMap<String, Object> configData = call.argument("options");
      FlutterSegmentOptions options = FlutterSegmentOptions.create(configData);
      this.setupChannels(options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
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

    Analytics.with(this.applicationContext).identify(userId, traits, options);
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
    Properties properties = propertiesMapper.buildProperties(propertiesData);
    Options options = this.buildOptions(optionsData);

    Analytics.with(this.applicationContext).track(eventName, properties, options);
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
    Properties properties = propertiesMapper.buildProperties(propertiesData);
    Options options = this.buildOptions(optionsData);

    Analytics.with(this.applicationContext).screen(null, screenName, properties, options);
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

    Analytics.with(this.applicationContext).group(groupId, traits, options);
  }

  private void alias(MethodCall call, Result result) {
    try {
      String alias = call.argument("alias");
      HashMap<String, Object> optionsData = call.argument("options");
      Options options = this.buildOptions(optionsData);
      Analytics.with(this.applicationContext).alias(alias, options);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void anonymousId(Result result) {
    try {
      String anonymousId = Analytics.with(this.applicationContext).getAnalyticsContext().traits().anonymousId();
      result.success(anonymousId);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void reset(Result result) {
    try {
      Analytics.with(this.applicationContext).reset();
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void setContext(MethodCall call, Result result) {
    try {
      appendToContextMiddleware = call.argument("context");
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  // There is no enable method at this time for Analytics on Android.
  // Instead, we use optOut as a proxy to achieve the same result.
  private void enable(MethodCall call, Result result) {
    try {
      Analytics.with(this.applicationContext).optOut(false);
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  private void flush(MethodCall call, Result result) {
    try {
      Analytics.with(this.applicationContext).flush();
      result.success(true);
    } catch (Exception e) {
      result.error("FlutterSegmentException", e.getLocalizedMessage(), null);
    }
  }

  // There is no disable method at this time for Analytics on Android.
  // Instead, we use optOut as a proxy to achieve the same result.
  private void disable(MethodCall call, Result result) {
    try {
      Analytics.with(this.applicationContext).optOut(true);
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
  @SuppressWarnings("unchecked")
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

  // Merges [newMap] into [original], *not* preserving [original]
  // keys (deep) in case of conflicts.
  private static Map deepMerge(Map original, Map newMap) {
    for (Object key : newMap.keySet()) {
      if (newMap.get(key) instanceof Map && original.get(key) instanceof Map) {
        Map originalChild = (Map) original.get(key);
        Map newChild = (Map) newMap.get(key);
        original.put(key, deepMerge(originalChild, newChild));
      } else {
        original.put(key, newMap.get(key));
      }
    }
    return original;
  }
}
