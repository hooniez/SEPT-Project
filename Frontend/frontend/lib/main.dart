import 'dart:html';

import 'frontPage.dart';
import 'package:flutter/material.dart';
import 'patientProfile.dart';
import 'registerPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naviation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const PatientProfile(),
      home: const PatientProfile(),
    );
  }
}
