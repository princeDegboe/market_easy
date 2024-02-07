import 'dart:io';

import 'package:e_com_app/models/user.dart';
import 'package:e_com_app/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserService userService = UserService();

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(
          UserModel(
            id: '',
            fullName: '',
            username: '',
            role: 0,
            password: '',
            email: '',
            imageUrl: '',
            birthday: '',
            idCardPath: '',
            nationality: '',
            tel: '',
          ),
        );

  Future<void> setUserView(File imageFile) async {
    try {
      String imageUrl = await userService.setUserView(imageFile);
      final pref = await SharedPreferences.getInstance();
      pref.setString("imageUrl", imageUrl).toString();
      state.imageUrl = imageUrl;
    } catch (e) {
      print(
          "Quelque chose s'est mal passé au niveau au niveude \"setUserView\" ");
      throw Exception("Quelque chose s'est mal passé au niveau");
    }
  }

  Future<void> getUserData() async {
    final pref = await SharedPreferences.getInstance();
    state.id = pref.getString("id").toString();
    state.fullName = pref.getString("fullName").toString();
    state.username = pref.getString("username").toString();
    state.role = pref.getInt("role")!.toInt();
    state.password = pref.getString("password").toString();
    state.email = pref.getString("email").toString();
    state.imageUrl = pref.getString("imageUrl").toString();
    state.birthday = pref.getString("birthday");
    state.idCardPath = pref.getString("idCardPath").toString();
    state.nationality = pref.getString("nationality").toString();
    state.tel = pref.getString("tel").toString();
  }

  Future<void> completeInfoToBecomeSeller({
    required String nationality,
    required String birthday,
    required idCardPath,
    required String tel,
  }) async {
    try {
      await userService.completeInfoToBecomeSeller(
        nationality: nationality,
        birthday: birthday,
        idCardPath: idCardPath,
        tel: tel,
      );
      final pref = await SharedPreferences.getInstance();
      pref.setInt('role', 1);
      pref.setString('birthday', birthday);
      pref.setString('nationality', nationality);
      pref.setString('idCardPath', idCardPath);
      pref.setString('tel', tel);
      await getUserData();
    } catch (e) {
      print(
          "Quelque chose s'est mal passé au niveau au niveude \"completeInfoToBecomeSeller\" ");
      throw Exception("Quelque chose s'est mal passé");
    }
  }
}

final userProvier = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);
