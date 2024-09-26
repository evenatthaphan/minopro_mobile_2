import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/login.dart';
import 'package:flutter_minipro2/page/user/register_user.dart';

class SystemHomePage extends StatefulWidget {
  const SystemHomePage({super.key});

  @override
  State<SystemHomePage> createState() => _SystemHomePageState();
}

class _SystemHomePageState extends State<SystemHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(children: [
        SizedBox(
          width: screenSize.width * 1, // ขยายความกว้างของ Card
          height: screenSize.height * 0.5, // ขยายความสูงของ Card
          child: Card(
            color: const Color.fromARGB(255, 247, 182, 254),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Stack(
                alignment: Alignment.center, // จัดให้อยู่ตรงกลาง
                children: [
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
          padding: EdgeInsets.only(top: screenSize.height * 0.4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
          
                // Hello and Welcome Section
                Column(
                  children: [
                    Text(
                      'Hello 👋',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[900],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Welcome to Delivery App',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.purple[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
          
                // Buttons Section
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[900], // Background color
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[100], // Background color
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'ลงทะเบียน',
                        style: TextStyle(fontSize: 16, color: Colors.purple[900]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegirterPage(),
      ),
    );
  }
}
