// import 'dart:html';

import 'dart:convert';

import 'frontPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'patientProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = useState({});

    void _setUser(String res, String userType) {
      user.value = json.decode(res);
      user.value['usertype'] = userType;
    }

    void _logoutUser() {
      user.value = {};
    }

    return MaterialApp(
        title: 'Navigation Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // home: const PatientProfile(),
        home: ((user.value.isEmpty)
            ? FrontPage(
                setUser: _setUser,
              )
            : const PatientProfile()),
        routes: {
          '/profile': (context) => PatientProfile(user: user),
        });
  }
}
