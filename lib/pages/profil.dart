import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final telController = TextEditingController();
  String selectedConfType = "";

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
                Stack(alignment: Alignment.center, children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset(
                        "assets/images/avatar.png",
                        height: 150,
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(115, 95, 0, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF3D6FE3)),
                        ),
                        Image.asset(
                          "assets/images/camera.png",
                          height: 15,
                          width: 15,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                      child: Column(
                    children: [
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
                            print(value);
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
                                    "Masculin",style: TextStyle(fontSize: 13,color: Colors.black54),
                                  )),
                              DropdownMenuItem(
                                  value: 'Feminin',
                                  child: Text(
                                    "Féminin",style: TextStyle(fontSize: 13,color: Colors.black54),
                                  )),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                            value: 'Masculin',
                            onChanged: (value) {
                              setState(() {
                                selectedConfType = value!;
                              });
                            }),
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
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      print("Le numéro de téléphone : ${telController.text}");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 95),
                      child: Text(
                        'Edit Profil',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
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
