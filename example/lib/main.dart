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
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('TRACK ACTION'),
            onPressed: () async {
              final id = await FlutterSegment.getAnonymousId;
              print('anonymousId: $id');
            },
          ),
        ),
      ),
    );
  }
}
