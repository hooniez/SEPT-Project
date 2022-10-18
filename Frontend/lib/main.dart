// import 'dart:html';

import 'dart:convert';

import 'frontPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = useState({});

    // a prop function passed down to child widgets with token
    void _setUser(String res, String userType, String token) {
      user.value = json.decode(res);
      user.value['usertype'] = userType;
      user.value['Authorization'] = token;
    }

    // a prop function passed down to child widgets without token
    void _setUserWithoutToken(String res, String userType) {
      user.value = json.decode(res);
      user.value['usertype'] = userType;
    }

    void _logoutUser() {
      user.value = {};
    }

    void _updateName(String firstName) {
        user.value['firstname'] = firstName;
        print("updated");
    }

    return MaterialApp(
        title: 'Navigation Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // home: const PatientProfile(),
        home: FrontPage(
            user: user,
            setUser: _setUser,
            setUserWithoutToken: _setUserWithoutToken,
            logoutUser: _logoutUser,
            updateName: _updateName),
        routes: {
          '/frontPage': (context) => FrontPage(
              user: user,
              setUser: _setUser,
              setUserWithoutToken: _setUserWithoutToken,
              logoutUser: _logoutUser,
              updateName: _updateName),
        });
  }
}
