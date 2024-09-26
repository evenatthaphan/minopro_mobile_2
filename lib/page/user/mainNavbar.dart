import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/HomepageUser.dart';
import 'package:flutter_minipro2/page/user/profilepage.dart';


class MainDrawerPage extends StatefulWidget {
  const MainDrawerPage({super.key});

  @override
  State<MainDrawerPage> createState() => _MainDrawerPageState();
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  var currentWidget;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          log('Save data and Log out');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Demo Drawer"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ABC'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_photo_alternate), label: 'ZZZ'),
          ],
          onTap: (value) {
            log(value.toString());
            setState(() {
              if (value == 0) {
                currentWidget = const HomePageUser();
              }
              if (value == 1) {
                currentWidget = const ProfilePage();
              }
            });
          },
        ),
        // drawer: Drawer(
        //     child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       Image.network(
        //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOTGLpRQIfbiwGixMl9BWIePzWJN4yPc6kQA&s'),
        //       const Text(
        //         "Main Menu",
        //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //       ),
        //       const Divider(
        //         indent: 30,
        //         endIndent: 30,
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.home),
        //         title: const Text('Home'),
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.settings),
        //         title: const Text('Setting'),
        //         onTap: () {},
        //       ),
        //       const Divider(
        //         indent: 30,
        //         endIndent: 30,
        //       ),
        //       ListTile(
        //         leading: const Icon(Icons.logout),
        //         title: const Text('Log out'),
        //         onTap: () {
        //           // Navigator.popUntil(context, (route) => route.isFirst);

        //           Get.offAll(() => const HomePage());

        //           // Navigator.pop(context);
        //           // Navigator.pop(context);

        //           // Navigator.push(context,
        //           //     MaterialPageRoute(builder: (context) => const HomePage()));
        //         },
        //       ),
        //       Expanded(child: Container()),
        //       const Padding(
        //         padding: EdgeInsets.all(16.0),
        //         child: Text("Develop by DOK © 2024"),
        //       )
        //     ],
        //   ),
        // )),
        body: currentWidget,
      ),
    );
  }
}
