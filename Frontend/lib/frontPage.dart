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
import 'dart:convert';
import 'chatPage.dart';

class FrontPage extends StatelessWidget {
  final user;
  final Function setUser;
  final Function setUserWithoutToken;
  final Function logoutUser;
  FrontPage(
      {required this.user,
      required this.setUser,
      required this.setUserWithoutToken,
      required this.logoutUser});

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
                user.value.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome',
                          style: TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: user.value['usertype'] == 'admin'
                            ? Text(
                                'Admin Page',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                              )
                            : Text(
                                'Welcome ${user.value['firstname']}!',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 24.0),
                              ),
                      ),
                user.value.isEmpty
                    ? Column(
                        children: [
                          MenuButton(
                              buttonHeight: 50,
                              buttonWidth: 200,
                              buttonIcon: Icons.face_outlined,
                              buttonText: "Login",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login(setUser: setUser);
                                }));
                              }),
                          MenuButton(
                              fontSize: 18,
                              buttonHeight: 50,
                              buttonWidth: 200,
                              buttonIcon: Icons.pages_sharp,
                              buttonText: "Register",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignupPage(
                                      setUserWithoutToken: setUserWithoutToken);
                                }));
                              }),
                          MenuButton(
                              itemColor: Colors.grey,
                              fontSize: 18,
                              buttonHeight: 50,
                              buttonWidth: 200,
                              buttonIcon: Icons.pages_sharp,
                              buttonText: "Admin Login",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login(
                                    setUser: setUser,
                                    forAdmin: true,
                                  );
                                }));
                              }),
                        ],
                      )
                    : Column(
                        children: [
                          if (user.value['usertype'] == "admin")
                            MenuButton(
                                buttonHeight: 50,
                                buttonWidth: 200,
                                buttonIcon: Icons.face_outlined,
                                buttonText: "Register Doctor",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage(
                                      setUserWithoutToken: setUserWithoutToken,
                                      forDoctor: true,
                                    );
                                  }));
                                }),
                          if (user.value['usertype'] != "admin")
                            MenuButton(
                                fontSize: 18,
                                buttonHeight: 50,
                                buttonWidth: 200,
                                buttonIcon: Icons.face_outlined,
                                buttonText: "Profile",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PatientProfile(user: user);
                                  }));
                                }),
                          if (user.value['usertype'] != "admin")
                            MenuButton(
                                fontSize: 18,
                                buttonHeight: 50,
                                buttonWidth: 200,
                                buttonIcon: Icons.sick_outlined,
                                buttonText: "Symptoms",
                                onPressed: () async {
                                  var res = await getSymptom(user);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SymptomsPageCurrentSymptoms(
                                        getUser: user, getSymptoms: res);
                                  }));
                                }),
                          if (user.value['usertype'] != "admin")
                            MenuButton(
                                fontSize: 18,
                                buttonHeight: 60,
                                buttonWidth: 200,
                                buttonIcon: Icons.calendar_month_rounded,
                                buttonText: "Appointments",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AppointmentPage(user: user);
                                  }));
                                }),
                          if (user.value['usertype'] == "doctor")
                            MenuButton(
                                fontSize: 18,
                                buttonHeight: 60,
                                buttonWidth: 200,
                                buttonIcon: Icons.calendar_month_rounded,
                                buttonText: "Availabilities",
                                onPressed: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AvailabilityPage(user: user);
                                  }));
                                }),
                          if (user.value['usertype'] != "admin")
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ChatPage(user: user);
                                    }));
                                  },
                                  child: const Text("Chat",
                                      style: TextStyle(
                                          fontSize: 18.0,)),
                                ),
                              ),
                            ),
                          MenuButton(
                              itemColor: Colors.red,
                              fontSize: 18,
                              buttonHeight: 60,
                              buttonWidth: 200,
                              buttonIcon: Icons.exit_to_app_rounded,
                              buttonText: "Logout",
                              onPressed: () async {
                                logoutUser();
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

class MenuButton extends StatelessWidget {
  MenuButton({
    this.buttonWidth = 100,
    this.buttonHeight = 50,
    this.itemColor = Colors.blue,
    this.itemTitleFontSize = 12,
    this.buttonText = '',
    this.fontSize = 20,
    this.buttonIcon = Icons.access_alarm,
    this.iconSize = 40,
    required this.onPressed,
  });

  final Function onPressed;
  final double iconSize;
  final IconData buttonIcon;
  final double fontSize;
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final Color itemColor;
  final double itemTitleFontSize;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: OutlinedButton.icon(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(fontSize: fontSize, color: itemColor),
                textAlign: TextAlign.center,
              )),
          icon: Icon(buttonIcon, size: 38, color: itemColor),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
