import 'package:flutter/material.dart';
import 'package:flutter_minipro2/page/user/receiver/Delivery.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WidgetShareCardItem extends StatelessWidget {
  final String linkImageProfile;
  final String name;
  final String phone;
  final bool isPage;
  final List<String> listImage;
  final List<String> nameImage;

  const WidgetShareCardItem({
    super.key,
    required this.linkImageProfile,
    required this.name,
    required this.phone,
    required this.isPage,
    required this.listImage,
    required this.nameImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        // Top Profile Section
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.03,
                vertical: screenSize.height * 0.006),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: screenSize.width * 0.15,
                      height: screenSize.width * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(linkImageProfile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: screenSize.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          phone,
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                isPage
                    ? Text(
                        "รอไรเดอร์รับงาน",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: !isPage
                              ? const Color.fromRGBO(23, 244, 4, 1)
                              : const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      )
                    : Column(
                        children: [
                          Text(
                            "รอไรเดอร์รับงาน",
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: isPage
                                  ? const Color.fromRGBO(23, 244, 4, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.3,
                            height: screenSize.height * 0.034,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(23, 244, 4, 1),
                              ),
                              onPressed: () {
                                Get.to(() => DeliveryPage());
                              },
                              child: Text(
                                "เช็คสถานะ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenSize.width * 0.034,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
        // Images List Section
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(148, 100, 195, 0.18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.04,
              vertical: screenSize.height * 0.02,
            ),
            child: Wrap(
              spacing:
                  screenSize.width * 0.04, // Horizontal spacing between items
              runSpacing:
                  screenSize.height * 0.02, // Vertical spacing between rows
              children: List.generate(listImage.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenSize.width * 0.13,
                      height: screenSize.width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(listImage[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenSize.width * 0.01,
                      ),
                      child: Text(
                        nameImage[index],
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
