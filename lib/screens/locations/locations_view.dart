import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/locations/location_viewmodel.dart';
import 'package:flutter_application_1/widgets/custom_textfields.dart';
import 'package:get/get.dart';

class LocationsView extends StatelessWidget {
  LocationsView({super.key});
  final LocationViewModel viewModel = Get.put(LocationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("locations"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CustomTextField(
                hint: 'Search locations...',
                prefixIcon: Icons.location_on,
                onChanged: (value) {
                  viewModel.onSearchLocation(value);
                }),
            Expanded(
              child: Obx(
                () => viewModel.filteredLocationsList.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.only(top: 20),
                        itemBuilder: (context, index) {
                          return listViewItem(int, index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: viewModel.filteredLocationsList.length)
                    : Center(
                        child: Text("Location Not Found"),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listViewItem(int, index) {
    return ListTile(
      tileColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        viewModel.onLocationSelection(index);
      },
      leading: Icon(
        Icons.location_on,
        color: Colors.white,
        size: 22,
      ),
      title: Text(
        viewModel.filteredLocationsList[index],
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
