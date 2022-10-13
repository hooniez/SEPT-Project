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

  late String _firstname = "";
  late String _lastname = "";
  late String _email = "";
  late String _dob = "";
  late String _mobile = "";
  late String _medhist = "";
  late String _password = "";
  late String _userType = "";
  late String _cert = "";
  late String _token = "";
  late String _passworddupe = _password;


  // @override
  // void initState() {
  //   _firstname = widget.user.value['firstname'];
  //   _lastname = widget.user.value['lastname'];
  //   _email = widget.user.value['email'];
  //   _dob = widget.user.value['dob'];
  //   _mobile = widget.user.value['mobilenumber'];
  //   _medhist = widget.user.value['medicalhistory'];
  //   _password = widget.user.value['password'];
  //   _userType = widget.user.value['usertype'];
  //   _cert = widget.user.value['certificate'];
  //   _token = widget.user.value['Authorization'];
  // }
  @override
  void initState() {
    print("state started");
    Future futureData = getUserData(widget.user);
    futureData.then((value) {
      print("value is" + json.decode(value)['firstname']);
      _firstname = json.decode(value)['firstname'];
      _lastname = json.decode(value)['lastname'];
      _password = json.decode(value)['password'];
      _passworddupe = _password;
      _email = json.decode(value)['email'];
      _dob = json.decode(value)['dob'];
      _mobile = json.decode(value)['mobilenumber'];
      _medhist = json.decode(value)['medicalhistory'];
      _userType = json.decode(value)['usertype'];
      _cert = json.decode(value)['certificate'];
      _token = widget.user.value['Authorization'];
      textControllers['firstname']!.text = _firstname;
      textControllers['lastname']!.text = _lastname;
      textControllers['password']!.text = "";
      textControllers['confirmPassword']!.text = "";
      textControllers['email']!.text = _email;
      textControllers['dob']!.text = _dob;
      textControllers['mobile']!.text = _mobile;
      textControllers['medhist']!.text = _medhist;
      textControllers['usertype']!.text = _userType;
      textControllers['certificate']!.text = _cert;
    });
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

  Map<String, EdgeInsetsGeometry> textInset = {
    'firstname': const EdgeInsets.fromLTRB(30, 4, 4, 4),
    'lastname': const EdgeInsets.fromLTRB(31, 4, 4, 4),
    'password': const EdgeInsets.fromLTRB(70, 4, 4, 4),
    'confirmPassword': const EdgeInsets.fromLTRB(10, 4, 4, 4),
    'email': const EdgeInsets.fromLTRB(69, 4, 4, 4),
    'dob': const EdgeInsets.fromLTRB(17, 4, 4, 4),
    'mobile': const EdgeInsets.fromLTRB(31, 4, 4, 4),
    'medhist': const EdgeInsets.fromLTRB(30, 4, 4, 4),
    'certificate': const EdgeInsets.fromLTRB(30, 4, 4, 4),
  };


  // Variables
  bool enabledStatus = false;
  Color textBoxSelectedColor = Color.fromRGBO(201, 217, 214, 1);
  Color textBoxNotSelectedColor = Color.fromRGBO(224, 224, 224, 1);
  Color textBoxBackgrounds = Color.fromRGBO(224, 224, 224, 1);

  final double editButtonPadding = 4.0;
  Color itemColor = Colors.black;
  double itemTitleFontSize = 16;
  double itemFontSize = 18;
  double textBoxWidth = 200;
  int passwordMaxLength = 255;
  int passwordMinLength = 7;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Email',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['email']!,
                        child: Container(
                          width: textBoxWidth,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'First Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['firstname']!,
                        child: Container(
                          width: textBoxWidth,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Last Name',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['lastname']!,
                        child: Container(
                          width: textBoxWidth,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Date Of Birth',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['dob']!,
                        child: Container(
                          width: textBoxWidth,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Mobile No.',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['mobile']!,
                        child: Container(
                          width: textBoxWidth,
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
                        padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
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
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['password']!,
                        child: Container(
                          width: textBoxWidth,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['password'],
                            obscureText: true,
                            enabled: enabledStatus,
                              validator: (value) {
                                if (value == null ||
                                    value.length < passwordMinLength ||
                                    value.length > passwordMaxLength) {
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileLabel(text:'Confirm password',itemColor: itemColor, itemTitleFontSize:itemTitleFontSize),
                      Padding(
                        padding: textInset['confirmPassword']!,
                        child: Container(
                          width: textBoxWidth,
                          color: textBoxBackgrounds,
                          child: TextFormField(
                            controller: textControllers['confirmPassword'],
                            obscureText: true,
                            enabled: enabledStatus,
                              validator: (value) {
                                if (value == null ||
                                    value.length < passwordMinLength ||
                                    value.length > passwordMaxLength ||
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
                            ? const Icon(Icons.save_outlined)
                            : const Icon(Icons.create_outlined),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                                enabledStatus = !enabledStatus;
                                if (enabledStatus) {
                                  textBoxBackgrounds = textBoxSelectedColor;
                                  // do nothing
                                } else {
                                  textBoxBackgrounds = textBoxNotSelectedColor;
                                  print("Has the token," +_token.toString());
                                  if (_formKey.currentState!.validate()) {
                                    Future response = putPatientData(
                                        textControllers, _userType, _token);
                                  } else {
                                    print("The duplicated password is: "+_passworddupe.toString());
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
    print(textControlDict['password']!.text);
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
    print("success response");
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
        padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
        child: Text(
          text,
          style: TextStyle(
              color: itemColor, fontSize: itemTitleFontSize),
        ),
      );
  }
}

Future<String> getUserData(user) async {
  // construct the request
  String uri = "http://10.0.2.2:8091/";
  String typeUri = "doctor/profile/";
  if(user.value['usertype']=='patient') {
    typeUri = "patient/profile/";
  }
  uri = uri + typeUri + user.value["uid"].toString();
  final url = Uri.parse(uri);
  print(user.value["password"]);
  print(url);
  final Response response = await get(url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': user.value["Authorization"]
      });
  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return response.body;
  } else {
    print(response.statusCode);
    throw Exception("Error getting profile data");
  }
}