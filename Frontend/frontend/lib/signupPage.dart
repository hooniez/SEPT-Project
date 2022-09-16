// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _MyAppState();
}

class _MyAppState extends State<SignupPage> {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 6),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 36.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length > 255) {
                                    return 'Please enter a valid first name';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length > 255) {
                                    return 'Please enter a valid last name';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                  controller: dOBController,
                                  decoration: InputDecoration(
                                    labelText: "Date of Birth",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2023));

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);

                                      setState(() {
                                        dOBController.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  })),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
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
                              controller: mobileNumController,
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
                              controller: medHisController,
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
                              controller: passwordController,
                              obscureText: true,
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
                              controller: passwordConfirmController,
                              obscureText: true,
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
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SizedBox(
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
                                onPressed: () async {
                                  var res = await createPatient(
                                    firstNameController.text,
                                    lastNameController.text,
                                    emailController.text,
                                    dOBController.text,
                                    passwordController.text,
                                    mobileNumController.text,
                                    medHisController.text,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}

// postTest(String firstName,
//     String lastName,
//     String email,
//     String dOB,
//     String password,
//     String mobileNumber,
//     String medicalHistory) async {
//     const uri = 'localhost:8080/signup';

//     http.Response response = await http.post(
//         Uri.parse(uri), headers: <String, String>{ },
//         body: jsonEncode(<String, String>{
//       'FirstName': firstName,
//       'LastName': lastName,
//       'Email': email,
//       'DOB': dOB,
//       'Password': password,
//       'MobileNumber': mobileNumber,
//       'MedicalHistory': medicalHistory,
//     }),);

//     print(response.body);
//   }

Future<Response> createPatient(
    String firstName,
    String lastName,
    String email,
    String dOB,
    String password,
    String mobileNumber,
    String medicalHistory) async {
  final url = Uri.parse("http://localhost:8080/signup");
  Response res = await put(
    url,
    headers: {
      'Accept': 'application/json',
      'content-type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'dob': dOB,
      'password': password,
      'mobilenumber': mobileNumber,
      'medicalhistory': medicalHistory,
    }),
  );
  return res;
}
