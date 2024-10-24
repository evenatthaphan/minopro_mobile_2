import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/receiver/Delivery.dart';
import 'package:flutter_minipro2/page/user/receiver/Home.dart';
import 'package:flutter_minipro2/page/user/receiver/Receive.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NavbarReceiveShare extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const NavbarReceiveShare({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(148, 100, 195, 0.6),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory), label: 'ที่ต้องได้รับ'),
        BottomNavigationBarItem(
            icon: Icon(Icons.motorcycle), label: 'กำลังจัดส่ง'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      onTap: (int index) {
        onDestinationSelected(index);

        if (index == 0) {
          if (selectedIndex != 0) {
            Get.to(() => const HomePageReceiver());
          }
        } else if (index == 1) {
          if (selectedIndex != 1) {
            Get.to(() => const ReceivePage());
          }
        } else if (index == 2) {
          if (selectedIndex != 2) {
            Get.to(() => const DeliveryPage());
          }
        }
      },
    );
  }
}
