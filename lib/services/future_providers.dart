/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:accomation_assignment/models/weather_model.dart';
import 'package:accomation_assignment/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getWeatherFutureProvider = FutureProvider<WeatherModel>((ref) async {
  return (await RepositoryClass.getWeatherResponse())!;
});
