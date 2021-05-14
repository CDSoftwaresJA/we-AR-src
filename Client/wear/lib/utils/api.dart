import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class API {
  static String endpoint = "https://18.116.105.133:8080/";

  static Future<Map<String, dynamic>> getLocations() async {
    try {
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var response = await dio.get(endpoint + "locations");
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> getStatistics() async {
    try {
      Dio dio = Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var response = await dio.get(endpoint + "mobile/statistics");
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
