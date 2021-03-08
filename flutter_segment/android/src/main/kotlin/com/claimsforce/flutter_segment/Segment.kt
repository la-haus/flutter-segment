package com.claimsforce.flutter_segment

import android.content.Context
import com.segment.analytics.Analytics
import com.segment.analytics.Options
import com.segment.analytics.Properties
import com.segment.analytics.Traits
import com.segment.analytics.integrations.Integration

class Segment(private val applicationContext: Context) {
    private val integrations: Array<Integration.Factory> = emptyArray()

    fun configure(writeKey: String, trackApplicationLifecycleEvents: Boolean, debug: Boolean) {
        val analyticsBuilder = Analytics.Builder(applicationContext, writeKey)

        if (trackApplicationLifecycleEvents) {
            analyticsBuilder.trackApplicationLifecycleEvents()
        }
        if (debug) {
            analyticsBuilder.logLevel(Analytics.LogLevel.DEBUG)
        }

        for (integration in integrations) {
            analyticsBuilder.use(integration)
        }

        Analytics.setSingletonInstance(analyticsBuilder.build())
    }
    
    fun identify(userId: String, traits: Traits, options: Options) {
        Analytics.with(this.applicationContext).identify(userId, traits, options)
    }

    fun track(eventName: String, properties: Properties, options: Options) {
        Analytics.with(this.applicationContext).track(eventName, properties, options)
    }

    fun screen(screenName: String, properties: Properties, options: Options) {
        Analytics.with(this.applicationContext).screen(null, screenName, properties, options)
    }

    fun group(groupId: String, traits: Traits, options: Options) {
        Analytics.with(this.applicationContext).group(groupId, traits, options)
    }

    fun alias(alias: String, options: Options) {
        Analytics.with(this.applicationContext).alias(alias, options)
    }

    fun getAnonymousId(): String {
        return Analytics.with(this.applicationContext).analyticsContext.traits().anonymousId()
    }

    fun reset() {
        Analytics.with(this.applicationContext).reset()
    }

    fun disable() {
        Analytics.with(this.applicationContext).optOut(true)
    }

    fun enable() {
        Analytics.with(this.applicationContext).optOut(false)
    }

    fun setContext(context: HashMap<String, Any>) {
        // TODO
    }
}
