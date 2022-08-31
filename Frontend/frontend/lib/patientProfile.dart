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
  Map<String, double> editButtonDetails = {
    'width': 60.0,
    'height': 25.0,
    'fontSize': 12
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
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'First Name:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Billy',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
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
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Last Name:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Billerson',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
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
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Email:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'billybillerson@billmail.com.au',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
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
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Date Of Birth:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '12/12/1212',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
                                    onPressed: () {
                                      print('Edit');
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
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Mobile Number:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '121212121212',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
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
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Medical History:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemTitleFontSize),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Need to increase size of this box',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: itemFontSize),
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
                                      'Edit',
                                      style: TextStyle(
                                          fontSize:
                                              editButtonDetails['fontSize']),
                                    ),
                                    onPressed: () {
                                      print('Edit');
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



