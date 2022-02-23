package com.example.flutter_segment;

import io.flutter.app.FlutterApplication;

import android.util.Log;
import android.os.Bundle;

import com.segment.analytics.Analytics;
import com.segment.analytics.Traits;
//import com.segment.analytics.android.integrations.appsflyer.AppsflyerIntegration;
import com.appsflyer.AppsFlyerLib;


import java.util.Map;

import android.content.pm.PackageManager;
import android.content.pm.ApplicationInfo;

//https://segment.com/docs/spec/identify/
//https://segment.com/docs/sources/mobile/android/
public class MyApplication extends FlutterApplication {
    static final String TAG = "SEG_AF";

    @Override
    public void onCreate() {
        super.onCreate();
        initSegmentAnalytics();
        initAppsflyer();
    }

    private void initSegmentAnalytics() {

        try {
            ApplicationInfo ai = getPackageManager()
                    .getApplicationInfo(getPackageName(), PackageManager.GET_META_DATA);

            Bundle bundle = ai.metaData;

            String writeKey = bundle.getString("com.claimsforce.segment.WRITE_KEY");
            Boolean trackApplicationLifecycleEvents = bundle.getBoolean("com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS");
            Boolean debug = bundle.getBoolean("com.claimsforce.segment.DEBUG", false);

            if (writeKey == null || writeKey.equals("")) {
                Log.i("FlutterSegment", "write key is required.");
                return;
            } else {
                Log.i("FlutterSegment", "init from application class.");
            }

            Analytics.Builder builder = new Analytics.Builder(this, writeKey);
//                    .use(AppsflyerIntegration.FACTORY);

            if (debug)
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

    private void initAppsflyer(){
        try {
            ApplicationInfo ai = getPackageManager()
                    .getApplicationInfo(getPackageName(), PackageManager.GET_META_DATA);

            Bundle bundle = ai.metaData;

            String devKey = bundle.getString("com.claimsforce.appsflyer.DEV_KEY");

            if (devKey == null || devKey.equals("")) {
                Log.i("FlutterSegment", "DEV KEY key is required.");
                return;
            } else {
                Log.i("FlutterSegment", "init appsflyer from application class.");
            }

            AppsFlyerLib.getInstance().init(devKey, null, this);
            AppsFlyerLib.getInstance().start(this);
            AppsFlyerLib.getInstance().setDebugLog(true);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
            Log.e("FlutterSegment initAppsflyer exception ", e.getMessage());
        }
    }
}