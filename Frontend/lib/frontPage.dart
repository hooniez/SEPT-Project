// ignore_for_file: sort_child_properties_last

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class FrontPage extends StatelessWidget {
  final Function setUser;
  FrontPage({required this.setUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Welcome to Neighbourhood Doctors"),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(color: Colors.white, fontSize: 28.0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 350.0, // <-- match_parent
                    height: 75.0, // <-- match-parent
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: const Text('Login'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login(
                            setUser: setUser,
                          );
                        }));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 350.0, // <-- match_parent
                    height: 75.0, // <-- match-parent
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightGreen, // background
                        onPrimary: Colors.black, // foreground
                      ),
                      child: const Text('Register'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SignupPage();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15),
            color: Color.fromARGB(255, 113, 113, 113),
            width: 500,
            height: 500,
          ),
        ),
      ),
    );
  }
}
