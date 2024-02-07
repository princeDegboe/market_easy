import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/models/product.dart';
import 'package:e_com_app/services/local_db.dart';
import 'package:e_com_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool selectedAll = true;
  bool selectedElectronic = false;
  bool selectedFashion = false;
  bool selectedFood = false;
  int selected = 0;
  List<Product> favoris = [];
  final NumberFormat format = NumberFormat("#,###", "en");
  LocalDb localDb = LocalDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myWhite,
        title: Center(
          child: Text(
            'Favorites',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
        future: localDb.getAllFavoris(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erreur : ${snapshot.error}");
          } else if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: myOrange,
              ),
            );
          } else {
            favoris = snapshot.data!;
            return favoris.isEmpty
                ? Center(
                    child: Text(
                      "Vide",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                    ),
                  )
                : Wrap(
                    children: List.generate(
                      favoris.length,
                      (index) => ProductCard(product: favoris[index]),
                    ),
                  );
          }
        },
      ),
    );
  }
}
