import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wear/pages/map.dart';
import 'package:wear/pages/statistics.dart';
import 'package:wear/utils/colors.dart';
import 'package:wear/utils/transition.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color color = HexColor("#494F56");
  Color color2 = HexColor("#6CE5E8");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: Material(
          child: InkWell(
            child: Icon(
              Icons.arrow_back_outlined,
              color: color,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        border: null,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text(
                "Statistics",
                style: TextStyle(
                    fontSize: 14, color: color, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     CupertinoPageRoute(builder: (context) => StatisticsPage()));
              },
            ),
            FlatButton(
              child: Text(
                "Map View",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.color,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => MapScreen()));
              },
            ),
            FlatButton(
              child: Text(
                "Scan Qr Code",
                style: TextStyle(
                    fontSize: 14, color: color, fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                var result = await BarcodeScanner.scan();
                print(result.rawContent);
                launchURL(result.rawContent);
              },
            ),
          ],
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
