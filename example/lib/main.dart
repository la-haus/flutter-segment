import 'package:flutter/material.dart';
import 'package:flutter_segment/segment.dart';

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
                eventName: 'TestEvent',
                properties: {
                  'price': 12.22,
                  'product': 'TestProduct',
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
