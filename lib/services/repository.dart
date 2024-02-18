/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'dart:convert';

import 'package:accomation_assignment/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

import '../config.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class RepositoryClass {
  static Future<WeatherModel?> getWeatherResponse(double lat, double long) async {
    var response = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<LocationModel> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationModel(position: null, error: 'Location services are disabled. Turn on GPS and retry!');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationModel(position: null, error: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationModel(position: null, error: 'Location permissions are permanently denied, we cannot request permissions.');
    }

    var position = await Geolocator.getCurrentPosition();
    return LocationModel(position: position, error: null);
  }
}
