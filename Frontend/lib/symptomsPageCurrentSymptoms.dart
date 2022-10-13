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
  bool startOfProgram = true;
  late List<bool> allEnables;
  late List<dynamic> allSymptoms;
  late Response updatedSymptoms;

  @override
  Widget build(BuildContext context) {
    // if this page is in its first local running (that is, hasnt been refreshed and has come from another page)
    // then that means we are at the start running, so we take data from the page that was come from and use that
    // until the page is refreshed by deleting a symptom
    if (startOfProgram) {
      updatedSymptoms = widget.getSymptoms;
      allSymptoms = json.decode(widget.getSymptoms.body);
      allEnables = List.filled(allSymptoms.length, false);
      // if a symptom is deleted, we now take the updatedsymptoms instead
    } else {
      allSymptoms = json.decode(updatedSymptoms.body);
    }
    // allEnables will not fill false again so will save edit states
    // will also save state of symptoms after deletion/edit
    startOfProgram = false;
    // standard materialApp procedures with comments on unclear aspects
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
                                        onPressed: () {},
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
                                                getSymptoms: updatedSymptoms);
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
                                  // display all the items if they exist, otherwise display another message letting the user know
                                  // they have to add symptoms
                                  allSymptoms.isNotEmpty
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(24.0),
                                          itemCount: allSymptoms.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // iterate over all the symptom items and display them
                                            return Row(children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                    width: 1800.0,
                                                    height: 50.0,
                                                    child: Center(
                                                        child: TextFormField(
                                                      enabled:
                                                          allEnables[index],
                                                      // key that allows updating of initialvalue when it is changed via setState
                                                      key: Key(allSymptoms[
                                                              index][
                                                          'symptomdescription']),
                                                      initialValue: allSymptoms[
                                                              index][
                                                          'symptomdescription'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "Symptom ${index + 1}",
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                    ))),
                                              ),
                                              // an iconbutton to display an icon to be pressed, and when pressed delete that item and refresh page
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    await deleteSymptom(
                                                        allSymptoms[index]
                                                            ['id'],
                                                        widget.getUser.value[
                                                            "Authorization"]);
                                                    var res = await getSymptom(
                                                        widget.getUser
                                                            .value["email"],
                                                        widget.getUser.value[
                                                            "Authorization"]);
                                                    setState(() {
                                                      updatedSymptoms = res;
                                                    });
                                                  })
                                            ]);
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(),
                                        )
                                      : const Center(
                                          child: Text(
                                              'No symptoms, you are healthy! If you are experiencing any symptoms please add them through the "Add Symptom" button',
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

// getSymptom response to get all the symptoms after deletion (or in general)
Future<Response> getSymptom(String patientemail, String token) async {
  String API_HOST = "10.0.2.2:8085";
  final queryParameters = {'email': patientemail};
  final uri = Uri.http(API_HOST, "/getsymptom", queryParameters);
  print(uri);

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token
  };

  Response res = await get(uri, headers: header);
  return res;
}

// deleteSymptom response to successfully delete a particular symptom
Future<Response> deleteSymptom(int id, String token) async {
  String stringId = id.toString();
  String API_HOST = "10.0.2.2:8085";
  final uri = Uri.http(API_HOST, "/deletesymptom", {'id': stringId});
  print(uri);

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': token
  };
  Response res = await delete(uri, headers: header);
  return res;
}
