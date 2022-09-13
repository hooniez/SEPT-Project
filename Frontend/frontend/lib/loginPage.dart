
import 'package:flutter/material.dart';
// import 'dart:html';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Neighbourhood Doctors Login"),
        ),
        body: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 28.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                        onPressed: () {
                          print('Hello');
                        },
                      ),
                    ),
                  ),
                ],
              ),
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

Future<http.Response> createPatient(
    String firstName,
    String middleName,
    String lastName,
    String email,
    String dOB,
    String password,
    String mobileNumber,
    String medicalHistory) async {
  var uri = Uri.http('localhost:8080', 'signup');

  return await http.put(
    //Uri.parse('http://localhost:8080/signup'),
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FirstName': firstName,
      'MiddleName': middleName,
      'LastName': lastName,
      'Email': email,
      'DOB': dOB,
      'Password': password,
      'MobileNumber': mobileNumber,
      'MedicalHistory': medicalHistory,
    }),
  );
}