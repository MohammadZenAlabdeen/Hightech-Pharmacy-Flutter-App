import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/app_color.dart';
import '../controller/pharmacysearchcontroller.dart';

PharmacySearchControllerImp pharmacySearchControllerImp = Get.put(PharmacySearchControllerImp());

class PharmicaSearch extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
            return showSuggestions(context);
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Start search when query is entered
    pharmacySearchControllerImp.searchPharmacy(query);

    return Obx(() {
      if (pharmacySearchControllerImp.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (pharmacySearchControllerImp.searchResults.isEmpty) {
        return const Center(child: Text('No results found'));
      } else {
        return ListView.builder(
          itemCount: pharmacySearchControllerImp.searchResults.length,
          itemBuilder: (BuildContext context, int index) {
            final medicine = pharmacySearchControllerImp.searchResults[index];
            return InkWell(
              onTap: (){pharmacySearchControllerImp.gotoDetailsPage(index);},
              child: Container(
                height: 120,
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.pharmicaColors, width: 1.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Text(
                          'Pharmacy: ${medicine['pharmacy']['name']}',
                          style: const TextStyle(
                              color: AppColors.pharmicaColors, fontSize: 30),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          medicine['name'],
                          style: const TextStyle(
                              color: AppColors.pharmicaColors, fontSize: 20),
                        ),
                        Text(
                          'Count: ${medicine['count']}',
                          style: const TextStyle(
                              color: AppColors.pharmicaColors, fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
