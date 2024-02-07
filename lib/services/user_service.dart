import 'dart:io';
import 'package:e_com_app/models/user.dart';
import 'package:e_com_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<void> createUser({
    required String fullName,
    required String password,
    required String userName,
    required String email,
    required int role,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(
            userCredential.user!.uid,
          )
          .set({
        'id': userCredential.user!.uid,
        'fullName': fullName,
        'role': 0,
        'username': userName,
        'email': email,
        'imageUrl': '',
        'password': password,
        'nationality': '',
        'birthday': '',
        'idCardPath': '',
        'tel': '',
      });
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        throw Exception('Ce utilisateur existe déjà');
      } else if (error.code == 'invalid-email') {
        throw Exception('Adresse email invalide');
      } else if (error.code == 'weak-password') {
        throw Exception('Utiliser un mot de passe fort');
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }
  }

  Future<void> connectUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userData = await userService.fetchUserData();
      final pref = await SharedPreferences.getInstance();
      pref.setString('email', userData.email);
      pref.setString('fullName', userData.fullName);
      pref.setString('id', userData.id);
      pref.setString('imageUrl', userData.imageUrl);
      pref.setString('password', userData.password);
      pref.setString('username', userData.username);
      pref.setInt('role', userData.role);
      pref.setString('birthday', userData.birthday.toString());
      pref.setString('nationality', userData.nationality.toString());
      pref.setString('idCardPath', userData.idCardPath.toString());
      pref.setString('tel', userData.tel.toString());
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw Exception("Ce utilisateur n'existe pas");
      } else if (error.code == 'invalid-email') {
        throw Exception('Adresse email invalide');
      } else if (error.code == 'wrong-password') {
        throw Exception('Mot de passe incorrect');
      } else {
        throw Exception("Quelque chose s'est mal passé");
      }
    }
  }

  Future<void> disconnectUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  Future<UserModel> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(userData);
      return user;
    } catch (e) {
      throw Exception("Quelque chose s'est mal passé");
    }
  }

  Future<String> setUserView(File imageFile) async {
    try {
      final userData = await userService.fetchUserData();
      final stockageRef =
          FirebaseStorage.instance.ref().child('user_image').child(
                '${FirebaseAuth.instance.currentUser!.uid}.jpg',
              );
      await stockageRef.putFile(imageFile);
      final imageUrl = await stockageRef.getDownloadURL();

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'id': userData.id,
          'fullName': userData.fullName,
          'role': userData.role,
          'username': userData.username,
          'email': userData.email,
          'password': userData.password,
          'nationality': userData.nationality,
          'birthday': userData.birthday,
          'idCardPath': userData.idCardPath,
          'tel': userData.tel,
          'imageUrl': imageUrl,
        },
      );
      return imageUrl;
    } catch (e) {
      print("Erreur lors de la mise à jour de l'image de l'utilisateur");
      throw Exception(
          "Quelque chose s'est mal passé lors de la mise à jour de l'image.");
    }
  }

  Future<void> completeInfoToBecomeSeller({
    required String nationality,
    required String birthday,
    required String idCardPath,
    required String tel,
  }) async {
    try {
      final userData = await userService.fetchUserData();
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'id': userData.id,
          'fullName': userData.fullName,
          'username': userData.username,
          'email': userData.email,
          'password': userData.password,
          'imageUrl': userData.imageUrl,
          'role': 1,
          'nationality': nationality,
          'birthday': birthday,
          'idCardPath': idCardPath,
          'tel': tel,
        },
      );
    } catch (e) {
      print("Quelque chose s'est mal passé lors de la complétion du profil.");
      throw Exception(
          "Quelque chose s'est mal passé lors de la complétion du profil.");
    }
  }
}
