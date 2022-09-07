import 'package:flutter/material.dart';

class UserListing extends StatefulWidget {
  final int userId;
  String userName;
  final String userType;
  final Function removeUser;
  final Function editUser;
  UserListing(this.userId, this.userType, this.userName, this.removeUser,
      this.editUser);

  @override
  State<UserListing> createState() => _UserListingState();
}

class _UserListingState extends State<UserListing> {
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                widget.userType,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.userName,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Edit")),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                labelText: "Name"),
                                            controller: nameController,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RaisedButton(
                                              child: Text("Save"),
                                              onPressed: () {
                                                widget.editUser(widget.userId,
                                                    nameController.text);
                                                Navigator.of(context).pop();
                                              },
                                            ))
                                      ]),
                                ),
                              ]),
                            );
                          });
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        primary: Colors.blue,
                        side: BorderSide(
                          color: Colors.blue,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                    onPressed: () {
                      widget.removeUser(widget.userId);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        primary: Colors.red,
                        side: BorderSide(
                          color: Colors.red,
                        ))),
              ),
            ])
          ],
        ));
  }
}
