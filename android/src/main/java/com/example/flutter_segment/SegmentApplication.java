package com.example.flutter_segment;

import io.flutter.app.FlutterApplication;

import android.util.Log;
import android.os.Bundle;

import com.segment.analytics.Analytics;
import com.segment.analytics.Traits;
import com.segment.analytics.android.integrations.appsflyer.AppsflyerIntegration;


import java.util.Map;

import android.content.pm.PackageManager;
import android.content.pm.ApplicationInfo;

//https://segment.com/docs/spec/identify/
//https://segment.com/docs/sources/mobile/android/
public class SegmentApplication extends FlutterApplication {
    static final String TAG = "SEG_AF";

    @Override
    public void onCreate() {
        super.onCreate();
        initSegmentAnalytics();
    }

    private void initSegmentAnalytics() {

        try {
            ApplicationInfo ai = getPackageManager()
                    .getApplicationInfo(getPackageName(), PackageManager.GET_META_DATA);

            Bundle bundle = ai.metaData;

            String writeKey = bundle.getString("com.claimsforce.segment.WRITE_KEY");
            Boolean trackApplicationLifecycleEvents = bundle.getBoolean("com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS");
            Boolean isDebuggable = bundle.getBoolean("com.claimsforce.segment.DEBUG", false);

            if (writeKey == null || writeKey.equals("")) {
                Log.i("FlutterSegment", "write key is required.");
                return;
            } else {
                Log.i("FlutterSegment", "init from application class.");
            }

            Analytics.Builder builder = new Analytics.Builder(this, writeKey)
                    .use(AppsflyerIntegration.FACTORY);

            if (isDebuggable)
                builder.logLevel(Analytics.LogLevel.VERBOSE);

            if (trackApplicationLifecycleEvents)
                builder.trackApplicationLifecycleEvents();

            // Set the initialized instance as a globally accessible instance.
            Analytics.setSingletonInstance(builder.build());
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
            Log.e("FlutterSegment exception ", e.getMessage());
        }
    }
}