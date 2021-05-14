import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/pages/loading.dart';
import 'package:wear/utils/api.dart';

class PlacePage extends StatefulWidget {
  Map<String, dynamic> location;
  PlacePage({this.location});
  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: API.getLocations(),
        builder: (context, snapshot) {
          Widget child = LoadingPage();
          if (snapshot.hasData) {
            print(snapshot.data["locations"]);
            child = getUI(snapshot.data);
          }
          return AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: child,
          );
        });
  }

  getUI(Map<String, dynamic> locations) {
    var arr = locations["locations"];
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.location["location_name"]),
        border: null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                Text("${widget.location}")
                // Get Directions
              ]),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: scanCode,
      //   label: Text("Scan"),
      //   icon: Icon(Icons.camera_alt),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
