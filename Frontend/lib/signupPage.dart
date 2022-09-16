// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'package:http/http.dart';

enum UserType {doctor, patient}

class SignupPage extends StatefulWidget {
  final Function setUser;
  const SignupPage({Key? key, required this.setUser}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserType? _userType = UserType.patient;

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController dOBController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNumController = TextEditingController();

  TextEditingController customController = TextEditingController();

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
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24,
                                horizontal: 6),
                            child: Text(
                              'Register',
                              style:
                              TextStyle(color: Colors.black, fontSize: 36.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Radio<UserType>(
                                    value: UserType.patient,
                                    groupValue: _userType,
                                    onChanged: (UserType? value) {
                                      setState(() {
                                        _userType = value;
                                      });
                                    },
                                  ),
                                  const Text("Patient"),
                                ]
                              ),
                              Row(
                                  children: [
                                    Radio<UserType>(
                                      value: UserType.doctor,
                                      groupValue: _userType,
                                      onChanged: (UserType? value) {
                                        setState(() {
                                          _userType = value;
                                        });
                                      },
                                    ),
                                    const Text("Doctor"),
                                  ]
                              ),
                            ],
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
                              controller: lastNameController,
                              decoration: InputDecoration(
                                labelText: "Last Name",
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
                              controller: dOBController,
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
                          _userType == UserType.patient ?
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: customController,
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
                          ) :
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: customController,
                              maxLines: 6,
                              decoration: InputDecoration(
                                labelText: "Doctor Certificates",
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
                                onPressed:  () async {
                                    var res = await createUser(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      dOBController.text,
                                      passwordController.text,
                                      mobileNumController.text,
                                      customController.text,
                                      _userType!,
                                    );
                                    if (res.body.isNotEmpty) {
                                      widget.setUser(res.body);
                                      Navigator.pushNamed(context, '/profile');
                                    } else {
                                      print("empty");
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

Future<Response> createUser(
    String firstName,
    String lastName,
    String email,
    String dOB,
    String password,
    String mobileNumber,
    String customInfo,
    UserType userType) async {

  String API_HOST = "http://10.0.2.2:8080";
  String type = userType.toString().split('.').last;
  final url = Uri.parse(API_HOST + "/" + type + "/signup");
  print(url);
  String body;
  if (type == 'patient') {
    body = jsonEncode(<String, String> {
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
    body = jsonEncode(<String, String> {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'dob': dOB,
      'password': password,
      'mobilenumber': mobileNumber,
      'certificate': customInfo,
    });
  }

  Response res = await put(url,
    headers: {
      'Accept': 'application/json',
      'content-type': 'application/json',
    },
    body: body
  );
  return res;


}
