import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mini_pr/auth/signup_screen.dart';
import 'package:mini_pr/config_size.dart';
import 'package:mini_pr/controller/auth_controller.dart';
import 'package:mini_pr/pages/home_screen.dart';
import 'package:mini_pr/pages/intro_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Contants.scaffoldPColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: height / 2,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset("assets/img/login_svg.svg"),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21),
                  child: Text(
                    "Sign In to your account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 247, 248, 250)),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xff0063F5))),
                      hintText: 'Enter Email',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xff0063F5))),
                      hintText: 'Enter password',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                //button
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: InkWell(
                      onTap: () {
                        AuthenticationHelper()
                            .signIn(
                                email: emailController.text,
                                password: passController.text)
                            .then((value) {
                          if (value == null) {
                            Get.to(() => IntroScreen(),
                                transition: Transition.zoom);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Invalid email or password')));
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xff0063F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Center(
                    child: Row(
                      children: [
                        const Text(
                          "don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.off(
                              () => SignUpScreen(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 420),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          child: const Text(
                            "create account",
                            style: TextStyle(
                              color: Color(0xff0063F5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
