/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

import 'package:equatable/equatable.dart';

class GetWeatherFPParams extends Equatable {
  final double lat;
  final double long;

  const GetWeatherFPParams({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}
