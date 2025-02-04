part of 'app_pages.dart';

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const ADD_PRODUCT = '/add-product';
  static const EDIT_PRODUCT = '/edit-product';
  static const SPLASH = '/splash';
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const AUTH = '/auth';
  static const PRODUCT = '/product';
}
