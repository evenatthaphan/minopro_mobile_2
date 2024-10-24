import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendItemPage extends StatefulWidget {
  const SendItemPage({super.key});

  @override
  State<SendItemPage> createState() => _SendItemPageState();
}

class _SendItemPageState extends State<SendItemPage> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "เส้นทาง",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.05),
                        ), // Adjusted text
                        Icon(Icons.close_rounded),
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
                                          Icon(Icons.send),
                                          SizedBox(
                                              width: screenSize.width * 0.02),
                                          Column(
                                            children: [
                                              Text("ตำแหน่งของชั้น"),
                                              Text("หอพักบ้านสบาย"),
                                            ],
                                          )
                                        ],
                                      )),
                                      Icon(Icons.more_vert_sharp)
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
                                          Icon(Icons.location_on),
                                          SizedBox(
                                              width: screenSize.width * 0.02),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("จุดหมาย"),
                                              Text("หอพักบ้านสบาย"),
                                            ],
                                          )
                                        ],
                                      )),
                                      Icon(Icons.more_vert_sharp)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("รายละเอียด",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 0.04)),
                                  Text(distance),
                                  Text(duration)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("หมายเลขออร์เดอร์",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenSize.width * 0.04)),
                                  Text("ผู้รับ: น้องเจมส์"),
                                  Text("โทร: 0234566789")
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Center(
                            child: SizedBox(
                              width: screenSize.width * 0.45,
                              child: FilledButton(
                                  style: FilledButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(99, 172, 106, 1)),
                                  onPressed: () {},
                                  child: Text("ถึงจุดรับแล้ว",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenSize.width * 0.04,
                                      ))),
                            ),
                          )
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
    );
  }
  // return Scaffold(
  //   body: Column(
  //     children: [
  // Card(
  //   color: const Color.fromRGBO(181, 77, 183, 0.2),
  //   margin: const EdgeInsets.all(8.0),
  //   child: Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Column(
  //           children: [
  //             const Icon(Icons.directions_car, color: Colors.blue),
  //             const SizedBox(height: 4),
  //             Text(
  //               distance,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             const Text('ระยะทาง'),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             const Icon(Icons.timer, color: Colors.blue),
  //             const SizedBox(height: 4),
  //             Text(
  //               duration,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //             const Text('เวลาโดยประมาณ'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ),
  // ),
  // Expanded(
  //   child: Stack(
  //     children: [
  //       FlutterMap(
  //         mapController: _mapController,
  //         options: MapOptions(
  //           initialCenter: _initialFirst,
  //           initialZoom: 15.0,
  //           minZoom: 5.0,
  //           maxZoom: 18.0,
  //         ),
  //         children: [
  //           TileLayer(
  //             urlTemplate:
  //                 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //             userAgentPackageName: 'com.example.app',
  //           ),
  //           PolylineLayer(
  //             polylines: [
  //               Polyline(
  //                 points: routePoints,
  //                 strokeWidth: 4,
  //                 color: Colors.blue,
  //               ),
  //             ],
  //           ),
  //           MarkerLayer(
  //             markers: [
  //               Marker(
  //                 width: 80,
  //                 height: 80,
  //                 point: _initialFirst,
  //                 child: const Icon(
  //                   Icons.location_pin,
  //                   color: Colors.red,
  //                   size: 40,
  //                 ),
  //               ),
  //               Marker(
  //                 width: 80,
  //                 height: 80,
  //                 point: _initialSecond,
  //                 child: const Icon(
  //                   Icons.location_pin,
  //                   color: Colors.blue,
  //                   size: 40,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       Positioned(
  //         right: 16,
  //         bottom: 100,
  //         child: Column(
  //           children: [
  //             FloatingActionButton(
  //               heroTag: "btn1",
  //               mini: true,
  //               onPressed: _zoomIn,
  //               child: const Icon(Icons.add),
  //             ),
  //             const SizedBox(height: 8),
  //             FloatingActionButton(
  //               heroTag: "btn2",
  //               mini: true,
  //               onPressed: _zoomOut,
  //               child: const Icon(Icons.remove),
  //             ),
  //           ],
  //         ),
  //       ),
  //       if (isLoading)
  //         const Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //     ],
  //   ),
  // ),
  // Expanded(
  //   child: Container(
  //     height: screenSize.height * 0.4,
  //     width: screenSize.width,
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(
  //           255, 141, 36, 36), // กำหนดสีพื้นหลังที่นี่
  //       borderRadius:
  //           BorderRadius.all(Radius.circular(60)), // ทำให้ขอบโค้งมน
  //     ),
  //     clipBehavior: Clip.antiAlias, // กำหนดให้ขอบโค้งมนแสดงผล
  //   ),
  // )

  // Padding(
  //   padding: const EdgeInsets.all(16.0),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       FloatingActionButton(
  //         onPressed: () {
  //           final currentZoom = _mapController.camera.zoom;
  //           _mapController.move(
  //             _mapController.camera.center,
  //             currentZoom + 1,
  //           );
  //         },
  //         child: const Icon(Icons.add),
  //       ),
  //       FloatingActionButton(
  //         heroTag: 'btn2',
  //         onPressed: () {
  //           final currentZoom = _mapController.camera.zoom;
  //           _mapController.move(
  //             _mapController.camera.center,
  //             currentZoom - 1,
  //           );
  //         },
  //         child: const Icon(Icons.remove),
  //       ),
  //     ],
  //   ),
  // ),
  //     ],
  //   ),
  // );
}
