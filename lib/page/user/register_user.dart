import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController confirmPasswordCtl = TextEditingController();
  TextEditingController gpsCtl = TextEditingController();
  File? image;
  LatLng? latLng;
  bool isLoading = false;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.25,
              child: Card(
                color: const Color.fromARGB(255, 247, 182, 254),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.05,
                    left: screenSize.width * 0.05,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/images/user.png',
                          width: screenSize.width * 0.3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ผู้ใช้ทั่วไป",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.purple[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "ลงทะเบียนผู้ใช้",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.26,
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
              ),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                        height: screenSize.height * 0.2,
                        child: Card.outlined(),
                      ),
                      ElevatedButton(
                        onPressed: choosePhotos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[900],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'เลือกภาพจากแกลอรี่',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  buildTextField('ชื่อ-สกุล : ', nameCtl),
                  buildTextField('อีเมลล์ : ', emailCtl),
                  buildTextField('เบอร์โทรศัพท์ : ', phoneCtl, maxLength: 10),
                  buildPasswordField('รหัสผ่าน : ', passwordCtl),
                  buildPasswordField('ยืนยันรหัสผ่าน : ', confirmPasswordCtl),
                  buildGPSButton(),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.05),
                      child: FilledButton(
                        onPressed: register,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 3, 103, 18),
                          ),
                        ),
                        child: Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                              fontSize: screenSize.width * 0.04),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {int? maxLength}) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          TextField(
            controller: controller,
            maxLength: maxLength,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 247, 182, 254),
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 247, 182, 254),
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGPSButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: currentMap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
            child: const Text("GPS",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          const SizedBox(width: 10), // Add some space between button and text field
          Expanded(
            child: TextField(
              controller: gpsCtl, // Use the new GPS controller
              enabled: false, // Keep it disabled as it's for display only
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 247, 182, 254),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    if (nameCtl.text.isEmpty ||
        phoneCtl.text.isEmpty ||
        passwordCtl.text.isEmpty ||
        confirmPasswordCtl.text.isEmpty ||
        image == null ||
        latLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    } else if (passwordCtl.text != confirmPasswordCtl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน')),
      );
    } else {
      // Call the registerNewUser function
      await registerNewUser();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('การลงทะเบียนเสร็จสมบูรณ์')),
      );
    }
  }

  Future<void> registerNewUser() async {
    int newUserId = await generateNewUserId();
    String? pathImage;
    if (image != null) {
      pathImage = await uploadImage(image!);
    }
    var data = {
      'id': newUserId,
      'name': nameCtl.text,
      'email': emailCtl.text,
      'phone': phoneCtl.text,
      'latLng': {'latitude': latLng!.latitude, 'longitude': latLng!.longitude},
      'password': passwordCtl.text,
      'image': pathImage,
    };

    await db.collection('user').doc(newUserId.toString()).set(data);
  }

  Future<int> generateNewUserId() async {
    QuerySnapshot querySnapshot = await db
        .collection('user')
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int lastId = querySnapshot.docs.first['id'];
      return lastId + 1;
    } else {
      return 1;
    }
  }

  Future<String> uploadImage(File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child("images/$uniqueFileName.jpg");
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void choosePhotos() {
    // Implement photo selection logic
  }

  void currentMap() async {
    try {
      var position = await _determinePosition();
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        // Update the GPS TextField with coordinates
        gpsCtl.text = '${position.latitude}, ${position.longitude}';
      });

      // Show the dialog with coordinates
      _showLocationDialog(position.latitude, position.longitude);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  void _showLocationDialog(double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ตำแหน่งของคุณ'),
          content: Text('Latitude: $latitude\nLongitude: $longitude'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Store the coordinates in latLng if the user confirms
                  latLng = LatLng(latitude, longitude);
                });
                Navigator.of(context).pop();
              },
              child: const Text('เลือก'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ยกเลิก'),
            ),
          ],
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}

class LatLng {
  final double latitude;
  final double longitude;
  LatLng(this.latitude, this.longitude);
}
