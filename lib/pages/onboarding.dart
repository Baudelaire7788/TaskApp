import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskapp/pages/home.dart';

import 'login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: 300,
            ),
            SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3D6FE3)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/welcome.png',
              title: "Welcome to TaskApp",
              subtitle: "Discover a new, efficient way to organize your daily life. Simplify your task management with our user-friendly, intuitive application.",
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/fonctionnalite.png',
              title: "Powerful features",
              subtitle: "Optimize your productivity with advanced features such as task categorization, customizable reminders and team collaboration.",
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/personalisation.jpg',
              title: "Adapt the Application to Your Lifestyle",
              subtitle: "Customize the experience to suit your preferences. Choose from a variety of themes, organize your tasks according to your priorities and customize the interface to fit perfectly with your daily routine.",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  foregroundColor: Color(0xFF3d6fe3),
                  backgroundColor: Colors.white,
                  minimumSize: Size.fromHeight(80)),
              onPressed: () async {
                //Pour naviguer directement vers la page d'accueil
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                textAlign: TextAlign.center,
                "GET STARTED",
              ))
          : Container(
              height: 80,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text("SKIP")),
                  Center(
                    child: SmoothPageIndicator(
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black12,
                          dotHeight: 5,
                          dotWidth: 5,
                          activeDotColor: Color(0xFF3d6fe3)),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text("NEXT")),
                ],
              ),
            ),
    );
  }
}
