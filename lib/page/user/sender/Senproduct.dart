import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/sender/ProductPageSender.dart';
import 'package:flutter_minipro2/page/user/sender/navbar_sender.dart';

class Senproduct extends StatefulWidget {
  const Senproduct({super.key});

  @override
  State<Senproduct> createState() => _SenproductState();
}

class _SenproductState extends State<Senproduct> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.2,
              child: Card(
                color: Color.fromARGB(255, 210, 133, 246),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize.height * 0.07,
                    left: screenSize.width * 0.15,
                  ),
                  child: const Text(
                    "รายการสินค้าที่จะจัดส่ง",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 69, 2, 81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Send To Row
            Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.02,
                left: screenSize.width * 0.02,
                right: screenSize.width * 0.02,
              ),
              child: Row(
                children: [
                  const Text("ส่งให้ : ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                    "น้องเจมส์",
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 2, 81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Product List Section
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.02),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            // child: Image.asset(
                            //   "assets/images/ball.png", // Update with your actual image path
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ลูกบอล",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text("เลขที่สินค้า : 1"),
                              Text("รายละเอียดสินค้า"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            // child: Image.asset(
                            //   "assets/images/colors.png", // Update with your actual image path
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "สีไม้",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text("เลขที่สินค้า : 2"),
                              Text("รายละเอียดสินค้า"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Button and Navbar
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: screenSize.height * 0.07,
              child: ElevatedButton(
                onPressed: senproduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'ส่งสินค้า',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          UserNavbarPage(
            selectedIndex: 0,
            onDestinationSelected: (value) {},
            screenSize: screenSize,
          ),
        ],
      ),
    );
  }

  void senproduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatusPageSender (),
      ),
    );
  }
}
