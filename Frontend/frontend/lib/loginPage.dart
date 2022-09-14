

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';

class Login extends StatelessWidget {
  final Function setUser;
  Login({required this.setUser});

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Text("Neighbourhood Doctors Login"),
        ),
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
                  const Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 28.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
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
                          final queryParameters = {
                            'email': emailController.text,
                            'password': passwordController.text
                          };
                          final uri = Uri.http("10.0.2.2:8080", "/signin",
                              queryParameters);
                          print(uri);

                          Response res = await get(uri);

                          if (res.body.isNotEmpty) {
                            print("hey");
                            setUser(res.body);
                            Navigator.pushNamed(context, '/profile');
                          } else {
                            print("empty");
                          }
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
