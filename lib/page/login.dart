import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_minipro2/page/choose_register.dart';
import 'package:flutter_minipro2/page/rider/Home.dart';
import 'package:flutter_minipro2/page/user/HomepageUser.dart';
import 'package:flutter_minipro2/page/user/register_user.dart';
import 'package:flutter_minipro2/page/user/sender/HomePageSender.dart';
import 'package:provider/provider.dart';
import 'package:flutter_minipro2/config/shared/app_data.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController PhoneNoCtl = TextEditingController();
  TextEditingController PasswordNoCtl = TextEditingController();

  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true, // อนุญาตให้เลื่อนเมื่อแป้นพิมพ์ขึ้นมา
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ผูกฟอร์มกับ GlobalKey
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width * 1, // ขยายความกว้างของ Card
                height: screenSize.height * 0.4, // ขยายความสูงของ Card
                child: Card(
                  color: const Color.fromARGB(255, 247, 182, 254),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Stack(
                      alignment: Alignment.center, // จัดให้อยู่ตรงกลาง
                      children: [
                        // วงกลมสีม่วงอยู่ด้านหลัง
                        Container(
                          width: screenSize.width * 0.6,
                          height: screenSize.width *
                              0.6, // ให้เป็นวงกลมโดยใช้ width และ height เท่ากัน
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple, // สีม่วง
                          ),
                        ),
                        // รูปภาพอยู่ด้านหน้า
                        SizedBox(
                          child: Image.asset(
                            'assets/images/login.png',
                            width: screenSize.width * 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.02),
                    child: const Center(
                      child: Column(
                        children: [
                          Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenSize.width * 0.6,
                            top: screenSize.height * 0.03),
                        child: Text(
                          'เบอร์โทรศัพท์',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: screenSize.width * 0.04,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.15,
                            right: screenSize.width * 0.15,
                            top: screenSize.height * 0.02),
                        child: TextField(
                          controller:
                              PhoneNoCtl, // เชื่อมโยง controller กับ TextField
                              keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 1,
                            )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(108, 3, 104, 1),
                                  width: 2), // เปลี่ยนขอบเป็นสีม่วงเมื่อคลิก
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 230, top: screenSize.height * 0.03),
                        child: Text(
                          'รหัสผ่าน',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: screenSize.width * 0.04,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.15,
                            right: screenSize.width * 0.15,
                            top: screenSize.height * 0.02),
                        child: TextFormField(
                        controller: PasswordNoCtl,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'กรุณากรอกรหัสผ่าน';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(0, 255, 255, 255),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: screenSize.width*0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            // ตรวจสอบฟอร์ม
                            if (_formKey.currentState!.validate()) {
                              // ถ้าฟอร์มผ่านการ validate
                              loginUser();
                            } else {
                              // แสดงข้อผิดพลาดถ้าฟอร์มไม่ผ่านการ validate
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 105, 14, 130),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)), // มุมไม่โค้ง
                            ),
                          ),
                          child: Text('เข้าสู่ระบบ', style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: screenSize.width * 0.04)),
                        ),
                      ),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.02),
                      child: Text(
                        'คุณยังไม่มีบัญชีใช่หรือไม่ ?',
                        style: TextStyle(fontSize: screenSize.width * 0.04),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.02),
                      child: TextButton(
                        onPressed: register,
                        child: Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 120, 3, 155),
                              fontSize: screenSize.width * 0.04),
                        ),
                      ),
                    )
                  ],
                )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async{
   
  String phone = PhoneNoCtl.text.trim();
  String password = PasswordNoCtl.text.trim();

  if (phone.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text(
            'Phone number and password cannot be empty or contain only spaces'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return;
  }

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('phone', isEqualTo: phone)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;
      String documentId = querySnapshot.docs.first.id;

      String userType = userDoc['type'] ?? '';

      if (userType == 'user') {
        UserProfile userProfile = UserProfile(
          id: documentId, // แก้ไขการเข้าถึงค่า 'id'
          name: userDoc['name'] ?? '', // แก้ไขการเข้าถึงค่า 'name'
          phone: userDoc['phone'] ?? '', // แก้ไขการเข้าถึงค่า 'phone'
          address: userDoc['address'] ?? '', // แก้ไขการเข้าถึงค่า 'address'
          image: userDoc['image'] ?? '', // แก้ไขการเข้าถึงค่า 'image'
          latitude: double.tryParse(userDoc['latitude']?.toString() ?? '0.0') ?? 0.0,
          longitude: double.tryParse(userDoc['longitude']?.toString() ?? '0.0') ?? 0.0,
          type: userDoc['type'] ?? '',
        );

        Provider.of<AppData>(context, listen: false).updateUser(userProfile);

        log('Document ID: $documentId');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageUser(),
          ),
        );

        log('This user is a user.');
      } else if (userType == 'rider') {
        RiderProfile riderProfile = RiderProfile(
          id: documentId, // แก้ไขการเข้าถึงค่า 'id'
          name: userDoc['name'] ?? '', // แก้ไขการเข้าถึงค่า 'name'
          phone: userDoc['phone'] ?? '', // แก้ไขการเข้าถึงค่า 'phone'
          image: userDoc['image'] ?? '', // แก้ไขการเข้าถึงค่า 'image'
          vehicle: userDoc['vehicle'] ?? '', // แก้ไขการเข้าถึงค่า 'vehicle'
          type: userDoc['type'] ?? '',
        );

        Provider.of<AppData>(context, listen: false).updateRider(riderProfile);

        log('Document ID: $documentId');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageRider(),
          ),
        );

        log('This user is a rider.');
      } else {
        log('Unknown user type');
      }
    } else {
      log('User not found or incorrect password');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ไม่พบผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!'),
        ),
      );
    }
  } catch (error) {
    log('Error: $error');
  }


  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChooseRegisterPage(),
      ),
    );
  }
}
