import 'package:e_com_app/const/colors.dart';
import 'package:e_com_app/data/become_seller_step_data.dart';
import 'package:e_com_app/features/home/home.dart';
import 'package:e_com_app/provider/boutique_provider.dart';
import 'package:e_com_app/provider/user_provider.dart';
import 'package:e_com_app/widgets/text_form_field_card_for_tell_all_country.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BecomeBoutique extends ConsumerStatefulWidget {
  const BecomeBoutique({super.key});

  @override
  ConsumerState<BecomeBoutique> createState() => _BecomeBoutiqueState();
}

class _BecomeBoutiqueState extends ConsumerState<BecomeBoutique> {
  late Widget content;
  bool becomeSeller = false;
  int step = 1;
  late Widget stepContent;
  final _formkeyStep1 = GlobalKey<FormState>();
  final _formkeyStep2 = GlobalKey<FormState>();
  String? juriForm = "Entreprise individuelle";
  String? currentCountryStep1 = "Bénin";
  String? currentCountryStep2 = "Bénin";
  final TextEditingController _stateProvinceRegionController =
      TextEditingController();
  final TextEditingController _addrController = TextEditingController();
  final TextEditingController _boutiqueNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  bool showFlotting = true;
  bool isSubmit = false;

  @override
  void dispose() {
    super.dispose();
    _stateProvinceRegionController.dispose();
    _addrController.dispose();
    _boutiqueNameController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final activeStepIndicatorDecoration = BoxDecoration(
      color: myOrange,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
          offset: const Offset(2, 3),
        )
      ],
    );
    final activeStepIndicatorTextStyle =
        Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            );
    final inactiveStepIndicatorDecoration = BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.black.withOpacity(0.3)),
        left: BorderSide(color: Colors.black.withOpacity(0.3)),
        right: BorderSide(color: Colors.black.withOpacity(0.3)),
        top: BorderSide(color: Colors.black.withOpacity(0.3)),
      ),
      shape: BoxShape.circle,
    );
    final inactiveStepIndicatorTextStyle =
        Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.black.withOpacity(0.3),
            );
    if (step == 1 && becomeSeller) {
      stepContent = Form(
        key: _formkeyStep1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informations commerciales",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Forme juridique",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              value: juriForm,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
              items: List.generate(
                juriFormList.length,
                (index) => DropdownMenuItem(
                  value: juriFormList[index],
                  child: Text(juriFormList[index]),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  juriForm = value;
                });
              },
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Adresse de résidence de la Boutique",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              value: currentCountryStep1,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
              items: List.generate(
                countryData.length,
                (index) => DropdownMenuItem(
                  value: countryData[index],
                  child: Text(countryData[index]),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  currentCountryStep1 = value;
                });
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _stateProvinceRegionController,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Entrée invalide";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                hintText: "Etat/Province/Région",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _addrController,
              maxLines: 2,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Entrée invalide";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                hintText: "Nom de la rue, numéro, code postal",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Nom de la Boutique",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _boutiqueNameController,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Entrée invalide";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                hintText: "Non de la Boutique",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Description de la Boutique",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 4,
              maxLength: 100,
              controller: _descriptionController,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Entrée invalide";
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                hintText: "Description de la Boutique",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    } else if (step == 2 && becomeSeller) {
      stepContent = Form(
        key: _formkeyStep2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informations du représentant légal",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Nationalité",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField(
              isExpanded: true,
              value: currentCountryStep2,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myOrange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
              ),
              items: List.generate(
                countryData.length,
                (index) => DropdownMenuItem(
                  value: countryData[index],
                  child: Text(countryData[index]),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  currentCountryStep2 = value;
                });
              },
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Date de naissance",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                    isExpanded: true,
                    value: currentCountryStep2,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myOrange),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                    items: List.generate(
                      countryData.length,
                      (index) => DropdownMenuItem(
                        value: countryData[index],
                        child: Text(
                          countryData[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentCountryStep2 = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: currentCountryStep2,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myOrange),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                    items: List.generate(
                      countryData.length,
                      (index) => DropdownMenuItem(
                        value: countryData[index],
                        child: Text(
                          countryData[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentCountryStep2 = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: currentCountryStep2,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myOrange),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                    ),
                    items: List.generate(
                      countryData.length,
                      (index) => DropdownMenuItem(
                        value: countryData[index],
                        child: Text(
                          countryData[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        currentCountryStep2 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Carte d'identité ou passport",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            DottedBorder(
              color: Colors.grey,
              strokeWidth: 1,
              child: SizedBox(
                width: double.infinity,
                height: height * 0.18,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Numéro de la téléphone",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 5),
            TextFormFieldCardForTellAllCountry(controller: _telController),
          ],
        ),
      );
    } else if (step == 3 && becomeSeller) {
      stepContent = Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: myOrange),
            onPressed: () {},
            label: const Text("Retourner à l'accueil"),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      );
    }
    if (becomeSeller == false) {
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.12,
              ),
              Opacity(
                opacity: 0.25,
                child: Image.asset(
                  "assets/market.png",
                  width: width * 0.4,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Devenez un vendeur",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width * 0.6,
                child: Text(
                  "Transformez votre passion en profil avec notre plateforme et découvrez les avantages exclusifs de devenir vendeur",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.black.withOpacity(0.5),
                      ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: myOrange,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18)))),
                onPressed: () {
                  setState(() {
                    becomeSeller = true;
                  });
                },
                child: Text(
                  "Devenir vendeur",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      );
    } else if (becomeSeller) {
      content = Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: step == 1
                      ? activeStepIndicatorDecoration
                      : inactiveStepIndicatorDecoration,
                  child: Text(
                    "1",
                    style: step == 1
                        ? activeStepIndicatorTextStyle
                        : inactiveStepIndicatorTextStyle,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.3),
                    indent: 8,
                    endIndent: 8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: step == 2
                      ? activeStepIndicatorDecoration
                      : inactiveStepIndicatorDecoration,
                  child: Text(
                    "2",
                    style: step == 2
                        ? activeStepIndicatorTextStyle
                        : inactiveStepIndicatorTextStyle,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.3),
                    indent: 8,
                    endIndent: 8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: step == 3
                      ? activeStepIndicatorDecoration
                      : inactiveStepIndicatorDecoration,
                  child: Text(
                    "3",
                    style: step == 3
                        ? activeStepIndicatorTextStyle
                        : inactiveStepIndicatorTextStyle,
                  ),
                ),
                SizedBox(
                  width: width * 0.07,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.25,
                  child: Text(
                    "Informations commerciales",
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: width * 0.25,
                  child: Text(
                    "Informations du vendeur",
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: width * 0.25,
                  child: Text(
                    "En attente d'approbation",
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            stepContent,
          ],
        ),
      );
    }

    return Scaffold(
      appBar: becomeSeller == false
          ? AppBar(
              scrolledUnderElevation: 0,
              title: Text(
                "Ma Boutique",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            )
          : step == 3
              ? null
              : AppBar(
                  scrolledUnderElevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      if (step == 1) {
                        Navigator.pop(context);
                      } else if (step > 1 && step <= 2) {
                        setState(() {
                          step--;
                        });
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
      body: SingleChildScrollView(child: content),
      floatingActionButton: becomeSeller && showFlotting
          ? Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: width * 0.20,
                height: height * 0.06,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: myOrange,
                  onPressed: () {
                    if (step == 1 && _formkeyStep1.currentState!.validate()) {
                      _formkeyStep1.currentState!.save();
                      setState(() {
                        step = 2;
                      });
                    } else if (step == 2 &&
                        _formkeyStep2.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            "Soumettre",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black),
                          ),
                          content: Text(
                            "Etes vous sur de soumettre ces informations? Celà est irréversible",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler"),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: myOrange),
                              onPressed: () {
                                setState(() {
                                  isSubmit = true;
                                });
                                ref
                                    .watch(userProvier.notifier)
                                    .completeInfoToBecomeSeller(
                                      nationality:
                                          currentCountryStep2.toString(),
                                      birthday: '04/04/2003',
                                      idCardPath: '',
                                      tel: _telController.text,
                                    );
                                ref
                                    .watch(boutiqueProvier.notifier)
                                    .submitBoutiqueData(
                                      country: currentCountryStep1.toString(),
                                      description: _descriptionController.text,
                                      legualForm: juriForm.toString(),
                                      name: _boutiqueNameController.text,
                                      region:
                                          _stateProvinceRegionController.text,
                                    );
                                setState(() {
                                  isSubmit = false;
                                  step = 3;
                                  showFlotting = false;
                                });
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              child: isSubmit
                                  ? const CircularProgressIndicator(
                                      color: myOrange,
                                    )
                                  : const Text("Soumettre"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    "assets/icon/check_inv.png",
                    width: 20,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
