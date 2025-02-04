import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ease/app/modules/auth/controllers/auth_controller.dart';
import 'package:stock_ease/app/other_widget/general_textfield.dart';
import 'package:stock_ease/app/theme/color.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final AuthController authController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            onPressed: () {
              authController.register(
                emailController.text,
                passwordController.text,
                nameController.text,
                phoneController.text,
              );
            },
            child: const Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Kamu perlu memiliki akun untuk dapat menggunakan aplikasi Stock Ease dengan full akses",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GeneralTextfield(
              hint: 'Masukkan Nama Anda',
              label: 'Nama',
              controller: nameController,
            ),
            const SizedBox(height: 16),
            GeneralTextfield(
              label: 'Email',
              hint: 'Masukkan Email Anda',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            GeneralTextfield(
              label: 'No. HP',
              hint: 'Masukkan No. HP Anda',
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            GeneralTextfield(
              hint: 'Masukkan Password',
              label: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
