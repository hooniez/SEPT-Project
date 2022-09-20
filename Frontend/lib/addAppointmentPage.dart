import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:frontend/scrollercontroller.dart';

// import 'dart:html';

import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'appointmentPage.dart';

class AddAppointmentPage extends StatefulWidget {
  final user;

  const AddAppointmentPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AddAppointmentPage> createState() => _MyAppState();
}

class AppointmentView {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  String patientName;
  final String doctorName;
  bool booked;

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

  final url = Uri.http(API_HOST, APPOINTMENT_PATH);

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

class _MyAppState extends State<AddAppointmentPage> {
  late Future<List<AppointmentView>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getAvailabilities(widget.user);
  }

  void addAppointment(AppointmentView appointmentView) async {
    String API_HOST = "10.0.2.2:8081";
    String APPOINTMENT_PATH = "/appointment";

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': '<Your token>'
    };

    final url = Uri.http(API_HOST, APPOINTMENT_PATH);

    final body = {
      'id': appointmentView.id,
      'patientName': widget.user.value['email'],
    };

    final Response res =
        await put(url, headers: header, body: json.encode(body));
    print(res.body.toString());
    if (res.body.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AppointmentPage(user: widget.user);
      }));
    } else {
      print("empty");
    }
  }

  SingleChildScrollView dataBody(List<AppointmentView> data) {
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
            label: Text("Doctor Name"),
          ),
        ],
        rows: data
            .map(
              (appointmentView) => DataRow(
                onSelectChanged: (selected) {
                  addAppointment(appointmentView);
                },
                cells: [
                  DataCell(Text(appointmentView.date)),
                  DataCell(Text(appointmentView.startTime)),
                  DataCell(Text(appointmentView.endTime)),
                  DataCell(Text(appointmentView.doctorName)),
                ],
              ),
            )
            .toList(),
      ),
    );
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
              child: Column(
            children: [
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
                          const Text("Tap on a time slot to book."),
                          Expanded(
                            child: FittedBox(
                                alignment: Alignment.topCenter,
                                child: dataBody(data)),
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
