package com.example.flutter_segment;

import com.segment.analytics.AnalyticsContext;
import com.segment.analytics.Middleware;
import com.segment.analytics.ValueMap;
import com.segment.analytics.integrations.BasePayload;
import com.segment.analytics.integrations.IdentifyPayload;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Stream;

public class BrazeDebounceMiddleware implements Middleware {
    private final static String BRAZE_INTEGRATIONNAME = "Appboy";
    private final static String INTEGRATIONS_KEY = "integrations";

    IdentifyPayload previousIdentifyPayload = null;

    @Override
    public void intercept(Chain chain) {
        BasePayload payload = chain.payload();
        ValueMap integrations = payload.integrations();
        if (integrations == null || Collections.emptyMap().equals(integrations)) {
            // Empty map does not allow to put values.
            integrations = new ValueMap();
        } else {
            // Sometimes integrations is a unmodifiable map if the event is constructed with a Builder.
            // Sadly, we don't know exactly when that is, so this Middleware need to copy the integrations
            // map for each event.
            integrations = new ValueMap(new LinkedHashMap<>(integrations));
        }

        if (payload instanceof IdentifyPayload) {
            IdentifyPayload identifyPayload = (IdentifyPayload) payload;

            if (!shouldSendToBraze(identifyPayload, previousIdentifyPayload)) {
                integrations.put(BRAZE_INTEGRATIONNAME, false);
                payload.putValue(INTEGRATIONS_KEY, integrations);
            }

            previousIdentifyPayload = identifyPayload;
        }

        chain.proceed(payload);
    }

    private Boolean shouldSendToBraze(IdentifyPayload payload, IdentifyPayload previousPayload) {
        if ((payload == null && previousPayload != null) || (payload != null && previousPayload == null)) {
            return true;
        }

        if (payload != null && previousPayload != null) {
            String anonymousId = (String)payload.get("anonymousId");
            String prevAnonymousId = (String)previousPayload.get("anonymousId");

            // if the anonymous ID has changed, send it to braze.
            if (!anonymousId.equals(prevAnonymousId)) {
                return true;
            }

            String userId = (String)payload.get("userId");
            String prevUserId = (String)previousPayload.get("userId");

            // If the user ID has changed, send it to braze.
            if (!userId.equals(prevUserId)) {
                return true;
            }

            // if the traits haven't changed, don't send it to braze.
            if (payload.get("traits").equals(previousPayload.get("traits"))) {
                return false;
            }
        }

        return true;
    }
}
