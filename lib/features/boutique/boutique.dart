import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/features/boutique/add_product.dart';
import 'package:e_com_app/features/historique_commande/historique.dart';
import 'package:e_com_app/provider/boutique_provider.dart';
import 'package:e_com_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_com_app/data/sub_category_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Boutique extends ConsumerStatefulWidget {
  const Boutique({super.key});
  @override
  ConsumerState<Boutique> createState() => _BoutiqueState();
}

class _BoutiqueState extends ConsumerState<Boutique> {
  bool isActive = true;
  int currentIndex = 0;
  @override
  void initState() {
    ref.read(boutiqueProvier.notifier).getUserData();
    super.initState();
  }

  String currentScId = 'sccE';
  @override
  Widget build(BuildContext context) {
    final boutique = ref.watch(boutiqueProvier);
    final user = ref.watch(userProvier);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final inactiveDecoration = BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.black.withOpacity(0.3)),
        left: BorderSide(color: Colors.black.withOpacity(0.3)),
        right: BorderSide(color: Colors.black.withOpacity(0.3)),
        top: BorderSide(color: Colors.black.withOpacity(0.3)),
      ),
      shape: BoxShape.circle,
    );
    final activeDecoration = BoxDecoration(
      color: myOrange,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ],
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Historique(),
                  ),
                );
              },
              icon: Image.asset("assets/icon/my_history.png", width: 30),
            ),
          ],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(height: height * 0.3),
                Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 77,
                  child: Opacity(
                    opacity: 0.25,
                    child: Image.asset(
                      "assets/market.png",
                      width: width * 0.3,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: user.imageUrl == ''
                        ? const CircleAvatar(
                            backgroundColor: myGrisFonce55,
                            radius: 36,
                            child: Icon(
                              Icons.person_3,
                              size: 60,
                              color: Colors.white,
                            ),
                          )
                        : ClipOval(
                            child: Image.network(
                              user.imageUrl,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            boutique.name,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                )
                              ],
                            ),
                            child: const Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              "4,9",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          "(0)",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          "50 FCFA",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        subtitle: Text(
                          "Achat min",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.05,
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          "Ouvert .",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        subtitle: Text(
                          "Statut",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ],
              ),
              child: TabBar(
                indicatorColor: myOrange,
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                tabs: [
                  Tab(
                    child: Text(
                      'Electronique',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Mode',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Alimentation',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child:const TabBarView(
                  children: [

                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: 45,
          width: 45,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddProduct(
                    subcatId: currentScId,
                  ),
                ),
              );
            },
            backgroundColor: myOrange,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
