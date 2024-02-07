import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Product {
  Product({
    String? idProduct,
    required this.name,
    required this.price,
    this.quantity,
    required this.categoryId,
    this.subCategoryId,
    this.sellerId,
    required this.description,
    this.imageUrl,
    this.viewFile,
    this.isFavoris,
    this.isInPanier,
  }) : idProduct = uuid.v4();
  String? idProduct;
  String name;
  double price;
  int? quantity;
  String categoryId;
  String? subCategoryId;
  String? sellerId;
  String description;
  String? imageUrl;
  File? viewFile;
  int? isFavoris;
  int? isInPanier;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'name': name,
      'price': price,
      'quantity': quantity,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'sellerId': sellerId,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      idProduct: map['idProduct'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      categoryId: map['categoryId'] as String,
      subCategoryId: map['subCategoryId'] as String,
      sellerId: map['sellerId'] != null ? map['sellerId'] as String : null,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  factory Product.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return Product(
      idProduct: document['idProduct'],
      name: document['name'],
      price: document['price'],
      quantity: document['quantity'],
      categoryId: document['categoryId'],
      subCategoryId: document['subCategoryId'],
      sellerId: document['sellerId'],
      description: document['description'],
      imageUrl: document['imageUrl'],
    );
  }
}

Future<List<Product>> getProductsFromQuerySnapshot(
    QuerySnapshot<Map<String, dynamic>> querySnapshot) async {
  List<Product> products = [];

  for (DocumentSnapshot<Map<String, dynamic>> document in querySnapshot.docs) {
    products.add(Product.fromDocumentSnapshot(document));
  }

  return products;
}
