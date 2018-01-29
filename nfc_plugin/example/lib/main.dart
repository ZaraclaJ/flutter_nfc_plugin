import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_plugin/nfc_plugin.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isNFCSupported = false;
  bool _isNFCEnable = false;


  @override
  initState() {
    super.initState();
    initNFCState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initNFCState() async {
    bool isNFCSupported;
    bool isNFCEnable;

    try {
      isNFCSupported = await NfcPlugin.isSupported();
    } on Exception {
      isNFCSupported = false;
    }

    try {
      isNFCEnable = await NfcPlugin.isEnable();
    } on Exception {
      isNFCEnable = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted)
      return;

    setState(() {
      _isNFCSupported = isNFCSupported;
      _isNFCEnable = isNFCEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new ListView(children: <Widget>[
            new Text('Availability : $_isNFCSupported\n'),
            new Text('Enability : $_isNFCEnable\n'),
            new IconButton(icon: new Icon(Icons.update), onPressed: initNFCState)
          ]),
        ),
      ),
    );
  }
}
