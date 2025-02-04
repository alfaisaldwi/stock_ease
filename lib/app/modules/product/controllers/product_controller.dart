import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_ease/app/model/product_model.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var products = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();
      products.assignAll(querySnapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
      fetchProducts();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    try {
      await _firestore
          .collection('products')
          .doc(id)
          .update(updatedProduct.toMap());
      fetchProducts();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _firestore.collection('products').doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();
      products.assignAll(querySnapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
