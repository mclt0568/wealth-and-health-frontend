import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class MapPage extends StatefulWidget {
  MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng _currentPosition = LatLng(0, 0);

  Set<Marker> _markers = {}; // Store all markers

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
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

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

  void _addMarker(LatLng position, String title) {
    Marker newMarker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: "Tap for more info",
        onTap: () {
          _onMarkerTapped(title);
        },
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ), // Custom color
    );

    setState(() {
      _markers.add(newMarker);
    });
  }

  /// Show dialog when a marker is tapped
  void _onMarkerTapped(String markerTitle) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Marker Tapped"),
            content: Text("You tapped on: $markerTitle"),
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
  void initState() {
    super.initState();
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
