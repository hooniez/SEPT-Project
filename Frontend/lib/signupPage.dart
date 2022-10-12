// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

enum UserType { doctor, patient }

class SignupPage extends StatefulWidget {
  final Function setUserWithoutToken;
  final bool forDoctor;
  const SignupPage({Key? key, required this.setUserWithoutToken, this
      .forDoctor=false})
      : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserType? _userType;
  @override
  // SignupPage has two fronts: one for doctor and the other for patient
  void initState() {
    _userType = widget.forDoctor ? UserType.doctor : UserType.patient;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController dOBController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNumController = TextEditingController();

  TextEditingController customController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: Center(child: const Text("Neighbourhood Doctors")),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))),
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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 6),
                            child:
                            widget.forDoctor ?
                            const Text(
                              'Register a Doctor',
                              style: TextStyle(color: Colors.black, fontSize:
                              30.0)
                            ) :
                            Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 30.0),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
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
                                  prefixIcon: Icon(Icons.person),
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
                              child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: dOBController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_month),
                                    labelText: "Date of Birth",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  readOnly: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid DOB';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now());
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);

                                      setState(() {
                                        dOBController.text = formattedDate;
                                      });
                                    } else {}
                                  })),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
                                  labelText: "Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length > 255 ||
                                      !EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: mobileNumController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android),
                                  labelText: "Mobile Number",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.length < 10 ||
                                      value.length > 10 ||
                                      !isNumeric(value)) {
                                    return 'Please enter a valid Australian number (10 digits)';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          _userType == UserType.patient
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: customController,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.medical_information),
                                        labelText: "Medical History",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length > 255) {
                                          return 'Please enter medical history';
                                        } else {
                                          return null;
                                        }
                                      }),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                      controller: customController,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.newspaper),
                                        labelText: "Doctor Certificates",
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length > 255) {
                                          return 'Please enter doctor certificates';
                                        } else {
                                          return null;
                                        }
                                      }),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 7 ||
                                      value.length > 255) {
                                    return 'Please enter a valid password of at least length 7';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: passwordConfirmController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: "Confirm Password",
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 7 ||
                                      value.length > 255 ||
                                      value != passwordController.text) {
                                    return 'This password does not match with the inputted password';
                                  } else {
                                    return null;
                                  }
                                }),
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
                                  final isValidForm =
                                      _formKey.currentState!.validate();
                                  if (isValidForm) {
                                    String type = _userType
                                        .toString()
                                        .split(''
                                            '.')
                                        .last;
                                    var res = await createUser(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      dOBController.text,
                                      passwordController.text,
                                      mobileNumController.text,
                                      customController.text,
                                      type,
                                    );
                                    if (res.statusCode == 202) {
                                      // widget.setUserWithoutToken(
                                      //     res.body, type);
                                      Navigator.pushNamed(
                                          context, '/frontPage');
                                    } else {
                                      print("empty");
                                    }
                                  }
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

Future<Response> createUser(
    String firstName,
    String lastName,
    String email,
    String dOB,
    String password,
    String mobileNumber,
    String customInfo,
    String type) async {
  String API_HOST = "http://10.0.2.2:8080";

  final url = Uri.parse(API_HOST + "/" + type + "/signup");
  print(url);
  String body;
  if (type == 'patient') {
    body = jsonEncode(<String, String>{
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'dob': dOB,
      'password': password,
      'mobilenumber': mobileNumber,
      'medicalhistory': customInfo,
    });
  } else {
    // type == 'doctor'
    body = jsonEncode(<String, String>{
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'dob': dOB,
      'password': password,
      'mobilenumber': mobileNumber,
      'certificate': customInfo,
    });
  }

  Response res = await post(url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
      body: body);
  return res;
}
