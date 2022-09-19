import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';
import 'addAvailabilityPage.dart';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';

class AddAvailabilityPage extends StatefulWidget {
  final user;

  const AddAvailabilityPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AddAvailabilityPage> createState() => _MyAppState();
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
  String API_HOST = "10.0.2.2:8081";
  String APPOINTMENT_PATH = "/appointment/all";

  final queryParameters = {
    'email': user.value['email'],
    'usertype': user.value['usertype']
  };

  final url = Uri.http(API_HOST, APPOINTMENT_PATH, queryParameters);

  print(url);
  final Response res = await get(url);
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
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 223, 28, 93),
            title: const Center(child: Text("Neighbourhood Doctors")),
          ),
          body: Center(
              child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 144, 119, 151), // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text(
                  'Add Availability',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return addAvailabilityPage(user: widget.user);
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
                          const Text("Your Availabilities"),
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
                    return CircularProgressIndicator();
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
