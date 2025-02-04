import 'package:get/get.dart';
import 'package:stock_ease/app/modules/auth/views/register_view.dart';
import 'package:stock_ease/app/modules/product/views/create_product_view.dart';
import 'package:stock_ease/app/modules/product/views/edit_product_view.dart';
import 'package:stock_ease/app/other_widget/splashcreen.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => HomeView(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
        name: Routes.LOGIN,
        page: () => AuthView(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterView(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
        name: Routes.ADD_PRODUCT,
        page: () => AddProductView(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
        name: Routes.EDIT_PRODUCT,
        page: () => EditProductView(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashScreen(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 700)),
  ];
}
