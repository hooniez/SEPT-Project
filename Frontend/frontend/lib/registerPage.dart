// ignore_for_file: sort_child_properties_last

import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _MyAppState();
}

class _MyAppState extends State<RegisterPage> {
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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("My Neighbourhood Doctors Register"),
        ),
        body: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Register',
                            style:
                                TextStyle(color: Colors.white, fontSize: 50.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
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
                            controller: firstNameController,
                            decoration: InputDecoration(
                              labelText: "Second Name",
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
                              labelText: "Date of Birth",
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
                              labelText: "Mobile Number",
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
                              labelText: "Date of Birth",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Second Column in row
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 85, 8, 8),
                          child: TextFormField(
                            maxLines: 6,
                            decoration: InputDecoration(
                              labelText: "Medical History",
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
                              labelText: "Password",
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
                              labelText: "Confirm Password",
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300.0, // <-- match_parent
                          height: 50.0, // <-- match-parent
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Future res = createPatient(
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text,
                                dOBController.text,
                                passwordController.text,
                                mobileNumController.text,
                                medHisController.text,
                              );
                              print(res);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.all(15),
            color: Color.fromARGB(255, 78, 78, 78),
            width: 1000,
            height: 700,
          ),
        ),
      ),
    );
  }
}

Future<http.Response> createPatient(
    String firstName,
    String lastName,
    String email,
    String dOB,
    String password,
    String mobileNumber,
    String medicalHistory) {
  return http.put(
    Uri.parse('http://localhost:8080/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'DOB': dOB,
      'Password': password,
      'MobileNumber': mobileNumber,
      'MedicalHistory': medicalHistory,
    }),
  );
}
