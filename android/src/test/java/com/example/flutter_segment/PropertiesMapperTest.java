package com.example.flutter_segment;

import com.segment.analytics.Properties;

import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class PropertiesMapperTest {
    @Test
    public void buildProperties_withoutNestedProperties_returnsIt() {
        Map<String, Object> properties = new HashMap();
        properties.put("string", "value");
        properties.put("int", 1);
        properties.put("bool", true);

        PropertiesMapper mapper = new PropertiesMapper();
        Properties result = mapper.buildProperties(properties);

        assertEquals(result.get("string"), "value");
        assertEquals(result.get("int"), 1);
        assertEquals(result.get("bool"), true);
    }

    @Test
    public void buildProperties_withNestedMap_returnsIt() {
        Map<String, Object> properties = new HashMap();
        Map<String, Object> nestedProperties = new HashMap();
        properties.put("nested", nestedProperties);

        properties.put("string", "value");
        properties.put("int", 1);
        properties.put("bool", true);

        nestedProperties.put("string", "value2");
        nestedProperties.put("int", 2);
        nestedProperties.put("bool", false);

        PropertiesMapper mapper = new PropertiesMapper();
        Properties result = mapper.buildProperties(properties);

        assertEquals(result.get("string"), "value");
        assertEquals(result.get("int"), 1);
        assertEquals(result.get("bool"), true);

        Properties nestedResult = (Properties) result.get("nested");
        assertNotNull(nestedResult);
        assertEquals(nestedResult.get("string"), "value2");
        assertEquals(nestedResult.get("int"), 2);
        assertEquals(nestedResult.get("bool"), false);
    }
}