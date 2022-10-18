import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/doctor.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<Doctor>> getDoctors() async {
    final http.Response res =
        await http.get(Uri.parse("http://localhost:8080/chat/doctor/all"));
    print(res.statusCode);
    print(res.body.toString());

    if (res.statusCode == 200 || res.statusCode == 202) {
      List jsonResponse = json.decode(res.body);
      jsonResponse.map((data) => print(data));
      return jsonResponse
          .map((data) => Doctor.fromJson(data))
          // only show unbooked appointments
          .toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Widget contactWidget() {
    return FutureBuilder<List<Doctor>>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Doctor> doctors = snapshot.data!;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(doctors[index].firstname),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const CircularProgressIndicator();
      },
      future: getDoctors(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('contacts'),
      ),
      body: contactWidget(),
    );
  }
}
