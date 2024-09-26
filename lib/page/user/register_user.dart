import 'package:flutter/material.dart';

class RegirterPage extends StatefulWidget {
  const RegirterPage({super.key});

  @override
  State<RegirterPage> createState() => _RegirterPageState();
}

class _RegirterPageState extends State<RegirterPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,  // ซ่อนลูกศรชี้กลับ
        //   ),
        body: SingleChildScrollView(
          child: Stack(
                children: [
          SizedBox(
            width: screenSize.width * 1, // ขยายความกว้างของ Card
            height: screenSize.height * 0.25, // ขยายความสูงของ Card
            child: Card(
              color: Color.fromARGB(255, 247, 182, 254),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.05,
                  left: screenSize.width * 0.05),
                  child: Row(
                    children: [
                      SizedBox(
                          child: Image.asset(
                            'assets/images/user.png',
                            width: screenSize.width * 0.3,
                          ),
                        ),
                      Text(
                          "ลงทะเบียนผู้ใช้",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.26),
            child: Center(),
          )
                ],
              ),
        ));
  }

  void registeruser() {}

  void registerrider() {}
}
