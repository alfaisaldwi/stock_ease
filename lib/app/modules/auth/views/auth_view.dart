import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stock_ease/app/modules/auth/views/widget/card.dart';
import 'package:stock_ease/app/modules/auth/views/widget/footer.dart';
import 'package:stock_ease/app/modules/auth/views/widget/header.dart';
import 'package:stock_ease/app/other_widget/general_textfield.dart';
import 'package:stock_ease/app/routes/app_pages.dart';

import '../controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'register_view.dart';

class AuthView extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const HeaderWidget(),
            CardWidget(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
