// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'symptomsPageAddSymptoms.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class SymptomsPageCurrentSymptoms extends StatefulWidget {
  final getUser;
  final Response getSymptoms;
  const SymptomsPageCurrentSymptoms(
      {Key? key, required this.getUser, required this.getSymptoms})
      : super(key: key);

  @override
  State<SymptomsPageCurrentSymptoms> createState() =>
      _SymptomsPageCurrentSymptomsState();
}

class _SymptomsPageCurrentSymptomsState
    extends State<SymptomsPageCurrentSymptoms> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController symptomDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> allSymptoms = json.decode(widget.getSymptoms.body);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 223, 28, 93),
                title: const Text("Neighbourhood Doctors"),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/frontPage');
                        },
                        child: Icon(
                          Icons.home,
                          size: 26.0,
                        ),
                      )),
                ]),
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
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox(
                                      width: 300.0, // <-- match_parent
                                      height: 50.0, // <-- match-parent
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 221, 150, 17), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        child: const Text(
                                          'Current Symptoms',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SymptomsPageCurrentSymptoms(
                                                getUser: widget.getUser,
                                                getSymptoms:
                                                    widget.getSymptoms);
                                          }));
                                        },
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
                                          primary: Color.fromARGB(
                                              255, 144, 119, 151), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        child: const Text(
                                          'Add Symptom',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SymptomsPageAddSymptoms(
                                                getUser: widget.getUser,
                                                getSymptoms:
                                                    widget.getSymptoms);
                                          }));
                                        },
                                      ),
                                    ),
                                  ),
                                  Text(
                                      'Symptoms for ${widget.getUser.value['firstname']}:',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  allSymptoms.isNotEmpty
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(24.0),
                                          itemCount: allSymptoms.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              width: 100.0,
                                              height: 50.0,
                                              color: Color.fromARGB(
                                                  255, 218, 217, 217),
                                              child: Center(
                                                  child: Text(
                                                      allSymptoms[index][
                                                          'symptomdescription'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black))),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        )
                                      : const Center(
                                          child: Text(
                                              'No symptoms, you are healthy! If you are experiencing any symptoms please add them through the "Add Symptoms" button',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
