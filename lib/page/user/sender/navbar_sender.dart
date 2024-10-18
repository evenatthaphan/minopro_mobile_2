import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/sender/HmoePageSender.dart';
import 'package:flutter_minipro2/page/user/sender/Senproduct.dart';
import 'package:flutter_minipro2/page/user/sender/ProductPageSender.dart';


class UserNavbarPage extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final Size screenSize;

  const UserNavbarPage({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.screenSize,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(color: Colors.white, fontSize: screenSize.width * 0.035),
          ),
          iconTheme: WidgetStateProperty.all(
            IconThemeData(size: screenSize.width * 0.07),
          ),
          indicatorColor: Colors.white.withOpacity(0.2),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 185, 121, 250),
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            onDestinationSelected(index); // Call the passed function

            // Navigate to the corresponding page based on the selected index
            switch (index) {
              case 0:
                navigateHomePageSender(context);
                break;
              case 1:
                navigateWaitPageSender(context);
                break;
              case 2:
                navigateStatusPageSender(context);
                break;
            }
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "หน้าแรก"),
            NavigationDestination(
                icon: Icon(Icons.settings_backup_restore_rounded), label: "สถานะ"),
            NavigationDestination(
                icon: Icon(Icons.watch_later_outlined), label: "รอไรด์เดอร์"),
          ],
        ),
      ),
    );
  }
  
  void navigateHomePageSender(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageSender(),
      ),
    );
  }
  
  void navigateWaitPageSender(BuildContext context) {
    
  }
  
  void navigateStatusPageSender(BuildContext context) {}
}

