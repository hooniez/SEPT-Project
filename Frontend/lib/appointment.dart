import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class Appointment extends StatefulWidget {
  final user; 

  Appointment({required this.user});

  @override
  State<Appointment> createState() => _MyAppState();
}

class _MyAppState extends State<Appointment> {
  
  @override
  void initState() {
    
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, double> editButtonDetails = {
    'width': 60.0,
    'height': 25.0,
    'fontSize': 12
  };




  

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
                          'Appointments',
                          style: TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome ${user.value['firstname']}!',
                          style: const TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
                      ),
                user.value.isEmpty
                    ? Column(
                        children:
                         [ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "GFG",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text(index));
                         })
  ],
)
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
                          if (user.value['usertype'] == "patient") Padding(
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

Future<Appointment> getAppointment(
    String email) async {
  String API_HOST = "lcoalhost:8080";
  String APPOINTMENT_HOST = "/appointment";

  final url = Uri.parse(API_HOST + APPOINTMENT_HOST + "/" + email);
  String body = jsonEncode(<String, String>{
      'email': email,
    }); 

  Response res = await post(url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
      body: body);

  if (res.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load appointments');
  }
}