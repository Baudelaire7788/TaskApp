import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskapp/auth/user_auth_services.dart';
import 'package:taskapp/pages/home.dart';

//keytool -list -v -keystore C:\Users\HP\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuthService _auth = FirebaseAuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } else {
      print("Erreur lors de la création de l'utilisateur");
    }
  }

  void googleSignIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        print('Connexion réussie avec Google: ${user.displayName}');
      } else {
        print('Échec de la connexion avec Google');
      }
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      print('Erreur lors de la connexion avec Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.keyboard_backspace,
                              color: Color(0xFF3D6FE3),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/splash.png",
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Create your Account",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 2,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        hintStyle: TextStyle(fontSize: 13),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 2,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: TextStyle(fontSize: 13),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscurePassword = !_obscurePassword;
                                              });
                                            },
                                            child: Icon(_obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          )),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 2,
                                    child: TextFormField(
                                      obscureText: _obscureConfirmPassword,
                                      controller: confirmPasswordController,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureConfirmPassword = !_obscureConfirmPassword;
                                            });
                                          },
                                          child: Icon(_obscureConfirmPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(fontSize: 13),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Color(0x953D6FE3),
                        backgroundColor: Color(0xFF3D6FE3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final password = passwordController.text;
                          final confirm = confirmPasswordController.text;

                          if (password == confirm) {
                            signUp();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showMaterialBanner(MaterialBanner(
                              leading: Icon(
                                Icons.error_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              backgroundColor: Colors.red,
                              content: Text(
                                "Vous devez renseigner le même mot de passe",
                                style: TextStyle(color: Colors.white),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .hideCurrentMaterialBanner(),
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white),
                                )
                              ],
                            ));
                          }
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 17, horizontal: 95),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "- Or sign in with -",
                    style: TextStyle(color: Colors.black26, fontSize: 13),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Form(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  googleSignIn();
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 28),
                                      child: Image.asset(
                                        "assets/images/google.png",
                                        width: 30,
                                        height: 30,
                                      )),
                                  shadowColor: Colors.black26,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 2,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 28),
                                    child: Image.asset(
                                      "assets/images/github.png",
                                      width: 30,
                                      height: 30,
                                    )),
                                shadowColor: Colors.black26,
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
