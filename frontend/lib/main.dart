// ignore_for_file: sort_child_properties_last
import 'dart:html';
import 'package:signup/manageusers.dart';

import 'superuserhero.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(),
      routes: <String, WidgetBuilder>{
        '/manageDoctors': (BuildContext context) => ManageUsers(
            users: {0:"Lamshed", 1:"Sun", 2:"Foord", 3:"Shi", 4:"Van"},
            userType: "Doctor"),
        "/managePatients": (BuildContext context) => ManageUsers(
            users: {5:"CAL", 6:"MH", 7:"MAX", 8:"YJ", 9:"LACHIE"},
            userType: "Patient"),
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SuperUserHero();

  }
}
