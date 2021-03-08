package com.claimsforce.flutter_segment

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/** FlutterSegmentPlugin */
class FlutterSegmentPlugin: FlutterPlugin {
  private lateinit var channel : MethodChannel

  companion object {
    @JvmStatic
    fun registerWith(registrar: PluginRegistry.Registrar) {
      val instance = FlutterSegmentPlugin()
      instance.setupChannels(registrar.messenger(), registrar.context())
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    setupChannels(flutterPluginBinding.binaryMessenger, flutterPluginBinding.applicationContext)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    teardownChannels()
  }

  private fun setupChannels(messenger: BinaryMessenger, context: Context) {
    this.channel = MethodChannel(messenger, "com.claimsforce.flutter_segment")

    val segment = Segment(context)

    val methodChannelHandler = SegmentMethodChannelHandler(segment)
    this.channel.setMethodCallHandler(methodChannelHandler)
  }

  private fun teardownChannels() {
    this.channel.setMethodCallHandler(null)
  }
}
