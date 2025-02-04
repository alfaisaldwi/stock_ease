import 'package:flutter/material.dart';
import 'package:stock_ease/app/model/product_model.dart';


class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: product.image.isNotEmpty
            ? Image.network(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : Icon(Icons.image, size: 50),
        title: Text(product.name),
        subtitle: Text('SKU: ${product.sku} - Qty: ${product.qty} - Harga: ${product.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}