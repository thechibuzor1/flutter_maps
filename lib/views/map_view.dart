import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconly/iconly.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'dart:math';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Location location = Location();
  final MapController mapController = MapController();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  LatLng? _destination;
  List<LatLng> _randomLocations = [];
  bool _isModalVisible = false;

  @override
  void initState() {
    super.initState();
    initLocation();
  }

  Future<void> initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();
    if (_locationData != null) {
      setState(() {
        final myLocation = LatLng(
          _locationData!.latitude ?? 0.0,
          _locationData!.longitude ?? 0.0,
        );

        // Generate random locations around user's position
        _randomLocations = _generateRandomPoints(myLocation);
        mapController.move(myLocation, 12);
      });
    }
  }

  List<LatLng> _generateRandomPoints(LatLng location, {int count = 7}) {
    final random = Random();
    return List.generate(count, (_) {
      final randomLatOffset = (random.nextDouble() - 0.5) * 0.05;
      final randomLngOffset = (random.nextDouble() - 0.5) * 0.05;
      return LatLng(location.latitude + randomLatOffset,
          location.longitude + randomLngOffset);
    });
  }

  void _onMapTap(LatLng point) {
    setState(() {
      _destination = point;
      _isModalVisible = true;
      mapController.move(_destination!, 14);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (_, point) => _onMapTap(point),
              initialZoom: 5,
              initialCenter:
                  LatLng(0.0, 0.0), // Default center before location is loaded
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                retinaMode: true,
              ),
              MarkerLayer(
                markers: [
                  if (_locationData != null)
                    Marker(
                      point: LatLng(
                        _locationData!.latitude ?? 0,
                        _locationData!.longitude ?? 0,
                      ),
                      width: 30,
                      height: 30,
                      child:
                          _buildCircularMarker(Colors.blue, IconlyBold.profile),
                    ),
                  if (_destination != null)
                    Marker(
                      point: _destination!,
                      width: 30,
                      height: 30,
                      child: _buildCircularMarker(
                          Colors.purple, IconlyBold.location),
                    ),
                  for (final marker in _randomLocations)
                    Marker(
                      point: marker,
                      width: 30,
                      height: 30,
                      child: _buildCircularMarker(
                          Colors.orange, IconlyBold.location),
                    ),
                ],
              ),
              if (_locationData != null && _destination != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        LatLng(
                          _locationData!.latitude ?? 0.0,
                          _locationData!.longitude ?? 0.0,
                        ),
                        _destination!,
                      ],
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  ],
                ),
            ],
          ),
          if (_isModalVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Destination Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Distance: ${(calculateDistance(_locationData!, _destination!)).toStringAsFixed(2)} km',
                    ),
                    Text(
                      'Estimated time: 40mins',
                    ),
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(top: 8), // Adjust the margin here
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        onPressed: () {},
                        child: const Text('Start Trip',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0), // Adjust the margin here
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isModalVisible = false;
                          });
                        },
                        child: const Text('Close'),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCircularMarker(Color color, IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 15,
      ),
    );
  }

  double calculateDistance(LocationData myLocation, LatLng destination) {
    if (myLocation.latitude == null || myLocation.longitude == null) {
      return 0.0; // Handle invalid location data.
    }

    final myLatLng = LatLng(myLocation.latitude!, myLocation.longitude!);
    final distance = Distance();
    return distance.as(LengthUnit.Kilometer, myLatLng, destination);
  }
}
