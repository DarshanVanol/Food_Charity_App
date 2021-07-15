import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class updateData extends StatefulWidget {
  final String isAdmin, uid;
  const updateData({
    Key? key,
    required this.isAdmin,
    required this.uid,
  }) : super(key: key);

  @override
  _updateDataState createState() => _updateDataState();
}

// ignore: camel_case_types
class _updateDataState extends State<updateData> {
  String? chooseValue;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  'Assign Role to User',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Is Admin:'),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                        hint: Text(widget.isAdmin),
                        value: chooseValue,
                        onChanged: (val) {
                          setState(() {
                            chooseValue = val!;
                          });
                        },
                        items: <String>['true', 'false']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList()),
                  ],
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blueAccent,
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      if (chooseValue != null) {
                        bool val;
                        if (chooseValue == 'true')
                          val = true;
                        else
                          val = false;

                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;

                        await firestore
                            .collection('UserData')
                            .doc(widget.uid)
                            .update({
                          'isAdmin': val,
                        }).whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Updated')));
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Choose User Role')));
                      }
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
