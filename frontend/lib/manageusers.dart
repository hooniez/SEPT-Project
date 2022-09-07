import 'package:flutter/material.dart';

import 'userlisting.dart';

class ManageUsers extends StatefulWidget {
  Map<int, String> users;
  final String userType;

  ManageUsers({Key? key, required this.users, required this.userType})
      : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  void _removeUser(int userId) {
    setState(() {
      widget.users.remove(userId);
    });
  }

  void _editUser(int userId, String newName) {
    setState(() {
      widget.users[userId] = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Manage ${widget.userType}s'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...widget.users.entries.map((entry) {
                    return UserListing(entry.key, widget.userType, entry.value,
                        _removeUser,
                        _editUser);
                  }).toList()
                ]
              )
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),

          ],
        ));
  }
}
