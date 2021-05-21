import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wear/utils/api.dart';

import 'loading.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: API.getStatistics(),
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

  getUI(Map<String, dynamic> map) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: Text("Statistics"),
          border: null,
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([Text("$map")]),
              ),
            )
          ],
        ));
  }
}
