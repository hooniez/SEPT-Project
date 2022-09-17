import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class AppointmentPage extends StatefulWidget {
  final user;

  AppointmentPage({required this.user});

  @override
  State<AppointmentPage> createState() => _MyAppState();
}

class AppointmentView {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String patientName;
  final String doctorName;
  final String booked;

  AppointmentView(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.patientName,
      required this.doctorName,
      required this.booked});

  factory AppointmentView.fromJson(Map<String, dynamic> json) {
    return AppointmentView(
      id: json['id'] ?? "0",
      date: json['date'] ?? "0",
      startTime: json['startTime'] ?? "0",
      endTime: json['endTime'] ?? "0",
      patientName: json['patientName'] ?? "0",
      doctorName: json['doctorName'] ?? "0",
      booked: json['booked'] ?? "0",
    );
  }
}

Future<List<AppointmentView>> getAppointment(user) async {
  // construct the request
  String API_HOST = "10.0.2.2:8081";
  String APPOINTMENT_PATH = "/appointment";

  final queryParameters = {
    'email': user.value['email'],
    'usertype': user.value['usertype']
  };

  final url = Uri.http(API_HOST, APPOINTMENT_PATH, queryParameters);

  print(url);
  final Response res = await get(url);
  print(res.body.toString());

  if (res.statusCode == 200 || res.statusCode == 202) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse
        .map((data) => new AppointmentView.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load appointments');
  }
}

class _MyAppState extends State<AppointmentPage> {
  late Future<List<AppointmentView>> futureData;

  @override
  void initState() {
    super.initState();
    print("init");
    futureData = getAppointment(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 223, 28, 93),
          title: const Center(child: Text("Neighbourhood Doctors")),
        ),
        body: Center(
          child: FutureBuilder<List<AppointmentView>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AppointmentView> data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 75,
                        color: Colors.white,
                        child: Center(
                          child: Text(data[index].doctorName),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
