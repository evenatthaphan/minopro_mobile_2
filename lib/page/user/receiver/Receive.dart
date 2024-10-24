import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/receiver/Navbar.dart';
import 'package:flutter_minipro2/page/user/receiver/WidgetShareReceive.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(148, 100, 195, 0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: screenSize.height * 0.17,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.06,
              ),
              child: Text(
                "สินค้าที่ต้องรับ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.1,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          SingleChildScrollView(
            child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                child: WidgetShareCardItem(
                    linkImageProfile:
                        "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg",
                    name: "น้ำตาล",
                    phone: "024156342",
                    isPage: false,
                    listImage: [
                      "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg",
                      "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg",
                      "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg",
                      "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg",
                      "https://thethaiger.com/th/wp-content/uploads/2024/07/GRNwk3Ua8AATdQU.--1480x833.jpg"
                    ],
                    nameImage: [
                      "อาเรีย",
                      "อาเรีย",
                      "อาเรีย",
                      "อาเรีย",
                      "อาเรีย"
                    ])),
          )
        ],
      ),
      bottomNavigationBar: NavbarReceiveShare(
          selectedIndex: selectedIndex, onDestinationSelected: (value) {}),
    );
  }
}
