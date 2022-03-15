package com.example.flutter_segment;

import android.os.Bundle;

import java.util.HashMap;
import java.util.ArrayList; // import the ArrayList class


public class FlutterSegmentOptions {
    private final String writeKey;
    private final Boolean trackApplicationLifecycleEvents;
    private final Boolean debug;
    private final ArrayList<String> integrationItems;
    
    //nullable arguments
    public  FlutterSegmentOptions(String writeKey, Boolean trackApplicationLifecycleEvents,Boolean debug) {
        this(writeKey,trackApplicationLifecycleEvents,debug,new ArrayList<String>());
    }

    public  FlutterSegmentOptions(String writeKey, Boolean trackApplicationLifecycleEvents, Boolean debug, ArrayList<String> integrationItems) {
        this.writeKey = writeKey;
        this.trackApplicationLifecycleEvents = trackApplicationLifecycleEvents;
        this.debug = debug;
        this.integrationItems = integrationItems;
    }

    public String getWriteKey() {
        return writeKey;
    }

    public Boolean getTrackApplicationLifecycleEvents() {
        return trackApplicationLifecycleEvents;
    }

    public ArrayList<String> getIntegrationItems() {
        return integrationItems;
    }

    public Boolean getDebug() {
        return debug;
    }

    // static FlutterSegmentOptions create(Bundle bundle) {
    //     String writeKey = bundle.getString("com.claimsforce.segment.WRITE_KEY");
    //     Boolean trackApplicationLifecycleEvents = bundle.getBoolean("com.claimsforce.segment.TRACK_APPLICATION_LIFECYCLE_EVENTS");
    //     Boolean isAmplitudeIntegrationEnabled = bundle.getBoolean("com.claimsforce.segment.ENABLE_AMPLITUDE_INTEGRATION", false);
    //     Boolean debug = bundle.getBoolean("com.claimsforce.segment.DEBUG", false);
    //     return new FlutterSegmentOptions(writeKey, trackApplicationLifecycleEvents, isAmplitudeIntegrationEnabled, debug);
    // }

    static FlutterSegmentOptions create(HashMap<String, Object> options) {
        String writeKey = (String) options.get("writeKey");
        Boolean trackApplicationLifecycleEvents = (Boolean) options.get("trackApplicationLifecycleEvents");
        Boolean debug = orFalse((Boolean) options.get("debug"));
        ArrayList<String> integrationItems = (ArrayList<String>) options.get("integrationItems");
        return new FlutterSegmentOptions(writeKey, trackApplicationLifecycleEvents, debug,integrationItems);
    }

    private static Boolean orFalse(Boolean value) {
        return value == null ? false : value;
    }
}
