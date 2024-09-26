import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body: Stack(children: [
        Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenSize.height*0.45),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 182, 254),
                ),
              ),
            ),
          ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon or Image Section
              Container(
                color: Colors.pink[50],
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.delivery_dining,
                      size: 100,
                      color: Colors.pink,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'DELIVERY',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
                
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
                    onPressed: () {
                      // Add login functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[900], // Background color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                    onPressed: () {
                      // Add register functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[100], // Background color
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
      ]),
    );
  }
}
