import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  Future<void> createProduct({required Product product}) async {
    try {
      final stockageRef =
          FirebaseStorage.instance.ref().child('produit_image').child(
                '${product.idProduct}.jpg',
              );
      await stockageRef.putFile(product.viewFile!);
      final imageUrl = await stockageRef.getDownloadURL();
      FirebaseFirestore.instance
          .collection("produit")
          .doc(product.idProduct)
          .set({
        'idProduct': product.idProduct,
        'name': product.name,
        'price': product.price,
        'imageUrl': imageUrl,
        'quantity': product.quantity,
        'categoryId': product.categoryId,
        'subCategoryId': product.subCategoryId,
        'description': product.description,
        'sellerId': FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  Future<List<Product>> getAllProduct() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('produit').get();
      print(querySnapshot);
      return await getProductsFromQuerySnapshot(querySnapshot);
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  Future<List<Product>> getProductByCategory({required String value}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("produit")
              .where("categoryId", isEqualTo: value)
              .get();

      return await getProductsFromQuerySnapshot(querySnapshot);
    } catch (e) {
      throw Exception(
        "Quelque chose s'est mal passé",
      );
    }
  }
}
