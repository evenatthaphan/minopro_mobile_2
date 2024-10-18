import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/sender/navbar_sender.dart';

class StatusPageSender extends StatefulWidget {
  const StatusPageSender({super.key});

  @override
  State<StatusPageSender> createState() => _StatusPageSenderState();
}

class _StatusPageSenderState extends State<StatusPageSender> {
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
                    left: screenSize.width * 0.22,
                  ),
                  child: const Text(
                    "สินค้าที่จะจัดส่ง",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 69, 2, 81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Receiver Info Section
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ชื่อผู้รับ : น้องเจมส์",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 69, 2, 81),
                    ),
                  ),
                  const Text(
                    "เบอร์โทร : 0245781659",
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 2, 81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "ที่อยู่ : xxxxxxxxx",
                    style: TextStyle(
                      color: Color.fromARGB(255, 69, 2, 81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("สินค้าที่ต้องจัดส่ง :"),
                  // Order Details Box
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("หมายเลขออเดอร์ : 10"),
                          SizedBox(height: 5),
                          Text(
                            "ลูกบอล",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "สีไม้",
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Image Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle image upload
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.camera_alt),
                                SizedBox(width: 5),
                                Text("ถ่ายภาพ"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: screenSize.width * 0.4,
                        height: screenSize.height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("แสดงรูปภาพ"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.05),
                child: FilledButton(
                  onPressed: accept,
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
          ],
        ),
      ),
      // Bottom Confirm Button and Navbar
      bottomNavigationBar: UserNavbarPage(
          selectedIndex: 0,
          onDestinationSelected: (value) {},
          screenSize: screenSize,
        )
    );
  }

  void accept() {
    
  }
}
