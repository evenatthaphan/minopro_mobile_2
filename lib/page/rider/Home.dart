import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/rider/Map.dart';
import 'package:flutter_minipro2/page/rider/UpStatus.dart';
import 'package:get/get.dart';

class HomePageRider extends StatefulWidget {
  const HomePageRider({super.key});

  @override
  State<HomePageRider> createState() => _HomePageRiderState();
}

class _HomePageRiderState extends State<HomePageRider> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(148, 100, 195, 0.5),
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
                  top: screenSize.height * 0.03,
                  left: screenSize.width * 0.006,
                  right: screenSize.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: screenSize.width * 0.3,
                            height: screenSize.height * 0.1,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://i.pinimg.com/236x/15/58/22/155822f2d8064e870b20537fd5d4b84d.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.001),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "นายบาส",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.001),
                              const Text(
                                "ทะเบียน : ขบ1412",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.01,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenSize.height * 0.03),
                          SizedBox(
                            height: screenSize.height * 0.04,
                            child: Icon(
                              Icons.exit_to_app_sharp,
                              size: screenSize.width * 0.1,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            "ออกจากระบบ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            Center(
              child: Text(
                "ออร์เดอร์ใหม่",
                style: TextStyle(
                    fontSize: screenSize.width * 0.07,
                    color: const Color.fromRGBO(72, 4, 103, 1)),
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: const Color.fromRGBO(181, 77, 183, 0.2),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.02),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: screenSize.width * 0.3,
                            height: screenSize.height * 0.1,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://f.ptcdn.info/624/058/000/pbupu7k1smcooLK9tYc-o.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width * 0.04),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "ชื่อผู้ส่ง: "),
                                    TextSpan(
                                      text: "ฝน",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "ชื่อผู้รับ: "),
                                    TextSpan(
                                      text: "น้ำตาล",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "เลขออร์เดอร์: "),
                                    TextSpan(
                                      text: "101111",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "สถานะ: "),
                                    TextSpan(
                                      text: "รอการยืนยันการรับงาน",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Container(
                        height: 1.7,
                        width: screenSize.width * 0.8,
                        color: Colors.black, // สีของเส้น
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.04),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 25,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "จุดรับสินค้า",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            FilledButton(
                              onPressed: () {
                                Get.to(() => MapScreenPage());
                              },
                              child: const Text("คลิกเพื่อดูตำแหน่ง"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Container(
                        height: 1.7,
                        width: screenSize.width * 0.8,
                        color: Colors.black, // สีของเส้น
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.25,
                            height: screenSize.height * 0.04,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(26, 159, 39, 1),
                              ),
                              onPressed: () =>
                                  showConfirmationDialog(screenSize),
                              child: const Text("รับงาน"),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.25,
                            height: screenSize.height * 0.04,
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(188, 13, 13, 1)),
                                onPressed: () {},
                                child: Text("ปฏิเสธ")),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog(Size screenSize) {
    Get.defaultDialog(
      backgroundColor: Color.fromRGBO(99, 172, 106, 1),
      title: 'ยืนยันการรับงาน',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      contentPadding: const EdgeInsets.all(20),
      content: Image.asset("assets/Images/Comfirm.png",
          width: screenSize.width * 0.5, height: screenSize.height * 0.2),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Color.fromRGBO(23, 244, 4, 1)),
              onPressed: () => Get.to(() => UpdateStatus()),
              child: const Text(
                'ยินยัน',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Color.fromRGBO(217, 217, 217, 1)),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'ยกเลิก',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
