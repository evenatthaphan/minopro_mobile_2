import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreenPage extends StatefulWidget {
  const MapScreenPage({super.key});

  @override
  State<MapScreenPage> createState() => _MapScreenPageState();
}

class _MapScreenPageState extends State<MapScreenPage> {
  final popupLayerController = PopupController();
  LatLng latLng = const LatLng(16.246825669508297, 103.25199289277295);
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _zoomIn() {
    final newZoom = mapController.camera.zoom + 1;
    mapController.move(mapController.camera.center, newZoom);
  }

  void _zoomOut() {
    final newZoom = mapController.camera.zoom - 1;
    mapController.move(mapController.camera.center, newZoom);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(children: [
        // Header
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(148, 100, 195, 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: screenSize.height * 0.17,
          child: Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.04),
            child: const Center(
              child: Text(
                "จุดรับสินค้า",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: latLng,
                  initialZoom: 15.0,
                  onTap: (_, __) => popupLayerController.hideAllPopups(),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                    maxNativeZoom: 19,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: latLng,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          size: 30,
                          color: Color.fromARGB(255, 177, 17, 5),
                        ),
                      ),
                    ],
                  ),
                  PopupMarkerLayer(
                    options: PopupMarkerLayerOptions(
                      popupController: popupLayerController,
                      markers: [
                        Marker(
                          point: latLng,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            size: 30,
                            color: Color.fromARGB(255, 177, 17, 5),
                          ),
                        ),
                      ],
                      popupDisplayOptions: PopupDisplayOptions(
                        builder: (BuildContext context, Marker marker) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Latitude: ${marker.point.latitude}\nLongitude: ${marker.point.longitude}',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Zoom controls
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      mini: true,
                      onPressed: _zoomIn,
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: "btn2",
                      mini: true,
                      onPressed: _zoomOut,
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        onPressed: () async {
          await requestLocationPermission();
          try {
            var position = await _determinePosition();
            setState(() {
              latLng = LatLng(position.latitude, position.longitude);
            });
            mapController.move(latLng, 15.0);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
