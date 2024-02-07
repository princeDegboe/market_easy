import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/features/command/address_page.dart';
import 'package:e_com_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int numbreCmde = 1;
  final NumberFormat format = NumberFormat("#,###", "fr");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget.product.imageUrl.toString())),
                      ),
                    ),
                    SafeArea(
                      child: Positioned(
                        child: IconButton(
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myWhite,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.share,
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myWhite,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xFFAA0000),
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myWhite,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                color: myYellow,
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: myWhite,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 1,
                                  spreadRadius: 0.1,
                                  color: myGrisFonceAA,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              splashRadius: 5,
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.store,
                                color: myOrange,
                              ),
                              style: IconButton.styleFrom(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: myOrange,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0.1,
                            color: myGrisFonceAA,
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        splashRadius: 5,
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          if (numbreCmde > 1) {
                            setState(() {
                              --numbreCmde;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: myWhite,
                        ),
                        style: IconButton.styleFrom(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$numbreCmde",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: myGrisFonce,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: myOrange,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0.1,
                            color: myGrisFonceAA,
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        splashRadius: 5,
                        iconSize: 20,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            ++numbreCmde;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: myWhite,
                        ),
                        style: IconButton.styleFrom(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Card(
              elevation: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: DefaultTabController(
                          length: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TabBar(
                                tabs: [
                                  Tab(
                                    text: "Produit",
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        widget.product.name,
                                                        style: const TextStyle(
                                                          color: myGrisFonce,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                color: myYellow,
                                                                size: 18,
                                                              ),
                                                              Text(
                                                                "4,54 M",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      myGrisFonce,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "(1203 avis)",
                                                            style: TextStyle(
                                                              color:
                                                                  myGrisFonceAA,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 4,
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: myWhite,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        offset: Offset(0, 0),
                                                        blurRadius: 1,
                                                        spreadRadius: 0.1,
                                                        color: myGrisFonce55,
                                                      ),
                                                    ],
                                                  ),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text: "XOF ",
                                                          style: TextStyle(
                                                            color: myOrange,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: widget.product.price.toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: myGrisFonce,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Description",
                                                  style: TextStyle(
                                                    color: myGrisFonce,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  widget.product.description,
                                                  style: const TextStyle(
                                                    color: myGrisFonce,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.13,
                            vertical: 10,
                          ),
                          backgroundColor: myOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddressPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Commander",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
