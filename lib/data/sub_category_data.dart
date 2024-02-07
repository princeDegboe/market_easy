import 'package:e_com_app/features/boutique/sub_cat_content/electronic/casque.dart';
// import 'package:e_com_app/features/boutique/sub_cat_content/electronic/computer.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/electronic/ecouteur.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/electronic/montre.dart';
// import 'package:e_com_app/features/boutique/sub_cat_content/electronic/mouse.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/electronic/phone.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/fashion/acessoire.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/fashion/chaussure.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/fashion/cloth.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/fashion/lingerie.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/food/boisson.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/food/fruit.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/food/produit.dart';
import 'package:e_com_app/features/boutique/sub_cat_content/food/ustensil.dart';

List<Map<String, dynamic>> electroSubCategoriData = [
  {
    "id": "sccE",
    "subCategoriName": "Casque",
    "imgPath": "assets/electro_sub_category/casque.png",
    "content": const Casque(),
  },
  {
    "id": "sceE",
    "subCategoriName": "Ecouteur",
    "imgPath": "assets/electro_sub_category/ecouteur.png",
    "content": const Ecouteur(),
  },
  {
    "id": "scmE",
    "subCategoriName": "Montre",
    "imgPath": "assets/electro_sub_category/montre.png",
    "content": const Montre(),
  },
  {
    "id": "sctE",
    "subCategoriName": "Téléphone",
    "imgPath": "assets/electro_sub_category/phone.png",
    "content": const Phone(),
  },
  // {
  //   "id": "scoE",
  //   "subCategoriName": "Ordinateur",
  //   "imgPath": "assets/electro_sub_category/ordi.png",
  //   "content": const Computer(),
  // },
  // {
  //   "id": "scsE",
  //   "subCategoriName": "Souris",
  //   "imgPath": "assets/electro_sub_category/souris.png",
  //   "content": const Mouse(),
  // },
];

List<Map<String, dynamic>> modeSubCategoriData = [
  {
    "id": "sclM",
    "subCategoriName": "Lingerie",
    "imgPath": "assets/fashion_sub_category/lingerie.png",
    "content": const Lingerie(),
  },
  {
    "id": "sccM",
    "subCategoriName": "Chaussure",
    "imgPath": "assets/fashion_sub_category/chaussure.png",
    "content": const Chaussure(),
  },
  {
    "id": "scvM",
    "subCategoriName": "Vetement",
    "imgPath": "assets/fashion_sub_category/vetement.png",
    "content": const Cloth(),
  },
  {
    "id": "scaM",
    "subCategoriName": "Acessoires",
    "imgPath": "assets/fashion_sub_category/acessoire.png",
    "content": const Acessoire(),
  },
];

List<Map<String, dynamic>> foodSubCategoriData = [
  {
    "id": "scuF",
    "subCategoriName": "Ustensil",
    "imgPath": "assets/food_sub_category/ustensil.png",
    "content": const Ustensil(),
  },
  {
    "id": "scbF",
    "subCategoriName": "Boisson",
    "imgPath": "assets/food_sub_category/boisson.png",
    "content": const Boisson(),
  },
  {
    "id": "scpF",
    "subCategoriName": "Produit",
    "imgPath": "assets/food_sub_category/produit.png",
    "content": const Produit(),
  },
  {
    "id": "scfF",
    "subCategoriName": "Fruit",
    "imgPath": "assets/food_sub_category/fruit.png",
    "content": const Fruit(),
  },
];
