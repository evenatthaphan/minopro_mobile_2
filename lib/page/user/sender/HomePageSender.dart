import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/model/response/getUser_res.dart';
import 'package:flutter_minipro2/page/user/sender/insertProduct.dart';
import 'package:flutter_minipro2/page/user/sender/navbar_sender.dart';

class HomePageSender extends StatefulWidget {
  const HomePageSender({super.key});

  @override
  State<HomePageSender> createState() => _HomePageSenderState();
}

class _HomePageSenderState extends State<HomePageSender> {
  int selectedItems = 0;
  TextEditingController phoneNoCtl = TextEditingController();
  List<GetUsersRes> users = []; // List to display
  List<GetUsersRes> allUsers = []; // List to hold all users
  String _userNoResultMessage = '';
  late Future<void> loadData;

  @override
  void initState() {
    super.initState();
    loadData = getMember(); // Load all users initially
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ค้นหาผู้รับ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.25,
                  child: Card.outlined(
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
                            controller: phoneNoCtl,
                            onChanged: (value) {
                              _searchUsers(value); // Search as user types
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'ค้นหาด้วยหมายเลขโทรศัพท์',
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
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
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      if (users.isEmpty) // Show message if no users found
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _userNoResultMessage.isEmpty
                                ? 'ไม่พบผู้ใช้ที่ค้นหา'
                                : _userNoResultMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Column(
                        children: [
                          SizedBox(
                            width: screenSize.width,
                            height: screenSize.height * 0.5,
                            child: ListView.builder(
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return Card.outlined(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: user.image.isNotEmpty
                                          ? NetworkImage(user.image)
                                          : const AssetImage(
                                                  'assets/images/profile.jpg')
                                              as ImageProvider,
                                    ),
                                    title: Text('Name: ${user.name}'),
                                    subtitle: Text('Phone: ${user.phone}'),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[300],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_forward),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  insertProductPage(id: user.id),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: UserNavbarPage(
        selectedIndex: 0,
        onDestinationSelected: (value) {},
        screenSize: screenSize,
      ),
    );
  }

  Future<void> getMember() async {
    try {
      // Fetch all users from Firestore where type is 'user'
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('type', isEqualTo: 'user')
          .get();

      // Convert Firestore documents to List<GetUsersRes>
      allUsers = getUsersResFromQuerySnapshot(querySnapshot);

      setState(() {
        users = allUsers; // Initially show all users
        _userNoResultMessage = users.isEmpty ? "ไม่มีผู้ใช้ที่จะแสดง" : '';
      });
    } catch (e) {
      log('Error fetching users: $e');
    }
  }

  void _searchUsers(String query) {
    if (query.isEmpty) {
      // If search query is empty, show all users
      setState(() {
        users = allUsers;
        _userNoResultMessage = users.isEmpty ? "ไม่มีผู้ใช้ที่จะแสดง" : '';
      });
    } else {
      // Filter users based on phone number
      setState(() {
        users = allUsers
            .where((user) => user.phone.contains(query))
            .toList(); // Filter users by phone number
        _userNoResultMessage = users.isEmpty ? "ไม่พบผู้ใช้ที่ค้นหา" : '';
      });
    }
  }
}
