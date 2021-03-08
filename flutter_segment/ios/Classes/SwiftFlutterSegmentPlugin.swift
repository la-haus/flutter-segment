import Flutter
import UIKit

public class SwiftFlutterSegmentPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.claimsforce.flutter_segment", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSegmentPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "configure":
        onConfigure(call, result)
      case "identify":
        onIdentify(call, result)
      case "track":
        onTrack(call, result)
      case "screen":
        onScreen(call, result)
      case "group":
        onGroup(call, result)
      case "alias":
        onAlias(call, result)
      case "getAnonymousId":
        onGetAnonymousId(result)
      case "reset":
        onReset(result)
      case "disable":
        onDisable(result)
      case "enable":
        onEnable(result)
      case "setContext":
        onSetContext(call, result)
      default:
        result(FlutterMethodNotImplemented)
    }
    
    result("iOS " + UIDevice.current.systemVersion)
  }

  private func onConfigure(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onIdentify(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onTrack(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onScreen(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onGroup(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onAlias(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }

  private func onGetAnonymousId(_ result: FlutterResult) {
  }

  private func onReset(_ result: FlutterResult) {
  }

  private func onDisable(_ result: FlutterResult) {
  }

  private func onEnable(_ result: FlutterResult) {
  }

  private func onSetContext(_ call: FlutterMethodCall, _ result: FlutterResult) {
  }
}
