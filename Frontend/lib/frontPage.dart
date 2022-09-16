// ignore_for_file: sort_child_properties_last

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class FrontPage extends StatelessWidget {
  final user;
  final Function setUser;
  final Function logoutUser;


  FrontPage({required this.user, required this.setUser, required this
      .logoutUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: Center(child: const Text("Neighbourhood Doctors")),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                user.value.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Welcome',
                          style: TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Welcome ${user.value['firstname']}!',
                          style: TextStyle(color: Colors.black, fontSize: 24.0),
                        ),
                      ),
                user.value.isEmpty
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: Text("Register",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: Text(
                                  "Profile",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: Text("Appointments",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
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
                                child: Text("Chat",
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  logoutUser();
                                },
                                child: Text("Logout",
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
      // body: Center(
      //   child: Container(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Text(
      //           'Welcome',
      //           style: TextStyle(color: Colors.black, fontSize: 28.0),
      //         ),
      //         const Padding(
      //           padding: EdgeInsets.only(top: 40.0),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           child: SizedBox(
      //             width: 350.0, // <-- match_parent
      //             height: 75.0, // <-- match-parent
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 primary: Colors.lightBlue, // background
      //                 onPrimary: Colors.white, // foreground
      //               ),
      //               child: const Text('Login'),
      //               onPressed: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   return Login(setUser: setUser);
      //                 }));
      //               },
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           child: SizedBox(
      //             width: 350.0, // <-- match_parent
      //             height: 75.0, // <-- match-parent
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 primary: Colors.lightGreen, // background
      //                 onPrimary: Colors.black, // foreground
      //               ),
      //               child: const Text('Register'),
      //               onPressed: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   return SignupPage(setUser: setUser);
      //                 }));
      //               },
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     padding: const EdgeInsets.all(15),
      //     color: Color.fromARGB(255, 113, 113, 113),
      //     width: 500,
      //     height: 500,
      //   ),
      // ),
      // ),
    );
  }
}
