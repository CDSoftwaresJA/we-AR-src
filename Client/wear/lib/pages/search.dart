import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/pages/place_page.dart';
import 'package:wear/utils/api.dart';
import 'package:wear/widget/row.dart';

import 'loading.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: API.searchLocation("S"),
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
        middle: Text('Search'),
        border: null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                print(API.parsePhotoString(
                    arr[index]["result"]["photos"][0]["photo_reference"]));
                return LocationRow(
                  description1: "${arr[index]["result"]["formatted_address"]}",
                  description2:
                      "${arr[index]["result"]["formatted_phone_number"]}",
                  name: arr[index]["location_name"],
                  count: arr[index]["live_count"],
                  photo: API.parsePhotoString(
                      arr[index]["result"]["photos"][0]["photo_reference"]),
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => PlacePage(
                              location: arr[index],
                            )));
                  },
                );
              }, childCount: arr.length),
            ),
          )
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
