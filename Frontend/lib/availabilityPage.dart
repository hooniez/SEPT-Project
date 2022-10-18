import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
import 'addAvailabilityPage.dart';
import 'urls.dart';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'support_pages/customButtons.dart';

class AvailabilityPage extends StatefulWidget {
  final user;

  const AvailabilityPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AvailabilityPage> createState() => _MyAppState();
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

Future<List<AppointmentView>> getAvailabilities(user) async {
  // construct the request

  String APPOINTMENT_PATH = "/appointment";

  final queryParameters = {
    'email': user.value['email'],
    'usertype': user.value['usertype']
  };

  final url = Uri.parse("$api:$appointment_port$APPOINTMENT_PATH");

  print(url);

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': user.value["Authorization"]
  };

  final Response res = await get(url, headers: header);
  print(res.statusCode);
  print(res.body.toString());

  if (res.statusCode == 200 || res.statusCode == 202) {
    List jsonResponse = json.decode(res.body);
    jsonResponse.map((data) => print(data));
    return jsonResponse
        .map((data) => AppointmentView.fromJson(data))
        // only show unbooked appointments
        .where((data) => !data.booked)
        .toList();
  } else {
    throw Exception('Failed to load availabilities');
  }
}

class _MyAppState extends State<AvailabilityPage> {
  late Future<List<AppointmentView>> futureData;

  @override
  void initState() {
    super.initState();
    print("init");
    futureData = getAvailabilities(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: DefaultAppbar(appbarText: "Availabilities",onPressed: () {
            Navigator.pop(context);
          },),
          body: Center(
              child: Column(
            children: [
              AppointmentsButton(buttonWidth:250,buttonHeight:60,iconSize:30,buttonText: "Add Availability", onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return addAvailabilityPage(user: widget.user);
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
                                child: dataBody(
                                    data, widget.user.value['usertype'])),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          )),
        ));
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
      ],
      rows: data
          .map(
            (appointmentView) => DataRow(cells: [
              DataCell(Text(appointmentView.date)),
              DataCell(Text(appointmentView.startTime)),
              DataCell(Text(appointmentView.endTime)),
            ]),
          )
          .toList(),
    ),
  );
}
