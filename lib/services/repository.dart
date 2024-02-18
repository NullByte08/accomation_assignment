/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'dart:convert';

import '../config.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class RepositoryClass {
  static Future<WeatherModel?> getWeatherResponse() async {
    var response = await http.get(
      Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=28.7041&lon=77.1025&appid=$apiKey"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
