import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Scanner Page"),
        border: null,
      ),
    );
  }
}
