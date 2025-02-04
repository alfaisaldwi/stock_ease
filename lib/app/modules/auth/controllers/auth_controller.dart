import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_ease/app/model/user_model.dart';
import 'package:stock_ease/app/routes/app_pages.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoggedIn = false.obs;
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() async {
    super.onInit();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stayLoggedIn = prefs.getBool('stayLoggedIn') ?? false;

    if (stayLoggedIn) {
      User? user = _auth.currentUser;
      if (user != null) {
        isLoggedIn.value = true;
        fetchUserData(user.uid);
        Get.offNamed(Routes.HOME);
      }
    }

    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn.value = true;
        fetchUserData(user.uid);
      } else {
        isLoggedIn.value = false;
        currentUser.value = null;
      }
    });
  }

  Future<void> fetchUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      currentUser.value = UserModel(
        id: uid,
        name: doc['name'],
        email: doc['email'],
        phone: doc['phone'],
        password: doc['password'],
      );
    }
  }

  Future<void> register(
      String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      });
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login(
      String identifier, String password, bool stayLoggedIn) async {
    try {
      if (identifier.contains('@')) {
        await _auth.signInWithEmailAndPassword(
            email: identifier, password: password);
      } else {
        final querySnapshot = await _firestore
            .collection('users')
            .where('phone', isEqualTo: identifier)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          final userDoc = querySnapshot.docs.first;
          final userEmail = userDoc['email'];
          await _auth.signInWithEmailAndPassword(
              email: userEmail, password: password);
        } else {
          throw 'No. HP tidak terdaftar';
        }
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('stayLoggedIn', stayLoggedIn);

      Get.offNamed(Routes.HOME);
    } catch (e) {
      print("Error: ${e.toString()}");
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('stayLoggedIn', false);

    Get.offNamed(Routes.HOME);
  }
}
