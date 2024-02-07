import 'package:e_com_app/services/boutique_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_com_app/models/boutique.dart';

BoutiqueService boutiqueService = BoutiqueService();

class BoutiqueNotifier extends StateNotifier<BoutiqueModel> {
  BoutiqueNotifier()
      : super(
          BoutiqueModel(
            legualForm: '',
            sellerId: '',
            country: '',
            region: '',
            name: '',
            description: '',
          ),
        );
  Future<void> getUserData() async {
    final boutique = await boutiqueService.getUserBoutique(
      FirebaseAuth.instance.currentUser!.uid,
    );
    state = boutique;
  }

  Future<void> submitBoutiqueData({
    required String legualForm,
    required String country,
    required String region,
    required String name,
    required String description,
  }) async {
    boutiqueService.submitBoutiqueData(
      legualForm: legualForm,
      country: country,
      region: region,
      name: name,
      description: description,
    );
    await getUserData();
  }
}

final boutiqueProvier = StateNotifierProvider<BoutiqueNotifier, BoutiqueModel>(
  (ref) => BoutiqueNotifier(),
);
