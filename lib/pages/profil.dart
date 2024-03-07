import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _formKey = GlobalKey<FormState>();

  final telController = TextEditingController();
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  String selectedSex = "Masculin";
  DateTime selectedDateTime = DateTime.now();

  PlatformFile? pickedFile;

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    telController.dispose();
    nameController.dispose();
    firstNameController.dispose();
  }

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  iconSize: 20,
                  color: Colors.grey.shade600,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 90,
                ),
                Text(
                  "Profil",
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Stack(alignment: Alignment.center, children: [
                            if (pickedFile != null)
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250),
                                  child: Image.file(File(pickedFile!.path!)),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(115, 95, 0, 0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF3D6FE3)),
                                  ),
                                  InkWell(
                                    onTap: selectFile,
                                    child: Image.asset(
                                      "assets/images/camera.png",
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Your Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF3D6FE3)),
                          ),
                          Text(
                            "youremail@gmail.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: IntlPhoneField(
                              disableLengthCheck: true,
                              disableAutoFillHints: true,
                              onCountryChanged: (value) {
                                print('la valeur : ${value.dialCode}');
                              },
                              controller: telController,
                              decoration: InputDecoration(
                                hintText: 'Telephone',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                              ),
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            ),
                            shadowColor: Colors.black26,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: DateTimeFormField(
                              decoration: InputDecoration(
                                hintText: 'Date de naissance',
                                hintStyle: TextStyle(fontSize: 13),
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                              ),
                              mode: DateTimeFieldPickerMode.date,
                              autovalidateMode: AutovalidateMode.always,
                              validator: (e) => (e?.day ?? 0) == 1
                                  ? 'Please not the first day'
                                  : null,
                              onDateSelected: (DateTime value) {
                                setState(() {
                                  selectedDateTime = value;
                                });
                              },
                            ),
                            shadowColor: Colors.black26,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                hintText: 'Nom',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le champ ne doit pas être vide";
                                }
                                return null;
                              },
                            ),
                            shadowColor: Colors.black26,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Prénom',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Le champ ne doit pas être vide";
                                }
                                return null;
                              },
                            ),
                            shadowColor: Colors.black26,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                            child: DropdownButtonFormField(
                              items: [
                                DropdownMenuItem(
                                    value: 'Masculin',
                                    child: Text(
                                      "Masculin",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    )),
                                DropdownMenuItem(
                                    value: 'Feminin',
                                    child: Text(
                                      "Féminin",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black54),
                                    )),
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                              ),
                              value: 'Masculin',
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSex = value!;
                                });
                              },
                            ),
                            shadowColor: Colors.black26,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      shadowColor: Color(0x953D6FE3),
                      backgroundColor: Color(0xFF3D6FE3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading
                        ? null // Désactive le bouton pendant le chargement
                        : () async {
                            if (user != null) {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    isLoading = true; // Active l'indicateur de chargement
                                  });

                                  final userName = nameController.text;
                                  final userFirstName = firstNameController.text;
                                  final userTel = telController.text;

                                  CollectionReference profilRef = FirebaseFirestore.instance.collection("profil");

                                  // Utiliser l'ID de l'utilisateur comme identifiant du document
                                  final userId = user?.uid;

                                  // Vérifier si le document de l'utilisateur existe déjà
                                  final existingDoc = await profilRef.doc(userId).get();

                                  if (existingDoc.exists) {

                                    final path = 'files/${pickedFile!.name}';
                                    final file = File(pickedFile!.path!);
                                    final ref = FirebaseStorage.instance.ref().child(path);
                                    await ref.putFile(file);


                                    // Mettre à jour les informations si le document existe
                                    await profilRef.doc(userId).update({
                                      'datenaissance': selectedDateTime,
                                      'nom': userName,
                                      'prenom': userFirstName,
                                      'sexe': selectedSex,
                                      'telephone': userTel,
                                      'photoPath':path
                                    });

                                  } else {
                                    final path = 'files/${pickedFile!.name}';
                                    final file = File(pickedFile!.path!);
                                    final ref = FirebaseStorage.instance.ref().child(path);
                                    await ref.putFile(file);
                                    // Ajouter un nouveau document si le document n'existe pas
                                    await profilRef.doc(userId).set({
                                      'datenaissance': selectedDateTime,
                                      'nom': userName,
                                      'prenom': userFirstName,
                                      'sexe': selectedSex,
                                      'telephone': userTel,
                                      'photoPath':path
                                    });
                                  }

                                  // Fermez l'indicateur de chargement ici
                                } catch (e) {
                                  // Gérez les erreurs ici
                                  print(
                                      'Erreur lors de la mise à jour du profil : $e');
                                } finally {
                                  setState(() {
                                    isLoading =
                                        false; // Désactive l'indicateur de chargement
                                  });
                                }
                              }
                            }
                          },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 95),
                      child: isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Edit Profil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
