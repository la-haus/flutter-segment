import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Segment example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('TRACK ACTION WITH SEGMENT'),
            onPressed: () async {
              await FlutterSegment.track(
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
