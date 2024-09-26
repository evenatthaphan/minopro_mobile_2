import 'package:flutter/material.dart';

class RegirterPage extends StatefulWidget {
  const RegirterPage({super.key});

  @override
  State<RegirterPage> createState() => _RegirterPageState();
}

class _RegirterPageState extends State<RegirterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController wallet = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,  // ซ่อนลูกศรชี้กลับ
        //   ),
        body: SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            width: screenSize.width * 1, // ขยายความกว้างของ Card
            height: screenSize.height * 0.25, // ขยายความสูงของ Card
            child: Card(
              color: Color.fromARGB(255, 247, 182, 254),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenSize.height * 0.05,
                      left: screenSize.width * 0.05),
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
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "ลงทะเบียนผู้ใช้",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height * 0.26,
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width:
                              screenSize.width * 0.5, // ขยายความกว้างของ Card
                          height:
                              screenSize.height * 0.2, // ขยายความสูงของ Card
                          child: Card.outlined()),
                      ElevatedButton(
                        onPressed: choosePhotos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.purple[900], // Background color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ชื่อ-สกุล : '),
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 247, 182, 254),
                                width: 2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.02),
                        child: const Text('อีเมลล์ : '),
                      ),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 247, 182, 254),
                                width: 2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.02),
                        child: const Text('เบอร์โทรศัพท์ : '),
                      ),
                      TextField(
                        maxLength: 10,
                        controller: phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 247, 182, 254),
                                width: 2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.02),
                        child: const Text('รหัสผ่าน : '),
                      ),
                      TextField(
                        controller: password,
                        // obscureText:
                        //     !_isPasswordVisible, // This line only needs to appear once
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 247, 182, 254),
                                width: 2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // _isPasswordVisible
                              //     ? Icons.visibility
                              Icons.visibility_off,
                            ),
                            onPressed: () {
                              // setState(() {
                              //   _isPasswordVisible = !_isPasswordVisible;
                              // });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.02),
                        child: const Text('ยืนยันรหัสผ่าน : '),
                      ),
                      SizedBox(height: screenSize.height * 0.015),
                      TextField(
                        // controller: confirmPassword,
                        // obscureText:
                        //     !_isPasswordVisible1, // This line only needs to appear once
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 247, 182, 254),
                                width: 2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // _isPasswordVisible1
                              //     ? Icons.visibility
                              Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                // _isPasswordVisible1 = !_isPasswordVisible1;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    ));
  }

  void registeruser() {}

  void registerrider() {}

  void choosePhotos() {}
}
