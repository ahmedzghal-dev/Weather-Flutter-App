import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LocationViewModel extends GetxController {
  List<String> filteredLocationsList = <String>[].obs;
  List<String> allLocationsList = [
    'Tunis, Tunisa',
    'Sfax, Tunisa',
    'Tataouine, Tunisa',
    'Monastir, Tunisa',
    'Mahdia, Tunisa',
    '	Manouba, Tunisa',
    'Nabeul, Tunisa',
    '	Sidi Bouzid, Tunisa',
    '	Sousse, Tunisa',
    '	Zaghouan, Tunisa',
  ];

  @override
  void onReady() {
    filteredLocationsList.addAll(allLocationsList);
    super.onReady();
  }

  onSearchLocation(String value){
    filteredLocationsList.clear();
    filteredLocationsList.addAll(allLocationsList.where((e)=> e.toLowerCase().contains(value.toLowerCase())));
  }

  onLocationSelection(int index){
    Get.back(result: filteredLocationsList[index]);
  }
}
