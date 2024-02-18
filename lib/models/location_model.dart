/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:geolocator/geolocator.dart';

class LocationModel{
  final Position? position;
  final String? error;

  LocationModel({required this.position, required this.error});
}