import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Segment.screen(
      screenName: 'Example Screen',
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Segment example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('TRACK ACTION WITH SEGMENT'),
            onPressed: () {
              Segment.track(
                eventName: 'ButtonClicked',
                properties: {
                  'foo': 'bar',
                  'number': 1337,
                  'clicked': true,
                },
              );
            },
          ),
        ),
      ),
      navigatorObservers: [
        SegmentObserver(),
      ],
    );
  }
}
