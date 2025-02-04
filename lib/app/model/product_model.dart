class Product {
  String? id;
  final String sku;
  final String name;
  final String image;
  final int qty;
  final double price;

  Product({
    this.id,
    required this.sku,
    required this.name,
    required this.image,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'sku': sku,
      'name': name,
      'image': image,
      'qty': qty,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      sku: map['sku'],
      name: map['name'],
      image: map['image'],
      qty: map['qty'],
      price: map['price'],
    );
  }
}