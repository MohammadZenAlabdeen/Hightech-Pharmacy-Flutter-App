import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_color.dart';
import '../../pharmacysearch/view/pharmacysearchpage.dart';
import '../controller/pharmacypagecontroller.dart';

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final PharmacyPageControllerImp pharmacyPageControllerImp = Get.put(PharmacyPageControllerImp());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.pharmicaColors,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PharmicaSearch());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Obx(() {
        if (pharmacyPageControllerImp.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: pharmacyPageControllerImp.pharmacyList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  pharmacyPageControllerImp.gotoDetailsPage(index);
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.pharmicaColors, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          pharmacyPageControllerImp.pharmacyList[index]['name'],
                          style: const TextStyle(
                            color: AppColors.pharmicaColors,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            pharmacyPageControllerImp.pharmacyList[index]['state'],
                            style: const TextStyle(
                              color: AppColors.pharmicaColors,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '${pharmacyPageControllerImp.pharmacyList[index]['distance']} km',
                            style: const TextStyle(
                              color: AppColors.pharmicaColors,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      // You can display additional information here
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
