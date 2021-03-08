import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Segment.configure('<write-key>');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Segment example app'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              TextButton(
                child: Text('Identify'),
                onPressed: () {
                  Segment.identify('test-user',
                    traits: {
                      'name': 'Test User',
                    },
                  );
                },
              ),
              TextButton(
                child: Text('Track Event'),
                onPressed: () {
                  Segment.track('ExampleButtonClicked',
                    properties: {
                      'foo': 'bar',
                      'number': 47,
                      'clicked': true,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      navigatorObservers: [
        SegmentRouteTracker(),
      ],
    );
  }
}
