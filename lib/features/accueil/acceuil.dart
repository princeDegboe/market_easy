import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/data/carousel_data.dart';
import 'package:e_com_app/data/category_data.dart';
import 'package:e_com_app/models/product.dart';
import 'package:e_com_app/services/product_service.dart';
import 'package:e_com_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});
  @override
  State<Accueil> createState() {
    return _AccueilState();
  }
}

class _AccueilState extends State<Accueil> {
  int selected = 0;
  CarouselController carouselController = CarouselController();
  int currentCarousselView = 0;
  final NumberFormat format = NumberFormat("#,###", "en");
  ProductService productService = ProductService();
  List<Product> allProductList = [];
  List<Product> filteredAll = [];
  late List<Product> allProduct = [];
  late List<Product> electroProduct = [];
  late List<Product> foodProduct = [];
  late List<Product> modeProduct = [];
  List<Product> searchProducts(String enter, List<Product> list) {
    return list
        .where((product) =>
            product.name.toLowerCase().startsWith(enter.toLowerCase()))
        .toList();
  }

  late Widget content;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (selected == 0) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentCarousselView = index;
                  });
                },
                height: height * 0.2,
                autoPlay: true,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 10),
              ),
              items: carousselData.map(
                (element) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Color.fromARGB(255, 116, 115, 115)
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              element['name'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            subtitle: Text(
                              element['description'].toString(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            leading:
                                Image.asset(element['pathToImg'].toString()),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              carousselData.length,
              (index) {
                if (index == currentCarousselView) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: myYellow,
                      shape: BoxShape.circle,
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.all(2),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: myGrisFonceAA,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          FutureBuilder<List<Product>>(
            future: productService.getAllProduct(),
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
                filteredAll.isEmpty
                    ? allProduct = snapshot.data!
                    : allProduct = filteredAll;
                return Wrap(
                  children: List.generate(
                    allProduct.length,
                    (index) => ProductCard(product: allProduct[index]),
                  ),
                );
              }
            },
          ),
        ],
      );
    } else if (selected == 1) {
      content = FutureBuilder<List<Product>>(
        future: productService.getProductByCategory(value: "E"),
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
            electroProduct = snapshot.data!;
            return Wrap(
              children: List.generate(
                electroProduct.length,
                (index) => ProductCard(product: electroProduct[index]),
              ),
            );
          }
        },
      );
    } else if (selected == 2) {
      content = FutureBuilder<List<Product>>(
        future: productService.getProductByCategory(value: "M"),
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
            modeProduct = snapshot.data!;
            return Wrap(
              children: List.generate(
                modeProduct.length,
                (index) => ProductCard(product: modeProduct[index]),
              ),
            );
          }
        },
      );
    } else if (selected == 3) {
      content = FutureBuilder<List<Product>>(
        future: productService.getProductByCategory(value: "F"),
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
            foodProduct = snapshot.data!;
            return Wrap(
              children: List.generate(
                foodProduct.length,
                (index) => ProductCard(product: foodProduct[index]),
              ),
            );
          }
        },
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 15,
                      bottom: 15,
                      left: 15,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              color: myGrisFonce,
                            ),
                            onChanged: (value) {
                              if (value.trim().isEmpty) {
                                setState(() {
                                  filteredAll = [];
                                });
                              } else {
                                setState(() {
                                  filteredAll =
                                      searchProducts(value, allProduct);
                                });
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Rechercher',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: myGrisFonce22,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: myGrisFonce22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  filteredAll.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      for (int i = 0;
                                          i < myCategories.length;
                                          i++) ...[
                                        selected == i
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: myOrange,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: () {},
                                                child:
                                                    Text(myCategories[i].title),
                                              )
                                            : OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(() => selected = i);
                                                },
                                                child:
                                                    Text(myCategories[i].title),
                                              ),
                                        if (i != myCategories.length - 1)
                                          const SizedBox(width: 10),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            content,
                          ],
                        )
                      : Wrap(
                          children: List.generate(
                            filteredAll.length,
                            (index) => ProductCard(product: filteredAll[index]),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
