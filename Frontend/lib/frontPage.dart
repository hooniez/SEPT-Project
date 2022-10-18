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
                          MenuButton(buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.face_outlined, buttonText: "Login",
                              onPressed: () async {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Login(setUser: setUser);
                              }));
                          }),
                          MenuButton(fontSize: 18, buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.pages_sharp, buttonText: "Register",
                              onPressed: () async {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SignupPage(setUserWithoutToken: setUserWithoutToken);
                              }));
                          }),
                          MenuButton(itemColor: Colors.grey,fontSize: 18, buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.pages_sharp, buttonText: "Admin Login",
                              onPressed: () async {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Login(setUser: setUser, forAdmin: true,
                                      );
                                    }));
                          }),
                        ],
                      )
                    : Column(
                        children: [
                          if (user.value['usertype'] == "admin")
                MenuButton(buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.face_outlined, buttonText: "Register Doctor",
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SignupPage(setUserWithoutToken: setUserWithoutToken, forDoctor: true,);
                          }));
                    }),
                          if (user.value['usertype'] != "admin")
                          MenuButton(fontSize: 18,buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.face_outlined, buttonText: "Profile",
                              onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return PatientProfile(user: user);
                            }));
                          }),
                          if (user.value['usertype'] == "patient")
                            MenuButton(fontSize:18, buttonHeight:50, buttonWidth: 200, buttonIcon: Icons.sick_outlined, buttonText: "Symptoms",
                                onPressed: () async {
                                  var res = await getSymptom(user);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return SymptomsPageCurrentSymptoms(getUser: user, getSymptoms: res);
                                      }));
                                }),
                          if (user.value['usertype'] == "patient")
                            MenuButton(fontSize: 18, buttonHeight:60, buttonWidth: 200, buttonIcon: Icons.calendar_month_rounded, buttonText: "Appointments",
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return AppointmentPage(user: user);
                                  }));
                                }),
                          if (user.value['usertype'] == "doctor")
                            MenuButton(fontSize: 18, buttonHeight:60, buttonWidth: 200, buttonIcon: Icons.calendar_month_rounded, buttonText: "Availabilities",
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return SignupPage(setUserWithoutToken: setUser);
                                    }));
                                  },
                                  child: const Text("Chat",
                                      style: TextStyle(fontSize: 18.0,decoration:TextDecoration.lineThrough)),
                                ),
                              ),
                            ),
                          MenuButton(itemColor: Colors.red,fontSize: 18, buttonHeight:60, buttonWidth: 200, buttonIcon: Icons.exit_to_app_rounded, buttonText: "Logout",
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

  final uri = Uri.parse("$api:$symptom_port/getsymptom?email=${user
      .value['email']}");
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