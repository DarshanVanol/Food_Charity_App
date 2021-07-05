import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/services/database.dart';

// ignore: camel_case_types
class Donate_form extends StatefulWidget {
  final String donatorName, phone;

  const Donate_form({Key? key, required this.donatorName, required this.phone})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return Donate_formState();
  }
}

class Donate_formState extends State<Donate_form> {
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String _foodname = '';
  String _foodtype = '';
  String _address = '';
  String _city = '';
  String valuechoose = '';
  String gv = '';
  String _plates = '';

  String _tittle = '';
  String desc = 'nill';
  bool isVeg = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  List l = ["light food", "heavy food", "breakfast"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildfoodName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'food Name'),
      validator: (val) => val!.isEmpty ? 'food name is Required' : null,
      onChanged: (val) {
        setState(() {
          _foodname = val;
        });
      },
    );
  }

  Widget _buildfoodDesc() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 3,
      onChanged: (val) {
        setState(() {
          desc = val;
        });
      },
    );
  }

  Widget _buildfoodTittle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Tittle'),
      validator: (val) => val!.isEmpty ? 'Required' : null,
      onChanged: (val) {
        setState(() {
          _tittle = val;
        });
      },
    );
  }

  Widget _buildfood() {
    return Row(
      children: [
        Row(
          children: [
            Radio(
                value: 'veg',
                groupValue: gv,
                onChanged: (val) {
                  gv = val.toString();

                  setState(() {
                    isVeg = true;
                  });
                }),
            Text(
              'veg',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: [
            Radio(
                value: 'Non-veg',
                groupValue: gv,
                onChanged: (val) {
                  gv = val.toString();
                  setState(() {
                    isVeg = false;
                  });
                }),
            Text(
              'Non-veg',
              style: TextStyle(color: Colors.black),
            )
          ],
        )
      ],
    );
  }

  Widget _buildfoodtype() {
    return Row(
      children: [
        Text('select food type', style: TextStyle(color: Colors.black)),
        SizedBox(width: 60),
        Container(
          child: DropdownButton(
            hint: Text('--select--'),
            dropdownColor: Colors.grey,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            value: valuechoose.toString(),
            onChanged: (newValue) {
              setState(() {
                valuechoose = newValue.toString();
              });
            },
            items: l.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildaddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      maxLines: 3,
      onChanged: (val) {
        setState(() {
          _address = val;
        });
      },
    );
  }

  Widget _buildcity() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'city'),
      onChanged: (val) {
        setState(() {
          _city = val;
        });
      },
    );
  }

  Widget _buildplates() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'no. of plates'),
      keyboardType: TextInputType.number,
      initialValue: '0',
      onChanged: (val) {
        _plates = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food details")),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildfoodTittle(),
                _buildfoodName(),
                _buildfood(),
                _buildplates(),
                _buildaddress(),
                _buildcity(),
                _buildfoodDesc(),
                // Row(
                //   children: [
                //     TextFormField(
                //       decoration: Inp,
                //       enabled: false,
                //       initialValue: (00).toString(),
                //     ),
                //     TextButton(onPressed: () {}, child: Text('Pick Time'))
                //   ],
                // ),
                ListTile(
                  onTap: () async {
                    DateTime? tempDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1));
                    setState(() {
                      if (tempDate != null) {
                        dateTime = tempDate;
                      }
                    });
                  },
                  trailing: Icon(Icons.date_range),
                  title: Text(
                    'select Date',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  subtitle: Text(
                    '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                    style: TextStyle(color: Colors.grey[900], fontSize: 16),
                  ),
                ),

                ListTile(
                  onTap: () async {
                    time = (await showTimePicker(
                        context: context, initialTime: TimeOfDay.now()))!;
                    setState(() {
                      time;
                    });
                  },
                  trailing: Icon(Icons.watch_later),
                  title: Text(
                    'Select Date',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  subtitle: Text(
                    '${time.hour}:${time.minute}',
                    style: TextStyle(color: Colors.grey[900], fontSize: 16),
                  ),
                ),
                SizedBox(height: 50),
                RaisedButton(
                    child: Text(
                      'post',
                      style:
                          TextStyle(color: Colors.blue.shade500, fontSize: 16),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var uid = auth.currentUser!.uid;

                        await DatabaseService()
                            .uploadFoodData(
                                dateTime,
                                time,
                                _tittle,
                                _foodname,
                                isVeg,
                                _plates,
                                _city,
                                _address,
                                desc,
                                uid,
                                widget.donatorName,
                                widget.phone)
                            .whenComplete(() {
                          Navigator.pop(context);
                        });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
