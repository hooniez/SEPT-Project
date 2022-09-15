// ignore_for_file: sort_child_properties_last

// import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/scrollercontroller.dart';

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

  @override
  void initState() {
    _firstname = widget.user.value['firstname'];
    _lastname = widget.user.value['lastname'];
    _email = widget.user.value['email'];
    _dob = widget.user.value['dob'];
    _mobile = widget.user.value['mobilenumber'];
    _medhist = widget.user.value['medicalhistory'];
    _password = widget.user.value['password'];
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
    'password' : TextEditingController(text: _password),
    'email': TextEditingController(text: _email),
    'dob': TextEditingController(text: _dob),
    'mobile': TextEditingController(text: _mobile),
    'medhist':
        TextEditingController(text: _medhist)
  };

  String buttonTextEdit = 'Edit';
  String buttonTextSave = 'Save';
  Map<String, String> buttonText = {
    'firstname': 'Edit',
    'password' : 'Edit',
    'lastname': 'Edit',
    'email': 'Edit',
    'dob': 'Edit',
    'mobile': 'Edit',
    'medhist': 'Edit'
  };

  Map<String, bool> enabledFlags = {
    'firstname': false,
    'lastname': false,
    'password' : false,
    'email': false,
    'dob': false,
    'mobile': false,
    'medhist': false
  };

  MaterialColor textBoxSelectedColor = Colors.lightGreen;
  MaterialColor textBoxNotSelectedColor = Colors.grey;
  Map<String, MaterialColor> textBoxBackgrounds = {
    'firstname': Colors.grey,
    'lastname': Colors.grey,
    'email': Colors.grey,
    'dob': Colors.grey,
    'mobile': Colors.grey,
    'medhist': Colors.grey
  };

  final double editbuttonPadding = 4.0;
  Color itemColor = Colors.black;
  double itemTitleFontSize = 16;
  double itemFontSize = 18;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Patient Profile"),
        ),
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
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                              editButtonDetails['height'], // <-- match-parent
                            child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                print(_firstname);
                                print(_lastname);
                                enabledFlags['firstname'] =
                                    !(enabledFlags['firstname']!);
                                if (enabledFlags['firstname'] == true) {
                                  buttonText['firstname'] = buttonTextSave;
                                  textBoxBackgrounds['firstname'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['firstname'] = buttonTextEdit;
                                  textBoxBackgrounds['firstname'] =
                                      textBoxNotSelectedColor;
                                  // send the data.
                                  Future response = putPatientData(textControllers);
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
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                          editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['lastname'] =
                                !(enabledFlags['lastname']!);
                                if (enabledFlags['lastname'] == true) {
                                  buttonText['lastname'] = buttonTextSave;
                                  textBoxBackgrounds['lastname'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['lastname'] = buttonTextEdit;
                                  textBoxBackgrounds['lastname'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(textControllers);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),Row(
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
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                          editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['email'] =
                                !(enabledFlags['email']!);
                                if (enabledFlags['email'] == true) {
                                  buttonText['email'] = buttonTextSave;
                                  textBoxBackgrounds['email'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['email'] = buttonTextEdit;
                                  textBoxBackgrounds['email'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(textControllers);
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
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                          editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['dob'] =
                                !(enabledFlags['dob']!);
                                if (enabledFlags['dob'] == true) {
                                  buttonText['dob'] = buttonTextSave;
                                  textBoxBackgrounds['dob'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['dob'] = buttonTextEdit;
                                  textBoxBackgrounds['dob'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(textControllers);
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
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                          editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['mobile'] =
                                !(enabledFlags['mobile']!);
                                if (enabledFlags['mobile'] == true) {
                                  buttonText['mobile'] = buttonTextSave;
                                  textBoxBackgrounds['mobile'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['mobile'] = buttonTextEdit;
                                  textBoxBackgrounds['mobile'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(textControllers);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start  ,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Medical History',
                          style: TextStyle(
                              color: itemColor, fontSize: itemTitleFontSize),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(editbuttonPadding),
                        child: SizedBox(
                          width: editButtonDetails['width'], // <-- match_parent
                          height:
                          editButtonDetails['height'], // <-- match-parent
                          child: IconButton(
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() {
                                enabledFlags['medhist'] = !(enabledFlags['medhist']!);
                                if (enabledFlags['medhist'] == true) {
                                  buttonText['medhist'] = buttonTextSave;
                                  textBoxBackgrounds['medhist'] =
                                      textBoxSelectedColor;
                                } else {
                                  buttonText['medhist'] = buttonTextEdit;
                                  textBoxBackgrounds['medhist'] =
                                      textBoxNotSelectedColor;
                                  Future response = putPatientData(textControllers);
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
                      child: TextField(
                        maxLines: 7,
                        controller: textControllers['medhist'],
                        enabled: enabledFlags['medhist'],
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
Future<http.Response> putPatientData(
    Map<String, TextEditingController> textControlDict
    ) async {
  print("in put method");
  String email = textControlDict['email']!.text;
  String uri = "localhost:8080/patients/$email";
  final url = Uri.parse(uri);
  http.Response response =
      await http.put(url, headers: {'Accept': 'application/json'},body: jsonEncode(<String, String>{
        'firstname': textControlDict['firstname']!.text,
        'lastname': textControlDict['lastname']!.text,
        'email': textControlDict['email']!.text,
        'dob': textControlDict['dob']!.text,
        'password': textControlDict['password']!.text,
        'mobilenumber': textControlDict['mobile']!.text,
        'medicalhistory': textControlDict['medhist']!.text,
      }));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    print(parsed);
    return parsed;
  } else {
    print(response.headers);
  }
  return response;
}
//
//
//       // 'FirstName': firstName,
//       // 'LastName': lastName,
//       // 'Email': email,
//       // 'DOB': dOB,
//       // 'Password': password,
//       // 'MobileNumber': mobileNumber,
//       // 'MedicalHistory': medicalHistory,
//
// // TextEditingController _controller =
// //       TextEditingController(text: "Festive Leave");
// //   bool _isEnable = false;
// // //These are initialize at the top
//
//
// // Row(
// //             children: <Widget>[
// //               Container(
// //                 width: 100,
// //                 child: TextField(
// //                   controller: _controller,
// //                   enabled: _isEnable,
// //                 ),
// //               ),
// //               IconButton(
// //                   icon: Icon(Icons.edit),
// //                   onPressed: () {
//                     // setState(() {
//                     //   _isEnable = true;
//                     // });
// //                   })
// //             ],
// //           ),
//
// // IconButton editButton() {
// //   return IconButton(
// //       icon: const Icon(Icons.create_outlined),
// //   color: Colors.blue,
// //   onPressed: () {
// //   setState(() {
// //   enabledFlags['firstname'] =
// //   !(enabledFlags['firstname']!);
// //   if (enabledFlags['firstname'] == true) {
// //   buttonText['firstname'] = buttonTextSave;
// //   textBoxBackgrounds['firstname'] =
// //   textBoxSelectedColor;
// //   } else {
// //   buttonText['firstname'] = buttonTextEdit;
// //   textBoxBackgrounds['firstname'] =
// //   textBoxNotSelectedColor;
// //   }
// //   });
// //   },
// //   );
// }