import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:wealth_and_health_frontend/models/analytics.dart";
import "package:wealth_and_health_frontend/models/location.dart";
import "package:wealth_and_health_frontend/requests.dart";

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _currentPosition = LatLng(0, 0);
  Map<String, List<AnalyticsEntry>> _analyticsOfLocation = {};
  Map<String, MapLocation> _locLookup = {};

  Set<Marker> _markers = {};

  late bool _disposed;

  Future<void> _fetchMarkers() async {
    final response = await FetchRequest("location").commit();
    final result = jsonDecode(response.body);

    // get locations
    final locationsRaw = result["locations"] as List<dynamic>;
    final locations = locationsRaw.map(MapLocation.fromJson);
    final Map<String, MapLocation> locLookup = {};
    for (var location in locations) {
      locLookup[location.id] = location;
    }

    // analytics from json with location lookup funtion
    curriedAnalyticsFromJson(dynamic json) {
      return AnalyticsEntry.fromJsonWithLocation(json, locLookup);
    }

    // get analytics
    final analyticsRawMap = result["analytics"] as Map<String, dynamic>;
    Map<String, List<AnalyticsEntry>> analyticsOfLocation = {};
    for (var analyticRaw in analyticsRawMap.entries) {
      final locId = analyticRaw.key;
      final analyticRawList = analyticRaw.value as List<dynamic>;
      final analyticList =
          analyticRawList.map(curriedAnalyticsFromJson).toList();
      analyticsOfLocation[locId] = analyticList;
    }

    if (_disposed) {
      return;
    }

    setState(() {
      _analyticsOfLocation = analyticsOfLocation;
      _locLookup = locLookup;
    });

    for (var location in locLookup.values) {
      _addMarker(location.coord, location.name, location.id);
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition();
    if (!_disposed) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    }

    // Move camera to current location
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 15.0),
      ),
    );
  }

  Future<void> _setMapStyle(GoogleMapController controller) async {
    String style = await rootBundle.loadString('assets/map_style.json');
    controller.setMapStyle(style);
  }

  void _addMarker(LatLng position, String title, String locationId) {
    Marker newMarker = Marker(
      markerId: MarkerId(locationId),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: "Tap to see average spending per week here",
        onTap: () {
          _onMarkerTapped(locationId);
        },
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ), // Custom color
    );

    if (!_disposed) {
      setState(() {
        _markers.add(newMarker);
      });
    }
  }

  /// Show dialog when a marker is tapped
  void _onMarkerTapped(String locationId) {
    final location = _locLookup[locationId] ?? fallbackLocation;

    final locationName = location.name;

    if (_analyticsOfLocation[locationId] == null) {
      Fluttertoast.showToast(msg: "This location is currently unavailable");
      return;
    }

    final analyticTexts = _analyticsOfLocation[locationId]!.map((dataPoint) {
      final catName = dataPoint.category.name;
      final catAvg = dataPoint.average;
      final catN = dataPoint.n;

      return "$catN spending(s) on $catName with average of $catAvg";
    });

    final analyticText = analyticTexts.join("\n\n");

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Average Spending"),
            content: Text(
              "Average Spending at $locationName: \n\n$analyticText",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    _disposed = false;
    super.initState();
    _fetchMarkers();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _currentPosition,
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        _setMapStyle(controller);
      },
      myLocationEnabled: true, // Show blue dot for user's location
      myLocationButtonEnabled:
          true, // Show button to recenter to user's location
      markers: _markers,
    );
  }
}
