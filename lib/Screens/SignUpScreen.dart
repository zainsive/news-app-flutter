import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_side/Api/Constants.dart';

import '../Components/CustomInputBox.dart';
import '../Components/SocialBtn.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

// user functions
  Future signUpApi(email, password) async {
    var response = await Constants.postApi(
        Constants.SIGNUP_URL, {"email": email, "password": password}, context);
    var result = jsonDecode(response);
    if (result['success']) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red, content: Text("Unable to Process.")),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40.0, top: 90),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontFamily: 'Cardo',
                          fontSize: 35,
                          color: Color(0xff0C2551),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      //
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 20,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // //
                      MyCustomInputBox(
                        title: 'Email',
                        hint: 'demo@test.com',
                        controller: emailController,
                      ),
                      //
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      MyCustomInputBox(
                        title: 'Password',
                        hint: 'Password',
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //
                      MyCustomInputBox(
                        title: 'Confirm Password',
                        hint: 'Confirm Password',
                        controller: confirmPasswordController,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              signUpApi(emailController.text,
                                  passwordController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Password doesn't match.")),
                              );
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xff0962ff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style:
                              TextStyle(color: Color.fromARGB(255, 9, 99, 254)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialBtn(
                        socialSingleCharector: 'f',
                        color: Colors.blue[900],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SocialBtn(
                        socialSingleCharector: 'G',
                        color: Colors.red,
                      )
                    ],
                  ),
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
