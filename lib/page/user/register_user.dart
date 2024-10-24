import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_minipro2/page/SysHome.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? _imageUrl;
  TextEditingController nameNoCtl = TextEditingController();
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController addressNoCtl = TextEditingController();
  TextEditingController passwordNoCtl = TextEditingController();
  TextEditingController confirmpasswordNoCtl = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  LatLng latLng = LatLng(15.998009549056942, 102.53815639596311);
  double latitude = 0.0;
  double longitude = 0.0;
  MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        latLng = LatLng(
            position.latitude, position.longitude); // อัปเดตค่าตำแหน่งเริ่มต้น
        latitude = position.latitude; // อัปเดตค่า latitude
        longitude = position.longitude; // อัปเดตค่า longitude
      });
    }).catchError((error) {
      log('Error getting current position: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 41, 126),
        title: const Text(
          'ลงทะเบียนผู้ใช้ทั่วไป',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ผูกฟอร์มกับ GlobalKey
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Card.outlined(
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 140, 17, 159),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      'เลือกภาพจากแกลลอรี่',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('ชื่อผู้ใช้'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: nameNoCtl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('เบอร์โทรศัพท์'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: phoneNoCtl,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกหมายเลขโทรศัพท์';
                        } else if (value.length != 10) {
                          return 'เบอร์โทรศัพท์ต้องมี 10 หลัก';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('เลือกพิกัดที่อยู่'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // ทำให้ปุ่มและช่องข้อความอยู่ในแนวเดียวกัน
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0, 0.0, 20.0),
                          child: TextFormField(
                            controller: addressNoCtl,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'กรุณากรอกที่อยู่';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10.0, 0, 20.0, 20.0), // ปรับระยะห่างของปุ่ม
                        child: ElevatedButton(
                          onPressed: () async {
                            _showMap();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: const CircleBorder(),
                            padding:
                                const EdgeInsets.all(15), // เพิ่มขนาดปุ่ม GPS
                          ),
                          child: const Icon(
                            Icons.gps_fixed,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Latitude: ${latitude.toString()}, Longitude: ${longitude.toString()}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Divider(color: Colors.black),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('รหัสผ่าน'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10),
                    child: TextFormField(
                      controller: passwordNoCtl,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text('ยืนยันรหัสผ่าน'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10),
                    child: TextFormField(
                      controller: confirmpasswordNoCtl,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณายืนยันรหัสผ่าน';
                        } else if (value != passwordNoCtl.text) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // ถ้าผ่านการตรวจสอบ ให้ดำเนินการลงทะเบียน
                        register();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 181, 91, 175),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Text(
                      'ลงทะเบียน',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _uploadImage(_image!);
        log("ImageUrl");
      } else {
        Get.snackbar('Message Error !!!', 'เลือกสักรุปสิ 🤔',
            snackPosition: SnackPosition.TOP);
        log("No image selected");
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      log("filename");
      String fileName = '${Uuid().v4()}.jpg'; // เปลี่ยนชื่อไฟล์ให้ไม่ซ้ำ
      Reference ref = FirebaseStorage.instance.ref('Images/$fileName');

      // อัปโหลดไฟล์ไปยัง Firebase Storage
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      log("url");
      // ตรวจสอบสถานะการอัปโหลด
      if (snapshot.state == TaskState.success) {
        // รับ URL ของรูปภาพที่อัปโหลด
        _imageUrl = await ref.getDownloadURL();
        log('Image uploaded successfully: $_imageUrl'); // แสดง URL ใน log
      } else {
        log('Upload failed with state: ${snapshot.state}');
      }
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Future<void> _showMap() async {
    showDialog(
      context: context,
      builder: (context) {
        LatLng tempLatLng = latLng; // ใช้ตำแหน่งอุปกรณ์เป็นค่าเริ่มต้น
        return AlertDialog(
          title: const Text('Map'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: StatefulBuilder(
              builder: (context, setState) {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter: tempLatLng, // ใช้ตำแหน่งอุปกรณ์
                    initialZoom: 13.0,
                    onTap: (tapPosition, point) {
                      // อัปเดตค่าพิกัดเมื่อจิ้มบนแผนที่
                      setState(() {
                        tempLatLng = point;
                        latitude = point.latitude;
                        longitude = point.longitude;
                        _updateAddress(
                            point); // เรียกใช้งานฟังก์ชันเพื่ออัปเดตที่อยู่
                        log('Latitude: ${point.latitude}, Longitude: ${point.longitude}');
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: tempLatLng,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // อัปเดตค่าพิกัดสุดท้ายก่อนปิด dialog
                setState(() {
                  latLng = tempLatLng;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateAddress(LatLng point) async {
    try {
      // แปลงพิกัด GPS เป็นที่อยู่
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );

      // รับที่อยู่และอัปเดตใน TextField
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address =
            '${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}';
        setState(() {
          addressNoCtl.text = address; // อัปเดตที่อยู่ใน TextField
        });
      }
    } catch (e) {
      log('Error getting address: $e');
    }
  }

  void _showCoordinates(LatLng point) {
    longitude = point.longitude;
    latitude = point.latitude;
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    // ตรวจสอบสถานะการอนุญาต
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw Exception('Location permissions are denied');
      }
    }

    // รับพิกัดปัจจุบัน
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void register() async {
    // รับค่าจาก controller และใช้ trim เพื่อลบช่องว่าง
    String name = nameNoCtl.text.trim();
    String phone = phoneNoCtl.text.trim();
    String address = addressNoCtl.text.trim();
    String password = passwordNoCtl.text.trim();
    String confirmPassword = confirmpasswordNoCtl.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Message Error !!!', 'รหัสผ่านไม่ถูกต้อง ลองใหม่อีกครั้ง',
          snackPosition: SnackPosition.TOP);
    } else if (_imageUrl == null) {
      const SnackBar(
        content: Text('เลือกสักรุปสิ 🤔.'),
      );
    }

    if (password == confirmPassword &&
        name.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        password.isNotEmpty &&
        phone.length == 10 && // เช็คเบอร์โทรศัพท์ต้องเป็น 10 ตัว
        latitude != 0.0 && // เช็ค latitude
        longitude != 0.0 && // เช็ค longitude
        _imageUrl != null) {
      // Log field values สำหรับการ debug
      log('Name: $name');
      log('Phone: $phone');
      log('Address: $address');
      log('Password: $password');
      log('Latitude: $latitude');
      log('Longitude: $longitude');
      log('Image URL: $_imageUrl');

      try {
        // อ้างอิงถึง Collection "Users"
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        // ตรวจสอบว่าหมายเลขโทรศัพท์นี้มีอยู่แล้วหรือไม่
        DocumentSnapshot existingUser = await users.doc(phone).get();

        if (existingUser.exists) {
          // แสดงข้อผิดพลาดหากหมายเลขโทรศัพท์มีอยู่แล้ว
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('This phone number is already registered.')),
          );
          return;
        }

        // เพิ่มข้อมูลไปยัง Firestore
        // await users.doc(phone).set({
        await users.add({
          'name': name,
          'phone': phone,
          'address': address,
          'password': password,
          'image': _imageUrl,
          'latitude': latitude,
          'longitude': longitude,
          'type': 'user',
        });

        log('User registered successfully in Firestore');
        // นำทางไปยังหน้า home หากการสมัครสำเร็จ
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SystemHomePage(),
          ),
        );
      } catch (error) {
        log('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during registration: $error')),
        );
      }
    } else {
      // แสดงข้อผิดพลาดหากข้อมูลไม่ถูกต้อง
      String errorMessage = 'Please fill all fields';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
