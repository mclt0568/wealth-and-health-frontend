import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation {
  final String id;
  final String name;
  final LatLng coord;

  MapLocation({required this.id, required this.name, required this.coord});

  factory MapLocation.fromJson(dynamic json) {
    return switch (json) {
      {
        "_id": String id,
        "name": String name,
        "lat": double lat,
        "long": double lng,
      } =>
        MapLocation(id: id, name: name, coord: LatLng(lat, lng)),
      {
        "_id": String id,
        "name": String name,
        "lat": int lat,
        "long": double lng,
      } =>
        MapLocation(id: id, name: name, coord: LatLng(lat.toDouble(), lng)),
      {
        "_id": String id,
        "name": String name,
        "lat": double lat,
        "long": int lng,
      } =>
        MapLocation(id: id, name: name, coord: LatLng(lat, lng.toDouble())),
      {
        "_id": String id,
        "name": String name,
        "lat": int lat,
        "long": int lng,
      } =>
        MapLocation(
          id: id,
          name: name,
          coord: LatLng(lat.toDouble(), lng.toDouble()),
        ),
      _ => throw const FormatException('Failed to load location.'),
    };
  }
}

final fallbackLocation = MapLocation(
  id: "0",
  name: "Unnamed Location",
  coord: LatLng(0, 0),
);
