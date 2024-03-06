import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskapp/pages/login.dart';
import 'package:taskapp/pages/profil.dart';
import 'package:taskapp/pages/task.dart';
import 'package:taskapp/pages/taskcard.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<TaskCard> list = [
    TaskCard(
        nom: "Dashboard panel",
        description: "Small description",
        type: "assets/images/settings.png",
        pregress: "0.5"),
    TaskCard(
        nom: "Mailing contrats",
        description: "Small description",
        type: "assets/images/mail.png",
        pregress: "0.75"),
    TaskCard(
        nom: "Daily stand up",
        description: "Small description",
        type: "assets/images/telephone.png",
        pregress: "0.25"),
    TaskCard(
        nom: "Meeting with dev team",
        description: "Small description",
        type: "assets/images/telephone.png",
        pregress: "0"),
    TaskCard(
        nom: "Dashboard Panel",
        description: "Small description",
        type: "assets/images/settings.png",
        pregress: "0"),
  ];
  final primaryColor = Color(0xFF3D6FE3);

  void deconnexion() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }

      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }

      // final GitHubSignIn gitHubSignIn = GitHubSignIn(
      //   clientId: 'YOUR_GITHUB_CLIENT_ID',
      //   clientSecret: 'YOUR_GITHUB_CLIENT_SECRET',
      //   redirectUrl: 'YOUR_GITHUB_REDIRECT_URL',
      // );
      //
      // if (await gitHubSignIn.isSignedIn) {
      //   await gitHubSignIn.signOut();
      // }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      print("erreur de déconnexion: $e");
    }
  }

  Future<String?> _getCurrentUserEmail() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              accountName: Text(
                "Baudelaire Gboyou",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3D6FE3)),
              ),
              accountEmail: FutureBuilder(
                future: _getCurrentUserEmail(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data ?? 'Aucun utilisateur connecté',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700),
                    );
                  }
                },
              ),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    "assets/images/avatar.png",
                  )),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/star.png",
                height: 20,
              ),
              title: Text(
                "Today",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/calendar.png",
                height: 20,
              ),
              title: Text(
                "Upcomming",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/coming.png",
                height: 20,
              ),
              title: Text(
                "Anytime",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/inbox.png",
                height: 20,
              ),
              title: Text(
                "Someday",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/delete.png",
                height: 20,
              ),
              title: Text(
                "Trash",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                "assets/images/cogwheel.png",
                height: 20,
              ),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/user.png",
                height: 20,
              ),
              title: Text(
                "Profil",
                style: TextStyle(fontSize: 15),
              ),
              selectedColor: Color(primaryColor.value),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profil()));
              },
            ),
            SizedBox(
              height: 35,
            ),
            ListTile(
              leading: Image.asset(
                "assets/images/logout.png",
                height: 20,
              ),
              title: Text(
                "Sign out",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              selectedColor: Color(primaryColor.value),
              onTap: () {
                deconnexion();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Builder(builder: (context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/menus.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/picplace.png",
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, there!",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade700),
                        ),
                        Text(
                          "Baudelaire Gboyou",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade700),
                        ),
                        Text(
                          "Good Morning!",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SearchBar(
                backgroundColor: MaterialStateProperty.all(Color(0x223D6FE3)),
                trailing: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF3D6FE3),
                    ),
                    onPressed: () {},
                  ),
                ],
                elevation: MaterialStateProperty.all(0.0),
                shape:
                    MaterialStateProperty.all(const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                )),
                hintText: 'Search',
                hintStyle: MaterialStateProperty.all(const TextStyle(
                    color: Color(0xFF3D6FE3), fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                shadowColor: Color(0x703D6FE3),
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Row(
                    children: [
                      Material(
                        elevation: 10,
                        shadowColor: Color(0xBB3D6FE3),
                        color: Color(0xFF3D6FE3),
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/add.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add a new task",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF3D6FE3)),
                            ),
                            Text(
                              "Create your new task",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: list.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Task(taskCard: e),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              shadowColor: Color(0x703D6FE3),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${e.nom}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                              Text(
                                                "${e.description}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        Colors.grey.shade600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                "${e.type}",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${(double.parse(e.pregress!) * 100).toString().split(".")[0]}% completed",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 12, 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            color: Color(0xFF3D6FE3),
                                            backgroundColor: Color(0xFFD2DEF9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            value: double.parse(e.pregress!),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        )),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
