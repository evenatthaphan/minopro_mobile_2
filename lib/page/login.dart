import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/choose_register.dart';
import 'package:flutter_minipro2/page/user/HomepageUser.dart';
import 'package:flutter_minipro2/page/user/register_user.dart';
import 'package:flutter_minipro2/page/user/sender/HmoePageSender.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true, // อนุญาตให้เลื่อนเมื่อแป้นพิมพ์ขึ้นมา
      body: SingleChildScrollView(
        child: Stack(
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
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.43,
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // จัดการ padding ตามแป้นพิมพ์
              ),
              child: Column(
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
                          'ชื่อผู้ใช้',
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
                              _usernameController, // เชื่อมโยง controller กับ TextField
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
                        child: TextField(
                          controller: _passwordController,
                          obscureText:
                              !_isPasswordVisible, // Toggle password visibility
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(108, 3, 104, 1),
                                  width: 2),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.05),
                        child: SizedBox(
                          width: screenSize.width *
                              0.4, // ใช้ความกว้างของหน้าจอ 40%
                          height: screenSize.height *
                              0.06, // ใช้ความสูงของหน้าจอ 6%
                          child: FilledButton(
                            onPressed: () {
                              loginUser();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 124, 18, 148)),
                            ),
                            child: Text(
                              'เข้าสู่ระบบ',
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.04),
                            ),
                          ),
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
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageUser(),
      ),
    );
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
