import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_minipro2/config/shared/app_data.dart';
import 'package:flutter_minipro2/page/user/profilepage.dart';
import 'package:flutter_minipro2/page/user/receiver/Home.dart';
import 'package:flutter_minipro2/page/user/receiver/HomePageRecive.dart';
import 'package:flutter_minipro2/page/user/sender/HomePageSender.dart';
import 'package:provider/provider.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  var currentWidget;
  late UserProfile user;

  @override
  void initState() {
    super.initState();
    currentWidget = const HomePageUser(); // Set default widget
    user = context.read<AppData>().user;
    log('UserProfile: ${user.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'หน้าหลัก',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ),
      body: Consumer<AppData>(builder: (context, appData, child) {
        UserProfile user =
            appData.user; // เข้าถึง UserProfile ที่เก็บไว้ใน AppData
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width * 1,
                height: screenSize.height * 0.20,
                child: Card(
                  color: Color.fromARGB(255, 247, 182, 254),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: screenSize.height * 0.01),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user.image),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenSize.height * 0.01,
                                left: screenSize.width * 0.05),
                            child: Text(
                              'Name : ${user.name}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.01),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "คุณต้องการ ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "ส่งสินค้า ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "หรือ ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "รับสินค้า",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height * 0.05),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenSize.width * 0.6,
                              height: screenSize.height * 0.25,
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/recive.png',
                                        width: screenSize.width * 0.3,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: registeruser,
                                      child: Text(
                                        'รับสินค้า',
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: screenSize.width * 0.06,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.6,
                              height: screenSize.height * 0.25,
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/sender.png',
                                        width: screenSize.width * 0.3,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: registerrider,
                                      child: Text(
                                        'ส่งสินค้า',
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontSize: screenSize.width * 0.06,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
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
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            const Color.fromARGB(255, 222, 125, 239), // Background color
        selectedItemColor:
            const Color.fromARGB(255, 83, 23, 133), // Color for selected item
        unselectedItemColor: Colors.black, // Color for unselected items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_sharp), label: 'โปรไฟล์'),
        ],
        onTap: (value) {
          log(value.toString());
          setState(() {
            if (value == 0) {
              currentWidget = const HomePageUser(); // Replace with home page
            } else if (value == 1) {
              currentWidget = const ProfilePage(); // Replace with profile page
            }
          });
        },
      ),
    );
  }

  void registeruser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePageReceiver()),
    );
  }

  void registerrider() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePageSender()),
    );
  }
}
