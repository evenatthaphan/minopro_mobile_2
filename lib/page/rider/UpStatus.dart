import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/rider/SendItem.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateStatus extends StatefulWidget {
  const UpdateStatus({super.key});

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
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
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.04),
                  Center(
                    child: Text(
                      "ออร์เดอร์ที่รับ",
                      style: TextStyle(
                          fontSize: screenSize.width * 0.07,
                          color: const Color.fromRGBO(72, 4, 103, 1)),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  Card(
                    color: const Color.fromRGBO(181, 77, 183, 0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.06,
                          vertical: screenSize.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: screenSize.width * 0.24,
                                    height: screenSize.height * 0.1,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              8)), // Correctly define borderRadius
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/04/07/07/51/papaya-salad-710613_1280.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.01),
                                  const Text(
                                    "ส้มตำ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(width: screenSize.width * 0.05),
                              Column(
                                children: [
                                  Container(
                                    width: screenSize.width * 0.24,
                                    height: screenSize.height * 0.1,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              8)), // Correctly define borderRadius
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/04/07/07/51/papaya-salad-710613_1280.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.01),
                                  const Text(
                                    "ส้มตำ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Container(
                            height: 1.0,
                            width: screenSize.width * 0.8,
                            color: Colors.black, // สีของเส้น
                          ),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: "หมายเลขออร์เดอร์: ",
                                    style: TextStyle(fontSize: 16)),
                                TextSpan(
                                  text: "10",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(134, 19, 153, 1)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.016),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "ผู้ส่ง",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(height: screenSize.height * 0.015),
                                  const Text(
                                    "น้อยจอยบอย",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "โทร: ",
                                            style: TextStyle(fontSize: 16)),
                                        TextSpan(
                                          text: "023456789",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  134, 19, 153, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "ผู้ส่ง",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(height: screenSize.height * 0.015),
                                  const Text(
                                    "น้องเจมส์",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "โทร: ",
                                            style: TextStyle(fontSize: 16)),
                                        TextSpan(
                                          text: "023456789",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  134, 19, 153, 1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Icon(
                    Icons.camera_alt_outlined,
                    size: screenSize.width * 0.16,
                  ),
                  FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(181, 77, 183, 1)),
                      onPressed: () {
                        _getImage();
                      },
                      child: Text(
                        "ถ่ายรูปประกอบสถานะ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenSize.width * 0.034),
                      )),
                  SizedBox(height: screenSize.height * 0.01),
                  Container(
                    width: screenSize.width * 0.8,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(132, 132, 132, 1),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: screenSize.width * 0.007),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? Center(
                            child: Text(
                              "แสดงรูปภาพ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.04,
                                  color: Colors.white),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.46,
                    child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(99, 172, 106, 1)),
                        onPressed: () {
                          Get.to(() => SendItemPage());
                        },
                        child: Text(
                          "ถัดไป",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.04),
                        )),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      log('Image path: ${pickedFile.path}');
    } else {
      log('No image selected');
    }
  }
}
