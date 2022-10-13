// ignore_for_file: sort_child_properties_last

import 'dart:convert';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/scrollercontroller.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'availabilityPage.dart';

class addAvailabilityPage extends StatefulWidget {
  final user;
  const addAvailabilityPage({Key? key, required this.user}) : super(key: key);

  @override
  State<addAvailabilityPage> createState() => _MyAppState();
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
}

class _MyAppState extends State<addAvailabilityPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();

  Future<Response> addAvailability() async {
    print(widget.user);
    String API_HOST = "10.0.2.2:8081";
    String PATH = "/availability";

    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': widget.user.value["Authorization"]
    };

    DateTime start = DateFormat("HH:mm").parse(starttimeController.text);
    DateTime end = DateFormat("HH:mm").parse(endtimeController.text);

    final body = {
      'date': dateController.text,
      'starttime': DateFormat("HH:mm").format(start),
      'endtime': DateFormat("HH:mm").format(end),
      'doctorName': widget.user.value['email'],
    };

    final url = Uri.http(API_HOST, PATH);

    print(url);
    print(body);
    final Response res =
        await post(url, headers: header, body: json.encode(body));
    print(res.body.toString());

    return res;
  }

  void setStarttime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      String formattedStarttime =
          TimeOfDay(hour: pickedTime.hour, minute: pickedTime.minute)
              .format(context);
      TimeOfDay endTime = pickedTime.addMinutes(30);
      String formattedEndtime =
          TimeOfDay(hour: endTime.hour, minute: endTime.minute).format(context);

      setState(() {
        starttimeController.text = formattedStarttime;
        endtimeController.text = formattedEndtime;
      });
    }
  }

  void saveAvailability() async {
    final isValidForm = _formKey.currentState!.validate();
    if (isValidForm) {
      var res = await addAvailability();
      if (res.body.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AvailabilityPage(user: widget.user);
        }));
      } else {
        print("empty");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 223, 28, 93),
                title: const Text("Neighbourhood Doctors"),
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
            body: SingleChildScrollView(
                controller: AdjustableScrollController(100),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: dateController,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.calendar_month),
                                            labelText:
                                                "Select a date to add availablity.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          readOnly: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please pick a valid date';
                                            } else {
                                              return null;
                                            }
                                          },
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2023));
                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);

                                              setState(() {
                                                dateController.text =
                                                    formattedDate;
                                              });
                                            }
                                          })),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: starttimeController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.access_time_outlined),
                                            labelText:
                                                "Select a time to create a half-hour availablity.",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          readOnly: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please pick a valid time';
                                            } else {
                                              return null;
                                            }
                                          },
                                          onTap: () {
                                            setStarttime();
                                          })),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: endtimeController,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.access_time_outlined),
                                          labelText:
                                              "End time of the half-hour availablity",
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        readOnly: true,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox(
                                      width: 300.0, // <-- match_parent
                                      height: 50.0, // <-- match-parent
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 144, 119, 151), // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          saveAvailability();
                                        },
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}

// https://stackoverflow.com/a/63324667
extension TimeOfDayExtension on TimeOfDay {
  // Ported from org.threeten.bp;
  TimeOfDay addMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      int mofd = this.hour * 60 + this.minute;
      int newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        int newHour = newMofd ~/ 60;
        int newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}
