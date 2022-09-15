
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mini_pr/auth/login_screen.dart';
import 'package:mini_pr/config_size.dart';
import 'package:mini_pr/controller/google_auth_controller.dart';
import 'package:mini_pr/pages/home_screen.dart';
import 'package:mini_pr/pages/intro_screen.dart';

import '../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Contants.scaffoldPColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: height / 2.3,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset("assets/img/sign_up.svg"),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: Text(
                  "Create account!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 241, 243, 245)),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //1st textt from field
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
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
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
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
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Color(0xff0063F5))),
                          hintText: 'Confirm password',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //button
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: InkWell(
                          onTap: (() {
                            if (_formKey.currentState!.validate()) {
                              AuthenticationHelper()
                                  .signUp(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((result) {
                                if (result == null) {
                                  Get.to(() => IntroScreen(),
                                      transition: Transition.zoom);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')));
                                }
                              });
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xff0063F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
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
                  ],
                ),
              ),

              //2nd text form field

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Row(
                  children: [
                    Expanded(
                      child: const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(
                          () => LoginScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      child: const Text(
                        "Sign in ",
                        style: TextStyle(
                          color: Color(0xff0063F5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Authentication.signInWithGoogle(context: context)
                      .then((user) {
                    if (user != null) {
                      Get.to(() => IntroScreen());
                    }
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 21, top: 5),
                  child: Text(
                    "continue with google",
                    style: TextStyle(
                      color: Color(0xff0063F5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
