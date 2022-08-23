// ignore_for_file: sort_child_properties_last

import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Online Health Register"),
        ),
        body: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 223, 28, 93),
                              fontSize: 15.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Date of Birth",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Date of Birth",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Second Column in row
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          maxLines: 6,
                          decoration: InputDecoration(
                            labelText: "Medical History",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300.0, // <-- match_parent
                          height: 50.0, // <-- match-parent
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            child: const Text('Register'),
                            onPressed: () {
                              print('Hello');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            padding: const EdgeInsets.all(15),
            color: Colors.blue,
            width: 1000,
            height: 700,
          ),
        ),
      ),
    );
  }
}
