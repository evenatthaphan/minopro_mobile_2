import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_minipro2/page/user/receiver/Navbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  int selectedIndex = 2;
  final LatLng _initialFirst = const LatLng(16.246251, 103.252456);
  final LatLng _initialSecond = const LatLng(16.251339, 103.238766);
  final MapController _mapController = MapController();
  List<LatLng> routePoints = [];
  bool isLoading = false;
  String distance = '';
  String duration = '';

  @override
  void initState() {
    super.initState();
    getRoutePoints();
  }

  Future<void> getRoutePoints() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://router.project-osrm.org/route/v1/driving/${_initialFirst.longitude},${_initialFirst.latitude};${_initialSecond.longitude},${_initialSecond.latitude}?overview=full&geometries=geojson'));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final coordinates =
            decoded['routes'][0]['geometry']['coordinates'] as List;

        // Get distance in kilometers (rounded to 2 decimal places)
        final distanceInMeters = decoded['routes'][0]['distance'] as num;
        final distanceInKm = (distanceInMeters / 1000).toStringAsFixed(2);

        // Get duration in minutes (rounded to nearest minute)
        final durationInSeconds = decoded['routes'][0]['duration'] as num;
        final durationInMinutes = (durationInSeconds / 60).round();

        setState(() {
          routePoints = coordinates
              .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
              .toList();
          distance = 'ระยะทาง: $distanceInKm กม.';
          duration = 'เวลา: $durationInMinutes นาที';
        });
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _zoomIn() {
    final newZoom = _mapController.camera.zoom + 1;
    _mapController.move(_mapController.camera.center, newZoom);
  }

  void _zoomOut() {
    final newZoom = _mapController.camera.zoom - 1;
    _mapController.move(_mapController.camera.center, newZoom);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Full screen map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialFirst,
              initialZoom: 15.0,
              minZoom: 5.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: _initialFirst,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  Marker(
                    width: 80,
                    height: 80,
                    point: _initialSecond,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Zoom controls

          // Loading indicator
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          // Overlaid bottom panel
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.01),
                      child: Row(
                        children: [
                          Container(
                            width: screenSize.width * 0.2,
                            height: screenSize.width * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildText("ชื่อ", "นายบาส"),
                              _buildText("ทะเบียนรถ", "ขน1245"),
                              _buildText("หมายเลขออร์เดอร์", "10"),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenSize.width * 0.04),
                                child: Text("• ส้มตำ , ไก่ย่าง"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Container(
                      height: 1.7,
                      width: screenSize.width,
                      color: Colors.black, // สีของเส้น
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เส้นทาง",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.05),
                        ), // Adjusted text
                        const Icon(Icons.close_rounded),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.08,
                          vertical: screenSize.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          const Icon(Icons.send),
                                          SizedBox(
                                              width: screenSize.width * 0.02),
                                          const Column(
                                            children: [
                                              Text("ตำแหน่งของชั้น"),
                                              Text("หอพักบ้านสบาย"),
                                            ],
                                          )
                                        ],
                                      )),
                                      const Icon(Icons.more_vert_sharp)
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.01),
                                  Container(
                                    height: 1.7,
                                    width: screenSize.width * 0.5,
                                    color: Colors.black, // สีของเส้น
                                  ),
                                  SizedBox(height: screenSize.height * 0.01),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          SizedBox(
                                              width: screenSize.width * 0.02),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("จุดหมาย"),
                                              Text("หอพักบ้านสบาย"),
                                            ],
                                          )
                                        ],
                                      )),
                                      const Icon(Icons.more_vert_sharp)
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.006),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      distance,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold), /*  */
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      duration,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavbarReceiveShare(
          selectedIndex: selectedIndex, onDestinationSelected: (value) {}),
    );
  }

  Widget _buildText(
    String firsttext,
    String name,
  ) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "$firsttext: "),
          TextSpan(
            text: name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(134, 19, 153, 1)),
          ),
        ],
      ),
    );
  }
}
