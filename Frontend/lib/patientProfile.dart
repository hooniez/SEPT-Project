// ignore_for_file: sort_child_properties_last

// import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatientProfile extends StatefulWidget {
  final user;
  const PatientProfile({Key? key, this.user}) : super(key: key);

  @override
  State<PatientProfile> createState() => _MyAppState();
}

class _MyAppState extends State<PatientProfile> {
  late String _firstname;

  @override
  void initState() {
    _firstname = widget.user.value['firstname'];
  }
  final _formKey = GlobalKey<FormState>();
  Map<String, double> editButtonDetails = {
    'width': 60.0,
    'height': 25.0,
    'fontSize': 12
  };

  late Map<String, TextEditingController> textControllers = {
    'firstname': TextEditingController(text: _firstname),
    'lastname': TextEditingController(text: "Billinson"),
    'email': TextEditingController(text: "BillinsonBilly@bill.com.au"),
    'dob': TextEditingController(text: "12/12/1212"),
    'mobile': TextEditingController(text: "0121212121212"),
    'medhist':
    TextEditingController(text: "Something bad happpened to me some time")
  };

  String buttonTextEdit = 'Edit';
  String buttonTextSave = 'Save';
  Map<String, String> buttonText = {
    'firstname': 'Edit',
    'lastname': 'Edit',
    'email': 'Edit',
    'dob': 'Edit',
    'mobile': 'Edit',
    'medhist': 'Edit'
  };

  Map<String, bool> enabledFlags = {
    'firstname': false,
    'lastname': false,
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

  double itemTitleFontSize = 16;
  double itemFontSize = 18;
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
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'First Name:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['firstname'],
                                  child: TextField(
                                    controller: textControllers['firstname'],
                                    enabled: enabledFlags['firstname'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['firstname']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        enabledFlags['firstname'] =
                                        !(enabledFlags['firstname']!);
                                        if (enabledFlags['firstname'] == true) {
                                          buttonText['firstname'] =
                                              buttonTextSave;
                                          textBoxBackgrounds['firstname'] =
                                              textBoxSelectedColor;
                                        } else {
                                          buttonText['firstname'] =
                                              buttonTextEdit;
                                          textBoxBackgrounds['firstname'] =
                                              textBoxNotSelectedColor;
                                        }
                                      });
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
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Last Name:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['lastname'],
                                  child: TextField(
                                    controller: textControllers['lastname'],
                                    enabled: enabledFlags['lastname'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['lastname']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        enabledFlags['lastname'] =
                                        !(enabledFlags['lastname']!);
                                        if (enabledFlags['lastname'] == true) {
                                          buttonText['lastname'] =
                                              buttonTextSave;
                                          textBoxBackgrounds['lastname'] =
                                              textBoxSelectedColor;
                                        } else {
                                          buttonText['lastname'] =
                                              buttonTextEdit;
                                          textBoxBackgrounds['lastname'] =
                                              textBoxNotSelectedColor;
                                        }
                                      });
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
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Email:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['email'],
                                  child: TextField(
                                    controller: textControllers['email'],
                                    enabled: enabledFlags['email'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['email']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
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
                                        }
                                      });
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
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Date Of Birth:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['dob'],
                                  child: TextField(
                                    controller: textControllers['dob'],
                                    enabled: enabledFlags['dob'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['dob']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
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
                                        }
                                        if (enabledFlags['dob'] == true) {}
                                      });
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
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Mobile Number:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['mobile'],
                                  child: TextField(
                                    controller: textControllers['mobile'],
                                    enabled: enabledFlags['mobile'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['mobile']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
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
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Medical History:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 200,
                                  color: textBoxBackgrounds['medhist'],
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextField(
                                    controller: textControllers['medhist'],
                                    enabled: enabledFlags['medhist'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: editButtonDetails[
                                  'width'], // <-- match_parent
                                  height: editButtonDetails[
                                  'height'], // <-- match-parent
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    child: Text(
                                      buttonText['medhist']!,
                                      style: TextStyle(
                                          fontSize:
                                          editButtonDetails['fontSize']),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        enabledFlags['medhist'] =
                                        !(enabledFlags['medhist']!);
                                        if (enabledFlags['medhist'] == true) {
                                          buttonText['medhist'] =
                                              buttonTextSave;
                                          textBoxBackgrounds['medhist'] =
                                              textBoxSelectedColor;
                                        } else {
                                          buttonText['medhist'] =
                                              buttonTextEdit;
                                          textBoxBackgrounds['medhist'] =
                                              textBoxNotSelectedColor;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            padding: const EdgeInsets.all(15),
            color: Colors.grey,
            width: 1000,
            height: 500,
          ),
        ),
      ),
    );
  }
}

Future<String> getPatientData() async {
  final url = Uri.parse('localhost:8080/patients/patient1');
  http.Response response =
  await http.get(url, headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    print(parsed);
    return parsed;
  }
  return response.statusCode.toString();
}


// 'FirstName': firstName,
// 'LastName': lastName,
// 'Email': email,
// 'DOB': dOB,
// 'Password': password,
// 'MobileNumber': mobileNumber,
// 'MedicalHistory': medicalHistory,

// TextEditingController _controller =
//       TextEditingController(text: "Festive Leave");
//   bool _isEnable = false;
// //These are initialize at the top


// Row(
//             children: <Widget>[
//               Container(
//                 width: 100,
//                 child: TextField(
//                   controller: _controller,
//                   enabled: _isEnable,
//                 ),
//               ),
//               IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
// setState(() {
//   _isEnable = true;
// });
//                   })
//             ],
//           ),