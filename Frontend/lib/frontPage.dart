// ignore_for_file: sort_child_properties_last

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend/urls.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'profile.dart';
import 'appointmentPage.dart';
import 'availabilityPage.dart';
import 'symptomsPageCurrentSymptoms.dart';
import 'package:http/http.dart';
import 'support_pages/customButtons.dart';
import 'dart:convert';
import 'chatSelectPage.dart';

class FrontPage extends StatefulWidget {
  final user;
  final Function setUser;
  final Function setUserWithoutToken;
  final Function logoutUser;
  final Function updateName;

  FrontPage(
      {required this.user,
      required this.setUser,
      required this.setUserWithoutToken,
      required this.logoutUser,
      required this.updateName});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final double pageTextSize = 30.0;
  final double pageInset = 8.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: const Center(child: Text("Neighbourhood Doctors")),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.user.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(pageInset),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.black, fontSize: pageTextSize),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(pageInset),
                        child: widget.user.value['usertype'] == 'admin'
                            ? Text(
                                'Admin Page',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: pageTextSize),
                              )
                            : Text(
                                'Welcome ${widget.user.value['firstname']}!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: pageTextSize),
                              ),
                      ),
                widget.user.value.isEmpty
                    ? Column(
                        children: [
                          MenuButton(
                              buttonIcon: Icons.face_outlined,
                              buttonText: "Login",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login(setUser: widget.setUser);
                                }));
                              }),
                          MenuButton(
                              buttonIcon: Icons.pages_sharp,
                              buttonText: "Register",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignupPage(
                                      setUserWithoutToken:
                                          widget.setUserWithoutToken);
                                }));
                              }),
                          MenuButton(
                              itemColor: Colors.grey,
                              buttonIcon: Icons.pages_sharp,
                              buttonText: "Admin Login",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login(
                                    setUser: widget.setUser,
                                    forAdmin: true,
                                  );
                                }));
                              }),
                        ],
                      )
                    : Column(
                        children: [
                          if (widget.user.value['usertype'] == "admin")
                            MenuButton(
                                buttonIcon: Icons.face_outlined,
                                buttonText: "Register Doctor",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage(
                                      setUserWithoutToken:
                                          widget.setUserWithoutToken,
                                      forDoctor: true,
                                    );
                                  }));
                                }),
                          if (widget.user.value['usertype'] != "admin")
                            MenuButton(
                                buttonIcon: Icons.face_outlined,
                                buttonText: "Profile",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PatientProfile(
                                        user: widget.user,
                                        updateName: widget.updateName);
                                  }));
                                }),

                          if (widget.user.value['usertype'] == "patient")
                            MenuButton(
                                buttonIcon: Icons.sick_outlined,
                                buttonText: "Symptoms",
                                onPressed: () async {
                                  var res = await getSymptom(widget.user);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    print(widget.user.value['firstname']);
                                    return SymptomsPageCurrentSymptoms(
                                        getUser: widget.user, getSymptoms: res);
                                  }));
                                }),


                          if (widget.user.value['usertype'] == "patient")
                            MenuButton(
                                buttonIcon: Icons.calendar_month_rounded,
                                buttonText: "Appointments",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AppointmentPage(user: widget.user);
                                  }));
                                }),
                          if (widget.user.value['usertype'] == "doctor")
                            MenuButton(
                                buttonIcon: Icons.calendar_month_rounded,
                                buttonText: "Availabilities",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AvailabilityPage(user: widget.user);
                                  }));
                                }),
                          if (widget.user.value['usertype'] != "admin")
                            MenuButton(
                                itemColor: Colors.grey,
                                buttonIcon: Icons.chat_bubble_outline_rounded,
                                buttonText: "Chat",
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ChatSelectPage(user: user);
                                  }));
                                }),
                          MenuButton(
                              itemColor: Colors.red,
                              buttonIcon: Icons.exit_to_app_rounded,
                              buttonText: "Logout",
                              onPressed: () async {
                                widget.logoutUser();
                              }),
                        ],
                      )
              ],
            ),
          )),
    );
  }
}

Future<Response> getSymptom(user) async {
  final uri =
      Uri.parse("$api:$symptom_port/getsymptom?email=${user.value['email']}");
  print(uri);

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': user.value["Authorization"]
  };
  Response res = await get(
    uri,
    headers: header,
  );
  return res;
}
