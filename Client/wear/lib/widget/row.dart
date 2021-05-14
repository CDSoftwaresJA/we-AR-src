import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:wear/utils/colors.dart';

class LocationRow extends StatelessWidget {
  final String name, description1, description2;
  final int count;
  final VoidCallback onTap;
  LocationRow(
      {this.name,
      this.description1,
      this.description2,
      this.onTap,
      this.count});

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    String url =
        "https://source.unsplash.com/20${rng.nextInt(9)}x20${rng.nextInt(9)}/?cardio";

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) =>
                      BlurHash(hash: "L3G[ZwkC00V@00WB00of00ofLzWB"),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 86,
                  width: 86,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.name,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.color,
                      fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Container(
                          height: 20,
                          width: 120,
                          color: AppColors.error,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Live Count : $count",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  this.description1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.color2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  this.description2,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.color,
                  ),
                  maxLines: 4,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
