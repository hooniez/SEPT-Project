// ignore_for_file: sort_child_properties_last

// import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class PatientProfile extends StatefulWidget {
  final user;
  const PatientProfile({Key? key, this.user}) : super(key: key);
  @override
  State<PatientProfile> createState() => _MyAppState();
}

class _MyAppState extends State<PatientProfile> {
  late String _firstname;
  late String _lastname;
  late String _email;
  late String _dob;
  late String _mobile;
  late String _medhist;
  late String _password;
  late String _userType;
  late String _cert;
  late String _token;
  late String _passworddupe = _password;
  @override
  void initState() {
    _firstname = widget.user.value['firstname'];
    _lastname = widget.user.value['lastname'];
    _email = widget.user.value['email'];
    _dob = widget.user.value['dob'];
    _mobile = widget.user.value['mobilenumber'];
    _medhist = widget.user.value['medicalhistory'];
    _password = widget.user.value['password'];
    _userType = widget.user.value['usertype'];
    _cert = widget.user.value['certificate'];
    _token = widget.user.value['Authorization'];
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, double> editButtonDetails = {
    'width': 60.0,
    'height': 25.0,
    'fontSize': 12
  };

  late Map<String, TextEditingController> textControllers = {
    'firstname': TextEditingController(text: _firstname),
    'lastname': TextEditingController(text: _lastname),
    'password': TextEditingController(text: ''),
    'confirmPassword': TextEditingController(text: ''),
    'email': TextEditingController(text: _email),
    'dob': TextEditingController(text: _dob),
    'mobile': TextEditingController(text: _mobile),
    'medhist': TextEditingController(text: _medhist),
    'certificate': TextEditingController(text: _cert)
  };

  bool enabledStatus = false;
  Color textBoxSelectedColor = Color.fromRGBO(201, 217, 214, 1);
  Color textBoxNotSelectedColor = Color.fromRGBO(224, 224, 224, 1);
  Color textBoxBackgrounds = Color.fromRGBO(224, 224, 224, 1);

  final double editButtonPadding = 4.0;
  Color itemColor = Colors.black;
  double itemTitleFontSize = 16;
  double itemFontSize = 18;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: const Text("Profile"),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Email',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxNotSelectedColor,
                          child: TextFormField(
                            controller: textControllers['email'],
                            enabled: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'First Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['firstname'],
                            enabled: enabledStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Last Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['lastname'],
                            enabled: enabledStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Date Of Birth',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                              controller: textControllers['dob'],
                              enabled: enabledStatus,
                              onTap: () async {
                                if (enabledStatus) {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());
                                  if (pickedDate != null) {
                                    String newDOB = DateFormat('dd-MM-yyyy')
                                        .format(pickedDate);
                                    setState(() {
                                      textControllers["dob"] =
                                          TextEditingController(text: newDOB);
                                    });
                                  }
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Mobile No.',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['mobile'],
                            enabled: enabledStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: _userType == "doctor"
                            ? Text(
                                'Doctor Certificates',
                                style: TextStyle(
                                    color: itemColor,
                                    fontSize: itemTitleFontSize),
                              )
                            : Text(
                                'Medical History',
                                style: TextStyle(
                                    color: itemColor,
                                    fontSize: itemTitleFontSize),
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        width: double.infinity,
                        color: textBoxBackgrounds,
                        child: _userType == "doctor"
                            ? TextFormField(
                                maxLines: 5,
                                controller: textControllers['certificate'],
                                enabled: enabledStatus,
                              )
                            : TextFormField(
                                maxLines: 5,
                                controller: textControllers['medhist'],
                                enabled: enabledStatus,
                              )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['password'],
                            obscureText: true,
                            enabled: enabledStatus,
                              validator: (value) {
                                if (value == null ||
                                    value.length < 7 ||
                                    value.length > 255) {
                                  return 'This password does not match with the inputted password';
                                } else {
                                  return null;
                                }
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileLabel(text:'Confirm password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['confirmPassword'],
                            obscureText: true,
                            enabled: enabledStatus,
                              validator: (value) {
                                if (value == null ||
                                    value.length < 7 ||
                                    value.length > 255 ||
                                    value != textControllers['password']!.text) {
                                  return 'Passwords do not match';
                                } else {
                                  return null;
                                }
                              }
                          ),
                        ),
                      ),
                    ],
                  ),Padding(
                    padding: EdgeInsets.all(editButtonPadding),
                    child: SizedBox(
                      width: editButtonDetails['width'], // <-- match_parent
                      height:
                      editButtonDetails['height'], // <-- match-parent
                      child: IconButton(
                        icon: enabledStatus
                            ? Icon(Icons.save_outlined)
                            : Icon(Icons.create_outlined),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                                enabledStatus = !enabledStatus;
                                if (enabledStatus) {
                                  textBoxBackgrounds = textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds = textBoxNotSelectedColor;
                                  if (_formKey.currentState!.validate()) {
                                    print('valid');
                                    Future response = putPatientData(
                                        textControllers, _userType, _token);
                                  } else {
                                    print('invalid');
                                    textControllers['password']!.text =
                                        _passworddupe;
                                    Future response = putPatientData(
                                        textControllers, _userType, _token);
                                    textControllers['password']!.text = '';
                                    textControllers['password']!.text = textControllers['password']!.text;
                                  }
                                }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

Future<Response> putPatientData(
    Map<String, TextEditingController> textControlDict, userType, token) async {
  Response response;

  print(textControlDict['password']!.text);
  if (userType == "doctor") {
    String uri = "http://10.0.2.2:8091/doctor/profile";
    final url = Uri.parse(uri);
    response = await put(url,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(<String, String>{
          'firstname': textControlDict['firstname']!.text,
          'lastname': textControlDict['lastname']!.text,
          'email': textControlDict['email']!.text,
          'dob': textControlDict['dob']!.text,
          'password': textControlDict['password']!.text,
          'mobilenumber': textControlDict['mobile']!.text,
          'certificate': textControlDict['certificate']!.text,
        }));
  } else {
    String uri = "http://10.0.2.2:8091/patient/profile";
    final url = Uri.parse(uri);
    response = await put(url,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': token
        },
        body: jsonEncode(<String, String>{
          'firstname': textControlDict['firstname']!.text,
          'lastname': textControlDict['lastname']!.text,
          'email': textControlDict['email']!.text,
          'dob': textControlDict['dob']!.text,
          'password': textControlDict['password']!.text,
          'mobilenumber': textControlDict['mobile']!.text,
          'medicalhistory': textControlDict['medhist']!.text,
        }));
  }

  if (response.statusCode == 200 || response.statusCode == 202) {
    return response;
  } else {
    print(response.headers);
  }
  return response;
}

class ProfileLabel extends StatelessWidget {

  ProfileLabel({this.text = '',this.itemColor=Colors.black, this.itemTitleFontSize=12});

  final String text;
  final Color itemColor;
  final double itemTitleFontSize;
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(
              color: itemColor, fontSize: itemTitleFontSize),
        ),
      );
  }
}