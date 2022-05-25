import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Constants {
  static String SIGNUP_URL = "http://10.0.2.2:5000/signup";
  static String SIGNIN_URL = "http://10.0.2.2:5000/signin";
  static String POSTS_URL = "http://10.0.2.2:5000/posts";
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return 'Enter Email Address';
    } else {
      return null;
    }
  }

  static Future postApi(String URL, var body, BuildContext context) async {
    var response = await http.post(Uri.parse(URL), body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future getApi(String URL) async {
    var response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
