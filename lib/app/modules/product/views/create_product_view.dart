import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stock_ease/app/model/product_model.dart';
import 'package:stock_ease/app/modules/product/controllers/product_controller.dart';
import 'package:stock_ease/app/other_widget/general_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stock_ease/app/theme/color.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class AddProductView extends StatelessWidget {
  final ProductController productController = Get.find();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var imageUrl = ''.obs;
  var imageName = ''.obs;
  var imageUploadLoading = false.obs;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      String url = await uploadToImgBB(file);
      imageUrl.value = url;
      imageName.value = image.name;
    }
  }

  Future<String> uploadToImgBB(File file) async {
    const String apiKey = "7b7add78b4bf8dc4f9c146c16c16fafe";
    var uri = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");
    imageUploadLoading.value = true;
    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', file.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var json = jsonDecode(responseData);

    if (json['status'] == 200) {
      imageUploadLoading.value = false;
      String url = json['data']['url'];
      url = url.replaceFirst("https://i.ibb.co", "https://i.ibb.co.com");
      return url;
    } else {
      imageUploadLoading.value = false;
      throw Exception("Upload gagal: ${json['error']['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SizedBox(
          height: 50,
          child: Obx(() {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: () {
                if (!imageUploadLoading.value) {
                  productController.addProduct(
                    Product(
                      sku: skuController.text,
                      name: nameController.text,
                      image: imageUrl.value,
                      qty: int.parse(qtyController.text),
                      price: double.parse(priceController.text),
                    ),
                  );
                } else {
                  null;
                }
              },
              child: Text(
                imageUploadLoading.value ? 'Sedang Menggungah Foto' : 'Simpan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Tambah Barang',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Tambah Barang",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GeneralTextfield(
              hint: 'Masukan Kode SKU',
              label: 'Kode SKU',
              controller: skuController,
            ),
            SizedBox(height: 16),
            GeneralTextfield(
              hint: 'Masukan Nama Barang',
              label: 'Nama Barang',
              controller: nameController,
            ),
            SizedBox(height: 16),
            Obx(() => imageUrl.value.isNotEmpty
                ? GeneralTextfield(
                    label: imageName.value,
                    hint: imageName.value,
                    enable: false,
                    keyboardType: TextInputType.number,
                  )
                : GestureDetector(
                    onTap: () => _pickImage(),
                    child: GeneralTextfield(
                      label: 'Foto',
                      hint: 'Masukan Foto Barang',
                      enable: false,
                      keyboardType: TextInputType.number,
                    ),
                  )),
            SizedBox(height: 16),
            GeneralTextfield(
              label: 'Qty',
              hint: 'Masukan Quantity',
              controller: qtyController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            GeneralTextfield(
              hint: 'Masukan Harga Satuan',
              label: 'Harga Satuan',
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
