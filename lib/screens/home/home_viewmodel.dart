import 'dart:convert';

import 'package:flutter_application_1/helper/getx_helper.dart';
import 'package:flutter_application_1/helper/global_variables.dart';
import 'package:flutter_application_1/screens/home/weather_model.dart';
import 'package:flutter_application_1/screens/locations/locations_view.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  Rx<WeatherModel> weatherModel = WeatherModel().obs;
  RxString location = 'Tunis, Tunisia'.obs;

  @override
  void onReady() {
    getLastLocationAndUpdate();
    super.onReady();
  }

  void changeLocation() async {
    var result = await Get.to(() => LocationsView());

    if (result != null) {
      location.value = result;
      GetStorage().write('LastLocation', location.value);
      getLastLocationAndUpdate();
    }
  }

  getLastLocationAndUpdate() {
    //get last selected location
    location.value = GetStorage().read('lastLocation') ?? 'Tunis, Tunisia';

    //get local data
    var data = GetStorage().read(location.value) ?? <String, dynamic>{};
    weatherModel.value = WeatherModel.fromJson(data);

    //get latest data
    getWeatherUpdate();
  }

  getWeatherUpdate() async {
    try {
      //Header
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      //URL
      String url = 'https://api.openweathermap.org/data/2.5/weather';
      Map<String, String> params = {
        'appid': 'f6c95f6fb7150b5fc11310beb7e39cb3',
        'q': location.value,
        'units': 'metric',
      };
      Uri uriValue = Uri.parse(url).replace(queryParameters: params);

      GlobalVariables.showLoader.value = true;
      http.Response response = await http.get(uriValue, headers: header);
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      GlobalVariables.showLoader.value = false;

      if (parsedJson['cod'] == 200) {
        weatherModel.value = WeatherModel.fromJson(parsedJson);
        //Store data locally
        GetStorage().write(location.value, parsedJson);
        GetxHelper.showSnackbar(message: 'Weatgher updated successfully');
      } else {
        GetxHelper.showSnackbar(message: 'Something went Wrong');
      }
    } catch (e) {
      GetxHelper.showSnackbar(message: e.toString());
    }
  }

  String convertTimeStampToTime(int? timeStamp) {
    String time = 'N/A';
    if (timeStamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      time = DateFormat("hh:mm a").format(dateTime);
    }
    return time;
  }

  String getCurrentDate() {
    String date = '';
    DateTime dateTime = DateTime.now();
    date = DateFormat("EEEE | MMM dd").format(dateTime);

    return date;
  }
}
