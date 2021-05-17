import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:wear/utils/api.dart';
import 'package:wear/utils/colors.dart';
import 'package:wear/widget/iconbutton.dart';

class PlacePage extends StatefulWidget {
  Map<String, dynamic> location;
  PlacePage({this.location});
  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return getUI();
  }

  getUI() {
    List<dynamic> photos = widget.location["result"]["photos"];
    List<Image> images = [];
    for (dynamic photo in photos) {
      images.add(Image.network(
        API.parsePhotoString(photo["photo_reference"]),
        fit: BoxFit.cover,
      ));
    }
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
                SizedBox(
                    height: 300.0,
                    child: Carousel(
                      images: images,
                      showIndicator: false,
                      indicatorBgPadding: 2,
                      borderRadius: false,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.grey[50],
                      overlayShadowSize: 0.5,
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      IconButtonWidget(
                        buttonText: "Get Directions",
                        icon: Icons.gps_fixed,
                        buttonColor: AppColors.error,
                        onPressed: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          print(
                              availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                          await availableMaps.first.showMarker(
                            coords: Coords(widget.location["latitude"],
                                widget.location["longitude"]),
                            title: widget.location["location_name"],
                          );
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      IconButtonWidget(
                        buttonText: "Map View",
                        icon: Icons.gps_fixed,
                        buttonColor: AppColors.error,
                        onPressed: () async {
                          final availableMaps = await MapLauncher.installedMaps;
                          print(
                              availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                          await availableMaps.first.showMarker(
                            coords: Coords(widget.location["latitude"],
                                widget.location["longitude"]),
                            title: widget.location["location_name"],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                getRow(
                    title: "Estimated Crowd",
                    subtitle: "[Values for Estimated Crowd Here]",
                    iconData: Icons.person),
                getRow(
                    title: "Address",
                    subtitle: "${widget.location["address"]}",
                    iconData: Icons.location_pin),
                getRow(
                    title: "Phone Number",
                    subtitle:
                        "${widget.location["result"]["formatted_phone_number"]}",
                    iconData: Icons.phone),

                getRow(
                    title: "Safe to Visit",
                    subtitle: "${widget.location["safe_to_visit"]}",
                    iconData: Icons.favorite),
                getRow(
                    title: "Best Hours",
                    subtitle: "${widget.location["best_hours"]}",
                    iconData: Icons.timelapse),
                // Text("${getPrettyJSONString(widget.location)}")
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
    );
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  getRow({String title, String subtitle, IconData iconData}) {
    return ListTile(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 16, color: AppColors.error, fontWeight: FontWeight.w800),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.black,
        ),
        maxLines: 4,
      ),
      trailing: Icon(
        iconData,
        color: AppColors.grey,
      ),
    );
  }
}
