import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_side/Screens/HomeScreen.dart';

import '../Api/Constants.dart';
import '../Components/CustomInputBox.dart';
import '../Components/SocialBtn.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  // user functions
  Future signInApi(email, password) async {
    var response = await Constants.postApi(
        Constants.SIGNIN_URL, {"email": email, "password": password}, context);
    print(response);
    var result = jsonDecode(response);
    if (result["success"]) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Invalid Email/Password.")),
      );
    }
  }

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
                        "SIGN IN",
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
                    height: 40,
                  ),

                  Column(
                    children: [
                      MyCustomInputBox(
                        title: 'Email',
                        hint: 'demo@test.com',
                        controller: emailController,
                      ),
                      //
                      SizedBox(
                        height: 10,
                      ),
                      //
                      MyCustomInputBox(
                        title: 'Password',
                        hint: 'Password',
                        controller: passwordController,
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
                            signInApi(
                                emailController.text, passwordController.text);
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
                              'Sign In',
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text(
                          "Sign Up",
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
