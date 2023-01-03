import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_app/themes/ThemeService.dart';

import '../router/routes.dart';

List<String> images = [
  "assets/images/onboarding4.jpg",
  "assets/images/onboarding5.jpg",
  "assets/images/onboarding6.jpg"
];
List<String> quotes = [
  "We provide high quality products just for you",
  "Your satisfaction is our number one priority",
  "Let's fulfill your fashion needs with 2K right now!"
];
List<String> status = ["Next", "Next", "Get Started"];

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            controller: _controller,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(images[currentIndex],
                      height: size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 25),
                    child: Text(
                      quotes[currentIndex],
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                     
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Container(
                        height: 8,
                        width: index == currentIndex ? 35 : 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: index == currentIndex
                                ? Colors.black
                                : Color.fromARGB(255, 186, 185, 185)),
                      ),
                    )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              if (currentIndex < 2) {
                _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn);
              } else {
                Navigator.pushReplacementNamed(context, Routes.login);
              }
            },
            child: Container(
              height: 55,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),color: Colors.black,),
                  
              child: Center(
                  child: Text(status[currentIndex],
                      style: TextStyle(
                          color:Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ),
          ),
        )
      ],
    ));
  }
}
