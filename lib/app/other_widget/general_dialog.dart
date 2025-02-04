import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ease/app/other_widget/app_button.dart';
import 'package:stock_ease/app/theme/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppGeneralDialog {
  void show(context, label,
      {required VoidCallback onSubmit,
      bool isSuccess = true,
      VoidCallback? onCancel,
      String? labelOnCancel,
      bool? isLeave = false,
      bool? isWarning}) {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AppButton(
                      width: 100,
                      baseColor: primaryColor,
                      onTap: () {
                        Get.back();
                        onSubmit();
                      },
                      label: 'OK',
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  if (onCancel != null)
                    Center(
                      child: AppButton(
                        width: 100,
                        baseColor: primaryColor,
                        onTap: () {
                          Get.back();
                          onCancel();
                        },
                        label: labelOnCancel ?? '',
                      ),
                    ),
                ],
              ),
            ],
            icon: isWarning != null
                ? SvgPicture.asset(
                    'assets/icons/warning.svg',
                    color: secondaryColor,
                    height: 32,
                  )
                : isSuccess
                    ? SvgPicture.asset(
                        'assets/icons/success.svg',
                        color: secondaryColor,
                      )
                    : SvgPicture.asset(
                        'assets/icons/failed.svg',
                        color: Colors.red.withOpacity(0.5),
                      ),
          ),
        );
      },
    );
  }
}
