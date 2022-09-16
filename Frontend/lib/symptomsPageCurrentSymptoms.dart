// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SymptomsPageCurrentSymptoms extends StatefulWidget {
  const SymptomsPageCurrentSymptoms({Key? key}) : super(key: key);
  @override
  State<SymptomsPageCurrentSymptoms> createState() => _MyAppState();
}

class _MyAppState extends State<SymptomsPageCurrentSymptoms> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dOBController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController medHisController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: const Text("My Neighbourhood Doctors Register"),
          ),
          body: SingleChildScrollView(
            controller: AdjustableScrollController(100),
            child: Container(
              child: Form(
                key: _formKey,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: SizedBox(
                                width: 300.0, // <-- match_parent
                                height: 50.0, // <-- match-parent
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(
                                        255, 221, 150, 17), // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  child: const Text(
                                    'Current Symptoms',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: SizedBox(
                                width: 300.0, // <-- match_parent
                                height: 50.0, // <-- match-parent
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(
                                        255, 144, 119, 151), // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  child: const Text(
                                    'Add Symptoms',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
