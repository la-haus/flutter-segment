import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

void main() {
  // ensures flutter has initialized, so we can set the context
  WidgetsFlutterBinding.ensureInitialized();

  Segment.setContext({
    'device': {
      'token': 'testing'
    }
  });

  runApp(MyApp());
}

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
        body: Column(
          children: <Widget>[
            Spacer(),

            Center(
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

            Spacer(),

            Center(
              child: FlatButton(
                child: Text('Update Context'),
                onPressed: () {
                  Segment.setContext({
                    'custom': 123
                  });
                },
              ),
            ),

            Spacer(),
          ],
        ),
      ),
      navigatorObservers: [
        SegmentObserver(),
      ],
    );
  }
}
