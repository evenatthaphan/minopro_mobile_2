import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/sender/Senproduct.dart';
import 'package:flutter_minipro2/page/user/sender/navbar_sender.dart';

class insertProductPage extends StatefulWidget {
  const insertProductPage({super.key});

  @override
  State<insertProductPage> createState() => _insertProductPageState();
}

class _insertProductPageState extends State<insertProductPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenSize.width * 1, // ขยายความกว้างของ Card
                height: screenSize.height * 0.2, // ขยายความสูงของ Card
                child: Card(
                  color: Color.fromARGB(255, 210, 133, 246),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.07,
                        left: screenSize.width * 0.35),
                    child: Container(
                      child: const Text(
                        "เพิ่มสินค้า",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 69, 2, 81),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.02),
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.6,
                        child: FilledButton(
                          onPressed: insertphoto,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 88, 3, 107)),
                          ),
                          child: Text(
                            'เพิ่มรูปภาพสินค้า',
                            style: TextStyle(fontSize: screenSize.width * 0.04),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: screenSize.width * 0.5,
                          height: screenSize.height * 0.2,
                          child: Card(),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenSize.width * 0.05,
                                right: screenSize.width * 0.05),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อสินค้า: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 247, 182, 254),
                                          width:
                                              2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenSize.height * 0.05,
                                left: screenSize.width * 0.05,
                                right: screenSize.width * 0.05),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'รายละเอียดสินค้า: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 247, 182, 254),
                                          width:
                                              2), // เปลี่ยนขอบเป็นสีแดงเมื่อคลิก
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.05),
                child: FilledButton(
                  onPressed: acceptinsert,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 3, 103, 18)),
                  ),
                  child: Text(
                    'ยืนยันการเพิ่มสินค้า',
                    style: TextStyle(fontSize: screenSize.width * 0.04),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: FilledButton(
                  onPressed: next,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(151, 69, 7, 117)),
                  ),
                  child: Text(
                    'ถัดไป',
                    style: TextStyle(fontSize: screenSize.width * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: UserNavbarPage(
          selectedIndex: 0,
          onDestinationSelected: (value) {},
          screenSize: screenSize,
        ));
  }

  void insertphoto() {}

  void acceptinsert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 29, 162, 2),
        title: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/check.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const Text(
                'ยืนยันสำเร็จ',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 255, 255)),
            ),
            child: const Center(
                child: Text(
              'ตกลง',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            )),
          )
        ],
      ),
    );
  }

  void next() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Senproduct(),
      ),
    );
  }
}
