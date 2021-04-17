import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';

void main() =>
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Hey There";
  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan(); //open activity when scan method is called
      setState(() {
        result = qrResult;
      });
    }
    on PlatformException catch (except){
      if(except.code == BarcodeScanner.cameraAccessDenied){
        setState(() {
          result = "Camera permission was not granted";
        });
      }else{
        setState(() {
          result = "Unknown error occurred $except";
        });
      }
    }
    on FormatException{
      setState(() {
        result = "Back button was pressed before scanning was done";
      });
    }
    catch(except){
      setState(() {
        result = "Unknown error occurred $except";
      });
    }

  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text("Test"),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => NextPage()));
                Fluttertoast.showToast(
                    msg: "This is Center Short Toast",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 12.0);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
