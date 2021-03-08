import Flutter
import UIKit

public class SwiftFlutterSegmentAmplitudeIntegrationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_segment_amplitude_integration", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSegmentAmplitudeIntegrationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
