import 'dart:io';
import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/features/account/account.dart';
import 'package:e_com_app/features/boutique/become_boutique.dart';
import 'package:e_com_app/features/boutique/boutique.dart';
import 'package:e_com_app/provider/user_provider.dart';
import 'package:e_com_app/services/user_service.dart';
import 'package:e_com_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profil extends ConsumerStatefulWidget {
  const Profil({super.key});
  @override
  ConsumerState<Profil> createState() => _ProfilState();
}

class _ProfilState extends ConsumerState<Profil> {
  File? selectedImage;
  bool deconnect = false;
  UserService userService = UserService();
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    selectedImage = null;
    final user = ref.watch(userProvier);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profil",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: myGrisFonce55,
                      radius: 60,
                      child: user.imageUrl == ''
                          ? const Icon(
                              Icons.person_3,
                              size: 100,
                              color: Colors.white,
                            )
                          : ClipOval(
                              child: Image.network(
                                user.imageUrl,
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 180,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ImageInput(
                              onPickImage: (image) {
                                selectedImage = image;
                                ref
                                    .watch(userProvier.notifier)
                                    .setUserView(selectedImage!);
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: myOrange,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.username,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Account(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: myGris,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            "Compte",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          trailing: const SizedBox(
                            width: 20,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: myGris,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        onTap: () {
                          user.role == 0
                              ? Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BecomeBoutique(),
                                  ),
                                )
                              : Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Boutique(),
                                  ),
                                );
                        },
                        leading: const Icon(Icons.store),
                        title: Text(
                          "Ma Boutique",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        trailing: const SizedBox(
                          width: 20,
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          deconnect = true;
                        });
                        await userService.disconnectUser();
                        setState(() {
                          deconnect = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: myGris,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.exit_to_app),
                          title: deconnect
                              ? const CircularProgressIndicator()
                              : Text(
                                  "Se Déconnecter",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                        ),
                      ),
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
