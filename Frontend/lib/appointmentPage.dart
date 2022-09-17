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

class Appointment {
  final String date;
  final String startTime;
  final String endTime;
  final String patient;
  final String doctor;
  final bool booked;

  Appointment(
      {required this.date,
      required this.startTime,
      required this.endTime,
      required this.patient,
      required this.doctor,
      required this.booked});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      patient: json['patient'],
      doctor: json['doctor'],
      booked: json['booked'],
    );
  }
}

Future<List<Appointment>> getAppointment(String email) async {
  // construct the request
  String API_HOST = "lcoalhost:8081";
  String APPOINTMENT_PATH = "/appointment/";

  final queryParameters = {'email': email};

  final url = Uri.http(API_HOST, APPOINTMENT_PATH, queryParameters);

  final Response res = await get(url);

  if (res.statusCode == 200) {
    List jsonResponse = json.decode(res.body);
    return jsonResponse.map((data) => new Appointment.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load appointments');
  }
}

class _MyAppState extends State<AppointmentPage> {
  late Future<List<Appointment>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getAppointment(widget.user.value['email']);
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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
                child: FutureBuilder<List<Appointment>>(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Appointment> data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 75,
                              color: Colors.white,
                              child: Center(
                                child: Text(data[index].doctor),
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
          ),
        ));
  }
}
