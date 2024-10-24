import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_minipro2/page/SysHome.dart';
import 'package:flutter_minipro2/page/rider/Home.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class RegisterRiderPage extends StatefulWidget {
  const RegisterRiderPage({super.key});

  @override
  State<RegisterRiderPage> createState() => _RegisterRiderPageState();
}

class _RegisterRiderPageState extends State<RegisterRiderPage> {
  TextEditingController nameNoCtl = TextEditingController();
  TextEditingController phoneNoCtl = TextEditingController();
  TextEditingController carNoCtl = TextEditingController();
  TextEditingController passwordNoCtl = TextEditingController();
  TextEditingController confirmpasswordNoCtl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? _imageUrl;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: const Color.fromARGB(255, 107, 41, 126),
          // title: const Text(
          //   'ลงทะเบียนผู้ใช้ทั่วไป',
          //   style: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          // ),
          ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ผูกฟอร์มกับ GlobalKey
          child: Column(
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
                            'assets/images/delivery.png',
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
                                "ไรเดอร์",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.purple[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "ลงทะเบียนไรเดอร์",
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
              const SizedBox(height: 20),
              Center(
                child: Card.outlined(
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
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
                    child: Text('หมายเลขทะเบียนรถ'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: TextFormField(
                      controller: carNoCtl,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'กรุณากรอกหมายเลขทะเบียนรถ';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
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
                    onPressed: isRegistering
                        ? null // Disable button if `isRegistering` is true
                        : () {
                            // Validate the form
                            if (_formKey.currentState?.validate() ?? false) {
                              // Proceed with registration if validation passes
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


  void register() async {
    setState(() {
      isRegistering = true; // ปิดการใช้งานปุ่มเมื่อเริ่มการลงทะเบียน
    });

    // รับค่าจาก controller และใช้ trim เพื่อลบช่องว่าง
    String name = nameNoCtl.text.trim();
    String phone = phoneNoCtl.text.trim();
    String carnum = carNoCtl.text.trim();
    String password = passwordNoCtl.text.trim();
    String confirmPassword = confirmpasswordNoCtl.text.trim();

    if (password != confirmPassword) {
      // แสดง SnackBar ถ้ารหัสผ่านไม่ตรงกัน
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('รหัสผ่านไม่ถูกต้อง ลองใหม่อีกครั้ง.'),
        ),
      );
      setState(() {
        isRegistering = false; // เปิดการใช้งานปุ่มอีกครั้ง
      });
      return; // หยุดการทำงานถ้ารหัสผ่านไม่ตรงกัน
    } else if (_imageUrl == null) {
      // แสดง SnackBar ถ้าไม่มีการเลือกภาพ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('เลือกสักรุปสิ 🤔.'),
        ),
      );
      setState(() {
        isRegistering = false; // เปิดการใช้งานปุ่มอีกครั้ง
      });
      return; // หยุดการทำงานถ้าไม่มีการเลือกภาพ
    }

    // ตรวจสอบว่ารหัสผ่านตรงกัน, เบอร์โทรศัพท์มีความยาว 10 หลัก และทุก field ไม่เป็นค่าว่างหรือ null
    if (password == confirmPassword &&
        name.isNotEmpty &&
        phone.isNotEmpty &&
        carnum.isNotEmpty &&
        _imageUrl != null) {
      // ตรวจสอบเบอร์โทรศัพท์ว่ามีความยาว 10 หลักหรือไม่
      if (phone.length != 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone number must be 10 digits long')),
        );
        setState(() {
          isRegistering = false; // เปิดการใช้งานปุ่มอีกครั้ง
        });
        return; // หยุดการทำงานถ้าเบอร์โทรไม่ถูกต้อง
      }

      log("data");

      // Log field values สำหรับการ debug
      log('Name: $name');
      log('Phone: $phone');
      log('carnum: $carnum');
      log('Password: $password');
      log('Image URL: $_imageUrl');

      try {
        // อ้างอิงถึง Collection "Riders"
        CollectionReference users =
            FirebaseFirestore.instance.collection('Users');

        // ตรวจสอบว่าหมายเลขโทรศัพท์นี้มีอยู่แล้วหรือไม่
        DocumentSnapshot existingUser = await users.doc(phone).get();

        if (existingUser.exists) {
          // แสดงข้อผิดพลาดหากหมายเลขโทรศัพท์มีอยู่แล้ว
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('หมายเลขโทรศัพท์นี้ถูกลงทะเบียนแล้ว.')),
          );
          setState(() {
            isRegistering = false; // เปิดการใช้งานปุ่มอีกครั้ง
          });
          return;
        }

        // เพิ่มข้อมูลไปยัง Firestore โดยให้สร้าง Document ID เป็นหมายเลขโทรศัพท์
        await users.doc(phone).set({
          'name': name,
          'phone': phone,
          'carnum': carnum,
          'password': password,
          'image': _imageUrl,
          'type': 'rider', // เพิ่มฟิลด์ type เป็น 'rider'
        });

        log('Rider registered successfully in Firestore');
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
    }

    setState(() {
      isRegistering = false; // เปิดการใช้งานปุ่มอีกครั้งหลังจากเสร็จสิ้น
    });
  }
}
