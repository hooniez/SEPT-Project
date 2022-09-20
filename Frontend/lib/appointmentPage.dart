import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'addAppointmentPage.dart';

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
  final bool booked;

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
      id: json['id'] ?? "N/A",
      date: json['date'] ?? "N/A",
      startTime: json['starttime'] ?? "N/A",
      endTime: json['endtime'] ?? "N/A",
      patientName: json['patientName'] ?? "",
      doctorName: json['doctorName'] ?? "",
      booked: json['appointmentbooked'] ?? false,
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
        // only show booked appointments
        .where((data) => data.booked)
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
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/frontPage');
                    },
                    child: Icon(
                      Icons.home,
                      size: 26.0,
                    ),
                  )),
            ]),
        body: Center(
            child: Column(children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 144, 119, 151), // background
              onPrimary: Colors.white, // foreground
            ),
            child: const Text(
              'Make appointment',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddAppointmentPage(user: widget.user);
              }));
            },
          ),
          Expanded(
            child: FutureBuilder<List<AppointmentView>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AppointmentView> data = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      const Text("Your Appointments"),
                      Expanded(
                        child: FittedBox(
                            alignment: Alignment.topCenter,
                            child:
                                dataBody(data, widget.user.value['usertype'])),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ])),
      ),
    );
  }
}

SingleChildScrollView dataBody(List<AppointmentView> data, String usertype) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: DataTable(
      sortColumnIndex: 0,
      showCheckboxColumn: false,
      columns: [
        DataColumn(
          label: Text("Date"),
        ),
        DataColumn(
          label: Text("Start Time"),
        ),
        DataColumn(
          label: Text("End Time"),
        ),
        DataColumn(
          label: Text(usertype == "patient" ? "Doctor Name" : "Patient Name"),
        ),
      ],
      rows: data
          .map(
            (appointmentView) => DataRow(cells: [
              DataCell(Text(appointmentView.date)),
              DataCell(Text(appointmentView.startTime)),
              DataCell(Text(appointmentView.endTime)),
              DataCell(Text(usertype == "patient"
                  ? appointmentView.doctorName
                  : appointmentView.patientName)),
            ]),
          )
          .toList(),
    ),
  );
}
