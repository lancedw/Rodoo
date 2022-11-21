import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodo/.env.dart';
import 'package:rodo/models/directions.dart';

class DirectionsRepository {
  static const String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio dio;

  DirectionsRepository({Dio? dio}) : dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleAPI_Key,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      try {
        return Directions.fromMap(response.data);
      } catch (err) {
        print("\'$err\' =>> caught in directions_repository");
        return null;
      }
    }
    return null;
  }
}
