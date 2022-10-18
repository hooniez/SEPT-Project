// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'symptomsPageCurrentSymptoms.dart';
import 'package:http/http.dart';
import 'support_pages/customButtons.dart';
import 'package:intl/intl.dart';
import 'urls.dart';

class SymptomsPageAddSymptoms extends StatefulWidget {
  final getUser;
  final Response getSymptoms;
  const SymptomsPageAddSymptoms(
      {Key? key, required this.getUser, required this.getSymptoms})
      : super(key: key);

  @override
  State<SymptomsPageAddSymptoms> createState() =>
      _SymptomsPageAddSymptomsState();
}

class _SymptomsPageAddSymptomsState extends State<SymptomsPageAddSymptoms> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController symptomDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: DefaultAppbar(
                appbarText: "Appointments",
                onPressed: () async {
                  Navigator.pop(context);
                }),
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
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SymptomsButton(
                                          itemColor: Colors.green,
                                          buttonWidth: 160,
                                          iconSize: 30,
                                          onPressed: () async {
                                            var getRes = await getSymptom(
                                                widget.getUser.value["email"],
                                                widget.getUser
                                                    .value['Authorization']);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SymptomsPageCurrentSymptoms(
                                                  getUser: widget.getUser,
                                                  getSymptoms: getRes);
                                            }));
                                          },
                                          buttonText: "Current Symptoms",
                                          buttonIcon: Icons.sick_rounded,
                                          fontSize: 16,
                                        ),
                                        SymptomsButton(
                                          buttonWidth: 150,
                                          iconSize: 30,
                                          onPressed: () {},
                                          buttonText: "Add Symptom",
                                          fontSize: 16,
                                          buttonIcon: Icons.add_circle_rounded,
                                        ),
                                      ]),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            symptomDescriptionController,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.sick),
                                          labelText: "What's the Symptom",
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a symptom above';
                                          } else if (value.length > 50) {
                                            return 'This is too long for a single symptom, please shorten it';
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
                                          primary: Colors.blue, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          final isValidForm =
                                              _formKey.currentState!.validate();
                                          if (isValidForm) {
                                            var res = await addSymptom(
                                                symptomDescriptionController
                                                    .text,
                                                widget.getUser.value['email'],
                                                widget.getUser
                                                    .value['Authorization']);
                                            if (res.body.isNotEmpty) {
                                              var getRes = await getSymptom(
                                                  widget.getUser.value["email"],
                                                  widget.getUser
                                                      .value['Authorization']);
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return SymptomsPageCurrentSymptoms(
                                                    getUser: widget.getUser,
                                                    getSymptoms: getRes);
                                              }));
                                            } else {
                                              print("empty");
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}

Future<Response> getSymptom(String patientemail, String token) async {
  final uri = Uri.parse("$api:$symptom_port/getsymptom/?email=$patientemail");
  print(uri);

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token
  };
  Response res = await get(uri, headers: header);
  return res;
}

Future<Response> addSymptom(
    String symptomdescription, String patientemail, String token) async {
  final url = Uri.parse("$api:$symptom_port/addsymptom");
  print(url);
  String body;
  body = jsonEncode(<String, String>{
    'email': patientemail,
    'symptomdescription': symptomdescription,
  });
  Response res = await put(url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': token
      },
      body: body);
  return res;
}
