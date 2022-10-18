import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
// import 'dart:html';
import "support_pages/customButtons.dart";

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'addAppointmentPage.dart';
import 'urls.dart';

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
  String APPOINTMENT_PATH = "/appointment";

  final queryParameters = {
    'email': user.value['email'],
    'usertype': user.value['usertype']
  };

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': user.value["Authorization"]
  };

  final url = Uri.parse('$api:$appointment_port$APPOINTMENT_PATH');

  print(url);
  final Response res = await get(url, headers: header);
  print(res.headers.toString());

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
        appBar: DefaultAppbar(appbarText: "Appointments",onPressed: () async {Navigator.pop(context);}),
        body: Center(
            child: Column(children: [
          if (widget.user.value['usertype'] == "patient")
            AppointmentsButton(itemColor: Colors.green,iconSize: 30, buttonWidth:300,buttonText: "Make Appointment", buttonIcon: Icons.add_circle_outline,onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddAppointmentPage(user: widget.user);
              }));
            },),
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
                      Expanded(
                        child: FittedBox(
                            alignment: Alignment.topCenter,
                            child:
                                dataBody(data, widget.user.value['usertype']),),
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
  double textSize = 30;


  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: DataTable(dataRowHeight:150,
      sortColumnIndex: 0,
      showCheckboxColumn: false,
      columns: [
        DataColumn(
          label: Text("Date", style: TextStyle(fontSize: textSize),),
        ),
        DataColumn(
          label: Text("Start Time",style: TextStyle(fontSize: textSize),),
        ),
        DataColumn(
          label: Text("End Time",style: TextStyle(fontSize: textSize),),
        ),
        DataColumn(
          label: Text(usertype == "patient" ? "Doctor Name" : "Patient Name",style: TextStyle(fontSize: textSize),),
        ),
      ],
      rows: data
          .map(
            (appointmentView) => DataRow(
                cells: [
              DataCell(Text(appointmentView.date,style: TextStyle(fontSize: textSize),)),
              DataCell(Text(appointmentView.startTime,style: TextStyle(fontSize: textSize),)),
              DataCell(Text(appointmentView.endTime,style: TextStyle(fontSize: textSize),)),
              usertype == "patient" ? DataCell(Text(appointmentView.doctorName.split(" ").join("\n"),style: TextStyle(fontSize: textSize)))
              : DataCell(Text(appointmentView.patientName.split(" ").join("\n"),style: TextStyle(fontSize: textSize)))
            ]),
          )
          .toList(),
    ),
  );
}
