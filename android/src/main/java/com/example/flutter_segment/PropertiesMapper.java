package com.example.flutter_segment;

import androidx.annotation.VisibleForTesting;

import com.segment.analytics.Properties;

import java.util.Map;

public class PropertiesMapper {
    @VisibleForTesting
    protected Properties buildProperties(Map<String, Object> map) {
        Properties properties = new Properties();

        for(Map.Entry<String, Object> property : map.entrySet()) {
            String key = property.getKey();
            Object value = property.getValue();

            if (value instanceof Map){
                Properties nestedProperties = buildProperties((Map<String, Object>) value);
                properties.putValue(key, nestedProperties);
            } else {
                properties.putValue(key, value);
            }
        }

        return properties;
    }
}
