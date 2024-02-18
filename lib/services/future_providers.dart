/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:accomation_assignment/models/location_model.dart';
import 'package:accomation_assignment/models/parameter_models.dart';
import 'package:accomation_assignment/models/weather_model.dart';
import 'package:accomation_assignment/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getWeatherFutureProvider = FutureProvider.family<WeatherModel, GetWeatherFPParams>((ref, params) async {
  return (await RepositoryClass.getWeatherResponse(params.lat, params.long))!;
});

final getUserLocationFutureProvider = FutureProvider<LocationModel>((ref) async {
  return await RepositoryClass.getUserLocation();
});
