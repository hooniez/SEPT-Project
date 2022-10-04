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
    'password': TextEditingController(text: _password),
    'email': TextEditingController(text: _email),
    'dob': TextEditingController(text: _dob),
    'mobile': TextEditingController(text: _mobile),
    'medhist': TextEditingController(text: _medhist),
    'certificate': TextEditingController(text: _cert)
  };

  Map<String, bool> enabledFlags = {
    'firstname': false,
    'lastname': false,
    'password': false,
    'email': false,
    'dob': false,
    'mobile': false,
    'medhist': false
  };

  Color textBoxSelectedColor = Color.fromRGBO(201, 217, 214, 1);
  Color textBoxNotSelectedColor = Color.fromRGBO(224, 224, 224, 1);
  late Map<String, Color> textBoxBackgrounds = {
    'firstname': textBoxNotSelectedColor,
    'lastname': textBoxNotSelectedColor,
    'email': textBoxNotSelectedColor,
    'dob': textBoxNotSelectedColor,
    'mobile': textBoxNotSelectedColor,
    'medhist': textBoxNotSelectedColor,
    'password': textBoxNotSelectedColor
  };

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
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Email:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['email'],
                          child: TextField(
                            controller: textControllers['email'],
                            enabled: enabledFlags['email'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'First Name:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['firstname'],
                          child: TextField(
                            controller: textControllers['firstname'],
                            enabled: enabledFlags['firstname'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['firstname']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['firstname'] =
                                    !(enabledFlags['firstname']!);
                                if (enabledFlags['firstname'] == true) {
                                  textBoxBackgrounds['firstname'] =
                                      textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds['firstname'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Last Name:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['lastname'],
                          child: TextField(
                            controller: textControllers['lastname'],
                            enabled: enabledFlags['lastname'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['lastname']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['lastname'] =
                                    !(enabledFlags['lastname']!);
                                if (enabledFlags['lastname'] == true) {
                                  textBoxBackgrounds['lastname'] =
                                      textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds['lastname'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Date of Birth:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['dob'],
                          child: TextField(
                              controller: textControllers['dob'],
                              enabled: enabledFlags['dob'],
                              onTap: () async {
                                if (enabledFlags['dob'] == true) {
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
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['dob']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['dob'] = !(enabledFlags['dob']!);
                                if (enabledFlags['dob'] == true) {
                                  textBoxBackgrounds['dob'] =
                                      textBoxSelectedColor;
                                } else {
                                  textBoxBackgrounds['dob'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Mobile No:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['mobile'],
                          child: TextField(
                            controller: textControllers['mobile'],
                            enabled: enabledFlags['mobile'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['mobile']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['mobile'] =
                                    !(enabledFlags['mobile']!);
                                if (enabledFlags['mobile'] == true) {
                                  textBoxBackgrounds['mobile'] =
                                      textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds['mobile'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
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
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['medhist']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['medhist'] =
                                    !(enabledFlags['medhist']!);
                                if (enabledFlags['medhist'] == true) {
                                  textBoxBackgrounds['medhist'] =
                                      textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds['medhist'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        width: double.infinity,
                        color: textBoxBackgrounds['medhist'],
                        child: _userType == "doctor"
                            ? TextField(
                                maxLines: 7,
                                controller: textControllers['certificate'],
                                enabled: enabledFlags['medhist'],
                              )
                            : TextField(
                                maxLines: 7,
                                controller: textControllers['medhist'],
                                enabled: enabledFlags['medhist'],
                              )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Password:',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 150,
                          color: textBoxBackgrounds['password'],
                          child: TextField(
                            controller: textControllers['password'],
                            enabled: enabledFlags['password'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editButtonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: enabledFlags['password']!
                                ? Icon(Icons.save_outlined)
                                : Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['password'] =
                                    !(enabledFlags['password']!);
                                if (enabledFlags['password'] == true) {
                                  textBoxBackgrounds['password'] =
                                      textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds['password'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(
                                      textControllers, _userType, _token);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
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
    final parsed = json.decode(response.body);
    print(parsed);
    return parsed;
  } else {
    print(response.headers);
  }
  return response;
}
