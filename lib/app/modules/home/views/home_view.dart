import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_ease/app/modules/auth/controllers/auth_controller.dart';
import 'package:stock_ease/app/modules/product/controllers/product_controller.dart';
import 'package:stock_ease/app/modules/product/views/edit_product_view.dart';
import 'package:stock_ease/app/modules/product/views/widget/product_item.dart';
import 'package:stock_ease/app/other_widget/general_dialog.dart';
import 'package:stock_ease/app/routes/app_pages.dart';
import 'package:stock_ease/app/theme/color.dart';

class HomeView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final ProductController productController = Get.put(ProductController());
  var isGridView = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: primaryColor,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegate(),
                );
              },
            ),
            Obx(() => IconButton(
                  icon: Icon(
                    isGridView.value ? Icons.list : Icons.grid_view,
                    color: Colors.white,
                  ),
                  onPressed: () => isGridView.toggle(),
                )),
            Obx(() => authController.isLoggedIn.value
                ? IconButton(
                    icon: const Icon(Icons.logout_sharp, color: Colors.white),
                    onPressed: () => AppGeneralDialog()
                        .show(context, 'Anda yakin ingin Logout?',
                            onSubmit: () {
                              authController
                                  .logout()
                                  .then((value) => Get.toNamed(Routes.LOGIN));
                            },
                            isWarning: true,
                            onCancel: () => Get.back(),
                            labelOnCancel: 'Batal'),
                  )
                : IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () => AppGeneralDialog().show(
                      context,
                      'Apakah anda ingin melakukan Login?',
                      onSubmit: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      isWarning: true,
                      labelOnCancel: 'Register',
                      onCancel: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                    ),
                  )),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: Colors.white,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stock Ease",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Kumpulan Barang yang tersedia, kamu dapat melakukan update barang setelah login.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (productController.products.isEmpty) {
                    return const Center(child: Text('Tidak ada data barang.'));
                  }

                  return isGridView.value
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productController.products.length,
                          itemBuilder: (context, index) {
                            final product = productController.products[index];

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  authController.isLoggedIn.value
                                      ? Expanded(
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(10)),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  color: Colors.grey[300],
                                                  child: product
                                                          .image.isNotEmpty
                                                      ? Image.network(
                                                          product.image,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder: (context,
                                                              child,
                                                              loadingProgress) {
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    primaryColor,
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : const Icon(Icons.image,
                                                          size: 50,
                                                          color: Colors.grey),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8,
                                                right: 8,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit,
                                                          color: primaryColor,
                                                          size: 20),
                                                      onPressed: () {
                                                        Get.to(EditProductView(
                                                            productId:
                                                                product.id!));
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 20),
                                                      onPressed: () {
                                                        productController
                                                            .deleteProduct(
                                                                product.id!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'SKU: ${product.sku} • Qty: ${product.qty}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[700]),
                                        ),
                                        Text(
                                          'Rp. ${product.price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: productController.products.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final product = productController.products[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: product.image.isNotEmpty
                                    ? Image.network(
                                        product.image,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image,
                                            color: Colors.grey),
                                      ),
                              ),
                              trailing: authController.isLoggedIn.value
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: primaryColor),
                                          onPressed: () {
                                            Get.to(EditProductView(
                                                productId: product.id!));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            productController
                                                .deleteProduct(product.id!);
                                          },
                                        ),
                                      ],
                                    )
                                  : null,
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  'SKU: ${product.sku} • Qty: ${product.qty} • Harga: ${product.price}'),
                            );
                          },
                        );
                }),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => productController.fetchProducts(),
              backgroundColor: secondaryColor,
              child: const Icon(Icons.refresh, color: Colors.white, size: 28),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => authController.isLoggedIn.value
                ? FloatingActionButton(
                    onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add, color: Colors.white, size: 28),
                  )
                : const SizedBox()),
          ],
        ));
  }
}

class ProductSearchDelegate extends SearchDelegate<String> {
  final ProductController productController = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    productController.searchProducts(query);
    return Obx(() => ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text(
                  'SKU: ${product.sku} - Qty: ${product.qty} - Harga: ${product.price}'),
              onTap: () => close(context, product.id!),
            );
          },
        ));
  }
}
