import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com_app/models/boutique.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class BoutiqueService {
  Future<void> submitBoutiqueData({
    required String legualForm,
    required String country,
    required String region,
    required String name,
    required String description,
  }) async {
    final id = uuid.v4();
    FirebaseFirestore.instance
        .collection("boutique")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': id,
      'legualForm': legualForm,
      'country': country,
      'region': region,
      'name': name,
      'description': description,
      'sellerId': FirebaseAuth.instance.currentUser!.uid,
    });
    final pref = await SharedPreferences.getInstance();
    pref.setString('idBoutique', id);
    pref.setString('legualForm', legualForm);
    pref.setString('country', country);
    pref.setString('region', region);
    pref.setString('name', name);
    pref.setString('description', description);
    pref.setString('sellerId', FirebaseAuth.instance.currentUser!.uid);
  }

  Future<BoutiqueModel> getUserBoutique(String id) async {
    try {
      DocumentSnapshot boutiqueSnapshot = await FirebaseFirestore.instance
          .collection('boutique')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<String, dynamic> boutiqueData =
          boutiqueSnapshot.data() as Map<String, dynamic>;
      BoutiqueModel boutique = BoutiqueModel.fromMap(boutiqueData);
      return boutique;
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }
}
