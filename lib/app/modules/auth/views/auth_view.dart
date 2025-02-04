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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             GeneralTextfield(
//               label: 'Email',
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 16),
//             GeneralTextfield(
//               label: 'Password',
//               controller: passwordController,
//               obscureText: true,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 authController.login(
//                   emailController.text,
//                   passwordController.text,
//                 );
//               },
//               child: Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.toNamed(Routes.REGISTER);
//               },
//               child: Text('Belum punya akun? Daftar disini'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
