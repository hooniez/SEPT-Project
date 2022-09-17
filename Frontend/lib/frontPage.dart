// ignore_for_file: sort_child_properties_last

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'symptomsPageCurrentSymptoms.dart';
import 'package:http/http.dart';
import 'dart:convert';

class FrontPage extends StatelessWidget {
  final user;
  final Function setUser;
  final Function logoutUser;

  FrontPage(
      {required this.user, required this.setUser, required this.logoutUser});

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
                        child: Text(
                          'Welcome ${user.value['firstname']}!',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 24.0),
                        ),
                      ),
                user.value.isEmpty
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login(setUser: setUser);
                                  }));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage(setUser: setUser);
                                  }));
                                },
                                child: const Text("Register",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Login(setUser: setUser);
                                  }));
                                },
                                child: const Text(
                                  "Profile",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          if (user.value['usertype'] == "patient")
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 200,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignupPage(setUser: setUser);
                                    }));
                                  },
                                  child: const Text("Doctors",
                                      style: TextStyle(fontSize: 18.0)),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () async {
                                  var res = await getSymptom(
                                      user.value["email"], user);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SymptomsPageCurrentSymptoms(
                                        getUser: user, getSymptoms: res);
                                  }));
                                },
                                child: const Text("Symptoms",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage(setUser: setUser);
                                  }));
                                },
                                child: const Text("Appointments",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage(setUser: setUser);
                                  }));
                                },
                                child: const Text("Chat",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  logoutUser();
                                },
                                child: const Text("Logout",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18.0)),
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          )),
    );
  }
}

Future<Response> getSymptom(String patientemail, final user) async {
  String API_HOST = "localhost:8080";
  final queryParameters = {'email': user.value["email"]};
  final uri = Uri.http(API_HOST, "/getsymptom", queryParameters);
  print(uri);

  Response res = await get(uri);
  List<dynamic> result = json.decode(res.body);
  print(result);
  // THIS BELOW IS SUPER IMPORTANT
  print(result[0]['symptomdescription']);
  print(result.length);
  print(res);
  print(user.value["email"]);
  return res;
}
