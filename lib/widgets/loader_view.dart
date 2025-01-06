import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/global_variables.dart';
import 'package:flutter_application_1/helper/theme_helper.dart';
import 'package:get/get.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GlobalVariables.showLoader.value)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ThemeHelper.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
