import 'package:e_com_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/widgets/text_form_field_card.dart';
import 'package:e_com_app/widgets/text_form_field_for_password.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationAndLoginScreen extends ConsumerStatefulWidget {
  const RegistrationAndLoginScreen({
    super.key,
    required this.registrationMode,
  });
  final bool registrationMode;
  @override
  ConsumerState<RegistrationAndLoginScreen> createState() =>
      _RegistrationAndLoginScreenState();
}

class _RegistrationAndLoginScreenState
    extends ConsumerState<RegistrationAndLoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameAndSurnameController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _mailOfConnexionController =
      TextEditingController();
  final TextEditingController _passwordOfConnexionController =
      TextEditingController();

  int _registrationPhase = 1;
  late bool _registrationMode;
  late Widget content;
  @override
  void initState() {
    super.initState();
    _registrationMode = widget.registrationMode;
  }

  @override
  void dispose() {
    super.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _mailOfConnexionController.dispose();
    _nameAndSurnameController.dispose();
    _passwordController.dispose();
    _passwordOfConnexionController.dispose();
    _usernameController.dispose();
  }

  UserService userService = UserService();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    if (_registrationPhase == 1 && _registrationMode) {
      content = Column(
        children: [
          TextFormFieldCard(
            hintText: 'Nom et prénom',
            controller: _nameAndSurnameController,
            prefixIcon: const Icon(Icons.person),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Nom, prénom invalide";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldCard(
            hintText: "Nom d'utilisateur",
            controller: _usernameController,
            prefixIcon: const Icon(Icons.person),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Nom d'utilisateur invalide";
              }
              return null;
            },
          ),
        ],
      );
    } else if (_registrationPhase == 2 && _registrationMode) {
      content = Column(
        children: [
          TextFormFieldCard(
            hintText: 'Adresse mail',
            controller: _emailController,
            prefixIcon: const Icon(Icons.mail),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Email invalide";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldForPassword(
            controller: _passwordController,
            hintText: 'Mot de passe',
            validator: (value) {
              if (value!.trim().isEmpty || value.trim().length < 8) {
                return "Entrez un mot de passe d'au moins 8 charactères";
              }
              return null;
            },
          ),
        ],
      );
    } else if (_registrationPhase == 3 && _registrationMode) {
      content = Column(
        children: [
          TextFormFieldForPassword(
            validator: (value) {
              if (value!.trim().isEmpty || value != _passwordController.text) {
                "Mot de passe non conforme";
              }
              return null;
            },
            hintText: 'Confirmer mot de passe',
            controller: _confirmPasswordController,
          ),
        ],
      );
    } else if (_registrationMode == false) {
      content = Column(
        children: [
          TextFormFieldCard(
            hintText: 'Adresse mail',
            controller: _mailOfConnexionController,
            prefixIcon: const Icon(Icons.mail),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Email invalide";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormFieldForPassword(
            controller: _passwordOfConnexionController,
            hintText: 'Mot de passe',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Mot de passe invalide";
              }
              return null;
            },
          ),
        ],
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF6f6f6),
      appBar: _registrationMode
          ? AppBar(
              backgroundColor: const Color(0xFFF6f6f6),
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  if (_registrationMode && _registrationPhase > 1) {
                    setState(() {
                      _registrationPhase--;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_back),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  "assets/ecom_logo_text.png",
                  width: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _registrationMode ? "Créer un compte" : "Se connecter",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                content,
                SizedBox(
                  height: height * 0.1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 128,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (_registrationMode) {
                        _formkey.currentState!.save();
                        if (_registrationMode && _registrationPhase == 3) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await userService.createUser(
                              fullName: _nameAndSurnameController.text,
                              password: _passwordController.text,
                              userName: _usernameController.text,
                              email: _emailController.text,
                              role: 0,
                            );
                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                          return;
                        }
                        setState(() {
                          _registrationPhase++;
                        });
                      } else if (!_registrationMode) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await userService.connectUser(
                            email: _mailOfConnexionController.text,
                            password: _passwordOfConnexionController.text,
                          );
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(color: myOrange)
                      : Text(
                          "Suivant",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                const Divider(color: Colors.black, thickness: 0.4),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/logo_facebook.png",
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/logo_google.png",
                            width: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _registrationMode
                          ? 'Vous aviez déjà unn compte?'
                          : "Vous n'aviez pas encore de compte?",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _registrationMode = !_registrationMode;
                        });
                      },
                      child: Text(
                        _registrationMode ? 'Connectez vous' : "S'inscrire",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: myOrange, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
