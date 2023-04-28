import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 18,
    );
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              width: MediaQuery.of(context).size.width,
              "assets/images/lilpap.jpeg",
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: kElementColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hey what's up? I'm",
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Lil Pap",
                    style: TextStyle(
                      fontFamily: GoogleFonts.leckerliOne().fontFamily,
                      fontSize: 40,
                      color: kPrimaryColor,
                      shadows: const [
                        BoxShadow(
                          color: kPrimaryColor,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "a producer with a passion for making dope beats. I'm always on the lookout for new artists to collaborate with, so let's link up and create something amazing!",
                    textAlign: TextAlign.center,
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 5,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Get in touch and let's cook up something hot!",
                    textAlign: TextAlign.center,
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(
                              Uri.parse(
                                "https://www.beatstars.com/prodbylilpap",
                              ),
                            )) {
                              throw Exception('Could not launch url');
                            }
                          },
                          child: Image.asset(
                            "assets/icons/beatstars.png",
                            width: 25,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(
                              Uri.parse(
                                "https://www.instagram.com/nektarios.pap/",
                              ),
                            )) {
                              throw Exception('Could not launch url');
                            }
                          },
                          child: Image.asset(
                            "assets/icons/instagram.png",
                            width: 30,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(
                              Uri.parse(
                                "https://www.facebook.com/profile.php?id=100023852265770",
                              ),
                            )) {
                              throw Exception('Could not launch url');
                            }
                          },
                          child: Image.asset(
                            "assets/icons/facebook.png",
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: const [
                          BoxShadow(
                            color: kPrimaryColor,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Take A Look",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
