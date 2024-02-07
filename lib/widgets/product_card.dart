import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/features/product_detail/product_detail.dart';
import 'package:e_com_app/models/product.dart';
import 'package:e_com_app/services/local_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final LocalDb localDb = LocalDb();
  late Future<bool> _isFavoris;

  @override
  void initState() {
    super.initState();
    _isFavoris = isFavoris();
  }

  Future<bool> isFavoris() async {
    final isFavoris = await localDb.isProductInFavoris(
      widget.product.idProduct.toString(),
    );
    return isFavoris;
  }

  final NumberFormat format = NumberFormat("#,###", "en");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      child: Container(
        width: size.width * 0.45,
        margin: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.all(
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
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.008),
                Container(
                  height: size.height * 0.15,
                  width: size.width * 0.43,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(widget.product.imageUrl.toString())),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        top: 4,
                      ),
                      child: Text(
                        widget.product.name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: myGrisFonce),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        top: 4,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "XOF ",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      color: myOrange,
                                      fontWeight: FontWeight.w600,
                                    )),
                            TextSpan(
                              text: format.format(widget.product.price),
                              style: const TextStyle(
                                color: myGrisFonce,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 4,
                        left: 10,
                      ),
                      width: size.width * 0.15,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: myWhite,
                        borderRadius: BorderRadius.all(
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: myYellow,
                            size: 15,
                          ),
                          Text("${10} M",
                              style: Theme.of(context).textTheme.labelSmall),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: size.width * 0.03, bottom: size.height * 0.03),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: myWhite,
                            ),
                            style: IconButton.styleFrom(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FutureBuilder<bool>(
              future: _isFavoris,
              builder: (context, snapshot) {
                return Container(
                  width: 25,
                  height: 25,
                  margin: EdgeInsets.only(
                      left: size.width * 0.02, top: size.height * 0.02),
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
                    iconSize: 15,
                    padding: const EdgeInsets.all(0),
                    onPressed: () async {
                      setState(() async {
                        final isFav = await localDb.isProductInFavoris(
                            widget.product.idProduct.toString());
                        isFav
                            ? await localDb.insertDataInFavoris(widget.product)
                            : await localDb.removeFromFavoris(
                                widget.product.idProduct.toString(),
                              );
                        setState(() {});
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: snapshot.data ?? false
                          ? Colors.red
                          : Colors.grey.withOpacity(0.5),
                    ),
                    style: IconButton.styleFrom(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
