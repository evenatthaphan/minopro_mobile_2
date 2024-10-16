import 'package:flutter/material.dart';
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
              SizedBox(
                width: screenSize.width * 1, // ขยายความกว้างของ Card
                height: screenSize.height * 0.2, // ขยายความสูงของ Card
                child: Card(
                  color: Color.fromARGB(255, 210, 133, 246),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height * 0.07,
                        left: screenSize.width * 0.15),
                    child: Container(
                      child: const Text(
                        "รายการสินค้าที่จะจัดส่ง",
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
                  child: const Column(
                    children: [
                      Row(
                        children: [

                        ],
                      )
                    ],
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
  }
