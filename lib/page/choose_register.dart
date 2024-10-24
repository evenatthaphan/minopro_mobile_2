import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/rider/register_rider.dart';
import 'package:flutter_minipro2/page/user/register_user.dart';

class ChooseRegisterPage extends StatefulWidget {
  const ChooseRegisterPage({super.key});

  @override
  State<ChooseRegisterPage> createState() => _ChooseRegisterPageState();
}

class _ChooseRegisterPageState extends State<ChooseRegisterPage> {
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
            height: screenSize.height * 0.2, // ขยายความสูงของ Card
            child: Card(
              color: Color.fromARGB(255, 247, 182, 254),
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenSize.height * 0.07,
                    left: screenSize.width * 0.25),
                child: Container(
                  child: const Text(
                    "ลงทะเบียนผู้ใช้",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenSize.height * 0.26),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'คุณต้องการลงทะเบียนผู้ใช้แบบใด ?',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'โปรดเลือก',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.05),
                    child: Column(
                      children: [
                        SizedBox(
                          width:
                              screenSize.width * 0.6, // ขยายความกว้างของ Card
                          height:
                              screenSize.height * 0.25, // ขยายความสูงของ Card
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      width: screenSize.width * 0.3,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: registeruser,
                                  child: Text(
                                    'ผู้ใช้ทั่วไป',
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
                          width:
                              screenSize.width * 0.6, // ขยายความกว้างของ Card
                          height:
                              screenSize.height * 0.25, // ขยายความสูงของ Card
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/images/delivery.png',
                                      width: screenSize.width * 0.3,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: registerrider,
                                  child: Text(
                                    'ไรด์เดอร์',
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
          )
        ],
      ),
    ));
  }

  void registeruser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void registerrider() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterRiderPage(),
      ),
    );
  }
}
