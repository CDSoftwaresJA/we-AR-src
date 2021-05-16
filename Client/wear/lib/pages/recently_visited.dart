import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/pages/loading.dart';
import 'package:wear/pages/place_page.dart';
import 'package:wear/utils/api.dart';
import 'package:wear/utils/colors.dart';
import 'package:wear/widget/row.dart';

class RecentlyVisited extends StatefulWidget {
  @override
  _RecentlyVisitedState createState() => _RecentlyVisitedState();
}

class _RecentlyVisitedState extends State<RecentlyVisited> {
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
        middle: Text('Recently Visited'),
        border: null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return LocationRow(
                  description1: "Description 1",
                  description2: "Description 2",
                  name: arr[index]["location_name"],
                  count: arr[index]["crowd_estimation"],
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

  recentlyVisited(bool completed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
