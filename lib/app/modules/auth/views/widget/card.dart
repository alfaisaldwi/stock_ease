import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ease/app/modules/auth/controllers/auth_controller.dart';
import 'package:stock_ease/app/other_widget/general_textfield.dart';
import 'package:stock_ease/app/routes/app_pages.dart';
import 'package:stock_ease/app/theme/color.dart';

class CardWidget extends StatelessWidget {
  CardWidget({super.key});

  final AuthController authController = Get.find();
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var stayLoggedIn = false.obs; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(height: 40),
                GeneralTextfield(
                  hint: 'Masukan Email & NoHP Anda',
                  label: 'Email/NoHp',
                  controller: identifierController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                GeneralTextfield(
                  hint: 'Masukan Password anda',
                  label: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                Obx(() => Row(
                      children: [
                        Checkbox(
                          value: stayLoggedIn.value,
                          onChanged: (value) {
                            stayLoggedIn.value = value!;
                          },
                        ),
                        Text("Tetap Masuk")
                      ],
                    )),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    authController.login(
                      identifierController.text,
                      passwordController.text,
                      stayLoggedIn.value,
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1, color: primaryColor)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login_outlined,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Login',
                          style: TextStyle(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Text('Belum punya akun? Daftar disini'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
