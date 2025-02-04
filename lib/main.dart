import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stock_ease/app/other_widget/splashcreen.dart';
import 'package:stock_ease/app/theme/color.dart';
import 'package:stock_ease/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      webProvider:
          ReCaptchaV3Provider('6LeJfswqAAAAAOooVrVQaHUL0X-idDVBqjwclPkZ'));
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
    ),
  );
}
