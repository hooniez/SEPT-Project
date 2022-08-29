// ignore_for_file: sort_child_properties_last

import 'dart:html';

import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  State<PatientProfile> createState() => _MyAppState();
}

class _MyAppState extends State<PatientProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Neighbourhood Doctors Patient Profile"),
        ),
        body: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Patient Profile',
                          style: TextStyle(color: Colors.white, fontSize: 28.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'First Name',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: 300.0, // <-- match_parent
                                  height: 50.0, // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: const Text('Edit'),
                                    onPressed: () {
                                      print('Edit');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Last Name',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: 300.0, // <-- match_parent
                                  height: 50.0, // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: const Text('Edit'),
                                    onPressed: () {
                                      print('Edit');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: 300.0, // <-- match_parent
                                  height: 50.0, // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: const Text('Edit'),
                                    onPressed: () {
                                      print('Edit');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Date Of Birth",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 300.0, // <-- match_parent
                            height: 50.0, // <-- match-parent
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              child: const Text('Login'),
                              onPressed: () {
                                print('Hello');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.all(15),
            color: Color.fromARGB(255, 113, 113, 113),
            width: 1000,
            height: 500,
          ),
        ),
      ),
    );
  }
}


      // 'FirstName': firstName,
      // 'LastName': lastName,
      // 'Email': email,
      // 'DOB': dOB,
      // 'Password': password,
      // 'MobileNumber': mobileNumber,
      // 'MedicalHistory': medicalHistory,