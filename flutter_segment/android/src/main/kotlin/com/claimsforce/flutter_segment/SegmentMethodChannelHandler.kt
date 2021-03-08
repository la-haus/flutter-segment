package com.claimsforce.flutter_segment

import com.segment.analytics.Options
import com.segment.analytics.Properties
import com.segment.analytics.Traits
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class SegmentMethodChannelHandler(private val segment: Segment) : MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "configure" -> onConfigure(call, result)
            "identify" -> onIdentify(call, result)
            "track" -> onTrack(call, result)
            "screen" -> onScreen(call, result)
            "group" -> onGroup(call, result)
            "alias" -> onAlias(call, result)
            "getAnonymousId" -> onGetAnonymousId(result)
            "reset" -> onReset(result)
            "disable" -> onDisable(result)
            "enable" -> onEnable(result)
            "setContext" -> onSetContext(call, result)
            else -> result.notImplemented()
        }
    }

    private fun onConfigure(call: MethodCall, result: Result) {
        val writeKey: String = call.argument("writeKey")!!
        val trackApplicationLifecycleEvents: Boolean = call.argument("trackApplicationLifecycleEvents")!!
        val debug: Boolean = call.argument("debug")!!

        result.success(this.segment.configure(writeKey, trackApplicationLifecycleEvents, debug))
    }

    private fun onIdentify(call: MethodCall, result: Result) {
        val userId: String = call.argument("userId")!!
        val traitsData: HashMap<String, Any> = call.argument("traits")!!
        val optionsData: HashMap<String, Any> = call.argument("options")!!

        val traits = mapTraits(traitsData)
        val options = mapOptions(optionsData)

        result.success(this.segment.identify(userId, traits, options))
    }

    private fun onTrack(call: MethodCall, result: Result) {
        val eventName: String = call.argument("eventName")!!
        val propertiesData: HashMap<String, Any> = call.argument("properties")!!
        val optionsData: HashMap<String, Any> = call.argument("options")!!

        val properties = mapProperties(propertiesData)
        val options = mapOptions(optionsData)

        result.success(this.segment.track(eventName, properties, options))
    }

    private fun onScreen(call: MethodCall, result: Result) {
        val screenName: String = call.argument("screenName")!!
        val propertiesData: HashMap<String, Any> = call.argument("properties")!!
        val optionsData: HashMap<String, Any> = call.argument("options")!!

        val properties = mapProperties(propertiesData)
        val options = mapOptions(optionsData)

        result.success(this.segment.screen(screenName, properties, options))
    }

    private fun onGroup(call: MethodCall, result: Result) {
        val groupId: String = call.argument("groupId")!!
        val traitsData: HashMap<String, Any> = call.argument("traits")!!
        val optionsData: HashMap<String, Any> = call.argument("options")!!

        val traits = mapTraits(traitsData)
        val options = mapOptions(optionsData)

        result.success(this.segment.group(groupId, traits, options))
    }

    private fun onAlias(call: MethodCall, result: Result) {
        val alias: String = call.argument("alias")!!
        val optionsData: HashMap<String, Any> = call.argument("options")!!

        val options = mapOptions(optionsData)

        result.success(this.segment.alias(alias, options))
    }

    private fun onGetAnonymousId(result: Result) {
        result.success(this.segment.getAnonymousId())
    }

    private fun onReset(result: Result) {
        result.success(this.segment.reset())
    }

    private fun onDisable(result: Result) {
        result.success(this.segment.disable())
    }

    private fun onEnable(result: Result) {
        result.success(this.segment.enable())
    }

    private fun onSetContext(call: MethodCall, result: Result) {
        val contextData: HashMap<String, Any> = call.argument("context")!!

        result.success(this.segment.setContext(contextData))
    }

    private fun mapTraits(traitsData: HashMap<String, Any>): Traits {
        val traits = Traits()
        for ((key, value) in traitsData) {
            traits.putValue(key, value)
        }
        return traits
    }

    private fun mapProperties(propertiesData: HashMap<String, Any>): Properties {
        val properties = Properties()
        for ((key, value) in propertiesData) {
            properties.putValue(key, value)
        }
        return properties
    }

    private fun mapOptions(optionsData: HashMap<String, Any>) : Options {
        val options = Options()
        // TODO
        return options
    }
}
