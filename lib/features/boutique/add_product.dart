import 'dart:io';

import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/models/product.dart';
import 'package:e_com_app/services/product_service.dart';
import 'package:e_com_app/widgets/product_image_picker.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key, required this.subcatId});
  final String subcatId;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  ProductService productService = ProductService();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _productNameController.dispose();
    _productPriceController.dispose();
  }

  List<String> categorieList = ["Electronique", "Mode", "Food"];
  String selectedCategorie = "Electronique";
  File? selectedFile;
  bool create = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Ajouter un produit",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProductImagePicker(
                    onPickImage: (image) {
                      setState(() {
                        selectedFile = image;
                      });
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Nom du produit",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _productNameController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Entrée invalide";
                    }
                    return null;
                  },
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black),
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    hintText: "Entrez le nom du produit",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: myOrange),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Description de la Boutique",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Entrée invalide";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: myOrange),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    hintText: "Description du produit",
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Prix du produit",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _productPriceController,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Entrée invalide";
                    }
                    return null;
                  },
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                    hintText: "Entrez le prix du produit",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: myOrange),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Categorie",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField(
                  isExpanded: true,
                  value: selectedCategorie,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: myOrange),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                  items: List.generate(
                    categorieList.length,
                    (index) => DropdownMenuItem(
                      value: categorieList[index],
                      child: Text(categorieList[index]),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedCategorie = value.toString();
                    });
                  },
                ),
                SizedBox(height: height * 0.1),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myOrange,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.35, vertical: 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          create = true;
                        });
                        try {
                          await productService.createProduct(
                            product: Product(
                              viewFile: selectedFile,
                              name: _productNameController.text,
                              price: double.parse(_productPriceController.text),
                              categoryId: selectedCategorie[0],
                              subCategoryId: '',
                              description: _descriptionController.text,
                              quantity: 1,
                            ),
                          );
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Produit ajouté avec succès")),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                        setState(() {
                          create = false;
                        });
                      }
                    },
                    child: create
                        ? const CircularProgressIndicator()
                        : Text(
                            "Ajouter",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
