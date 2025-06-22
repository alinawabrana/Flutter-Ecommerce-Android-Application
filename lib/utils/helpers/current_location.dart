import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  return await Geolocator.getCurrentPosition();
}

Future<String?> getCountryFromLocation(Position position) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  return placemarks.first.country;
}

Future<String?> getCountryFromIP() async {
  final response = await http.get(Uri.parse('https://ipapi.co/json/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['country_name']; // or 'country_code'
  } else {
    return null;
  }
}
