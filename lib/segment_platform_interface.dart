import 'package:meta/meta.dart';

abstract class SegmentPlatform {
  Future<void> identify({
    @required userId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  });

  Future<void> track({
    @required String eventName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  });

  Future<void> screen({
    @required String screenName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  });

  Future<void> group({
    @required String groupId,
    Map<String, dynamic> traits,
    Map<String, dynamic> options,
  });

  Future<void> alias({
    @required String alias,
    Map<String, dynamic> options,
  });

  Future<String> get getAnonymousId;

  Future<void> reset();

  Future<void> disable();

  Future<void> enable();

  Future<void> debug(bool enabled);

  Future<void> putDeviceToken(String token);
}
