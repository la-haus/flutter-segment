import 'package:meta/meta.dart';
import 'package:flutter_segment/segment_platform_interface.dart';

class SegmentPlatformWeb extends SegmentPlatform {
  Future<void> identify({
    @required userId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    throw UnimplementedError();
  }

  Future<void> track({
    @required String eventName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    throw UnimplementedError();
  }

  Future<void> screen({
    @required String screenName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    throw UnimplementedError();
  }

  Future<void> group({
    @required String groupId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  }) async {
    throw UnimplementedError();
  }

  Future<void> alias({
    @required String alias,
    Map<String, dynamic> options,
  }) async {
    throw UnimplementedError();
  }

  Future<String> get getAnonymousId async {
    throw UnimplementedError();
  }

  Future<void> reset() async {
    throw UnimplementedError();
  }

  Future<void> disable() async {
    throw UnimplementedError();
  }

  Future<void> enable() async {
    throw UnimplementedError();
  }

  Future<void> debug(bool enabled) async {
    throw UnimplementedError();
  }

  Future<void> putDeviceToken(String token) async {
    throw UnimplementedError();
  }
}
