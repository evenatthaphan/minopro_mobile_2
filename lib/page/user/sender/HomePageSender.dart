import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/sender/insertProduct.dart';
import 'package:flutter_minipro2/page/user/sender/navbar_sender.dart';

class HomePageSender extends StatefulWidget {
  const HomePageSender({super.key});

  @override
  State<HomePageSender> createState() => _HomePageSenderState();
}

class _HomePageSenderState extends State<HomePageSender> {
  int selectedItems = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: screenSize.width, // ขยายความกว้างของ Card
                height: screenSize.height * 0.25, // ขยายความสูงของ Card
                child: Card(
                  color: Color.fromARGB(255, 185, 121, 250),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.07,
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenSize.width * 0.10,
                          right: screenSize.width * 0.10,
                          top: screenSize.height * 0.02,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true, // Enables the fill color
                            fillColor:
                                Colors.white, // Sets the fill color to white
                            hintText: 'ค้นหาผู้รับ', // Placeholder text
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(108, 3, 104, 1),
                                  width: 2),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.search,
                              ),
                              onPressed: () {
                                setState(() {
                                  // Handle search logic
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenSize.height * 0.25,
                    left: screenSize.width * 0.05),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ผลการค้นหา :',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: screenSize.width, // ขยายความกว้างของ Card
                          height: screenSize.height * 0.13,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenSize.width * 0.05,
                              top: screenSize.height * 0.02,
                            ),
                            child: Card.outlined(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/profile.png',
                                        width: screenSize.width * 0.25,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'น้องแม็ก',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '0254718963',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FilledButton(
                                      onPressed: () {
                                        selectedItems++;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 202, 127, 218)),
                                      ),
                                      child: Text(
                                        'เลือก',
                                        style: TextStyle(
                                            fontSize: screenSize.width * 0.04),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.84),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.9,
                          child: FilledButton(
                            onPressed: insert,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 88, 3, 107)),
                            ),
                            child: Text(
                              'เพิ่มสินค้า',
                              style:
                                  TextStyle(fontSize: screenSize.width * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
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

  void insert() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const insertProductPage(),
      ),
    );
  }
}
