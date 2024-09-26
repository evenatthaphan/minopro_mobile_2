import 'package:flutter/material.dart';


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
          backgroundColor: const Color.fromRGBO(249, 85, 85, 1),
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
                icon: Icon(Icons.home), label: "สถานะ"),
            NavigationDestination(
                icon: Icon(Icons.home), label: "รอไรด์เดอร์"),
          ],
        ),
      ),
    );
  }
  
  void navigateHomePageSender(BuildContext context) {}
  
  void navigateWaitPageSender(BuildContext context) {}
  
  void navigateStatusPageSender(BuildContext context) {}
}

