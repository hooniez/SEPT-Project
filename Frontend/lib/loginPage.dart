import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';

enum UserType { doctor, patient, admin }

class Login extends StatefulWidget {
  final Function setUser;
  final bool forAdmin;
  Login({required this.setUser, this.forAdmin=false});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserType? _userType;
  String? API_HOST;

  // Login page two fronts: one for admin and the other for patient
  @override
  void initState() {
    _userType = widget.forAdmin ? UserType.admin : UserType.patient;
    API_HOST = widget.forAdmin ? "10.0.2.2:6868" : "10.0.2.2:6871";
  }


  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {
    String type = _userType.toString().split('.').last;

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': '<Your token>'
    };

    final body = {
      'email': emailController.text,
      'password': passwordController.text,
      'userType': type
    };

    final uri = Uri.http(API_HOST!, "/$type/signin");
    print(body);
    print(uri);

    Response res = await post(uri, headers: header, body: json.encode(body));
    print(res.headers);
    print(res.body);
    if (res.statusCode == 202) {
      widget.setUser(res.body, type, res.headers['authorization']);
      Navigator.pushNamed(context, '/frontPage');
    } else {
      print("login unsuccessful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: Center(child: const Text("Neighbourhood Doctors")),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ))),
        body: SingleChildScrollView(
          controller: AdjustableScrollController(100),
          child: Container(
            padding: const EdgeInsets.all(15),
            width: 500,
            height: 500,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _userType == UserType.admin ?
                  const Text(
                    'Admin Login',
                    style: TextStyle(color: Colors.black, fontSize: 28.0),
                  ) : const Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 28.0),
                  )
                  ,
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                  ),
                  _userType != UserType.admin ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Radio<UserType>(
                          value: UserType.patient,
                          groupValue: _userType,
                          onChanged: (UserType? value) {
                            setState(() {
                              _userType = value;
                            });
                          },
                        ),
                        const Text(
                          "Patient",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                      Row(children: [
                        Radio<UserType>(
                          value: UserType.doctor,
                          groupValue: _userType,
                          onChanged: (UserType? value) {
                            setState(() {
                              _userType = value;
                            });
                          },
                        ),
                        const Text(
                          "Doctor",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                    ],
                  ) : (
                  Row()
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 300.0, // <-- match_parent
                      height: 50.0, // <-- match-parent
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: const Text('Login'),
                        onPressed: () async {
                          login();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
