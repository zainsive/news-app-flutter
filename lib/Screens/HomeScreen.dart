import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutor_side/Components/MainTab.dart';
import 'package:tutor_side/model/NewsPost.dart';
import '../Api/Constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Latest News",
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(isScrollable: true, labelColor: Colors.black87, tabs: [
            Tab(text: "Technology"),
            Tab(text: "Sports"),
            Tab(text: "Politics"),
            Tab(text: "Crypto"),
          ]),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: TabBarView(children: [
          MainTab("Technology"),
          MainTab("Sports"),
          MainTab("Politics"),
          MainTab("Crypto"),
        ]),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
