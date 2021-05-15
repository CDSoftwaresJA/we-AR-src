import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/pages/loading.dart';
import 'package:wear/pages/place_page.dart';
import 'package:wear/pages/recently_visited.dart';
import 'package:wear/utils/api.dart';
import 'package:wear/utils/colors.dart';
import 'package:wear/utils/transition.dart';
import 'package:wear/widget/row.dart';

import 'menu.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        leading: Material(
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context, createRoute(MenuPage()));
            },
          ),
        ),
        trailing: Material(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        middle: Text('Dashboard'),
        border: null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              recentlyVisited(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => RecentlyVisited()));
              }),
            ]),
          ),
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

  recentlyVisited(VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: 50,
            color: AppColors.error,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.place,
                  color: Colors.white,
                ),
                Text(
                  "Recently Visited",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
