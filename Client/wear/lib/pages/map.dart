import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wear/pages/place_page.dart';
import 'package:wear/utils/api.dart';

import 'loading.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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

  getUI(Map<String, dynamic> locationSnapshot) {
    var locations = locationSnapshot["locations"];
    List<String> hours = [];
    Set<Marker> markers = Set<Marker>();
    for (var location in locations) {
      int y = 0;

      for (int i in location["best_hours"]) {
        hours.add("$i:00");
        y++;
      }

      Marker marker = Marker(
        markerId: MarkerId("${location["location_id"]}"),
        position: LatLng(location["latitude"], location["longitude"]),
        infoWindow: InfoWindow(
            title: location["location_name"],
            // snippet:
            //     'Live Count: ${location["live_count"]} \nTime Recommendation: ${location["best_hours"]} ',
            snippet:
                'Estimated Crowd: ${location["crowd_estimation"]} \nTime Recommendation:  ${hours.toString().replaceAll("[", '').replaceAll("]", '')}',
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => PlacePage(
                        location: location,
                      )));
            }),
      );
      markers.add(marker);
    }
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: null,
        middle: Text("Map View"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(locations[0]["latitude"], locations[0]["longitude"]),
          zoom: 13,
        ),
        markers: markers,
      ),
    );
  }
}
