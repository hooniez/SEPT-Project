import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Doctor Signup"),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  width: 50.0, // <-- match_parent
                  height: 50.0, // <-- match-parent
                  child: ElevatedButton(
                    child: const Text('Press me please'),
                    onPressed: () {
                      print('Hello');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                  ),
                ),
              ],
            ),
            padding: const EdgeInsets.all(0.0),
            color: Colors.blue,
            width: 400,
            height: 400,
          ),
        ),
      ),
    );
  }
}
