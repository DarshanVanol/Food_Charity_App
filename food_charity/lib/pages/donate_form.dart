import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:food_charity/loading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:food_charity/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

// ignore: camel_case_types
class Donate_form extends StatefulWidget {
  final String donatorName, phone;

  const Donate_form({Key? key, required this.donatorName, required this.phone})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DonateformState();
  }
}

class DonateformState extends State<Donate_form> {
  bool loading = false;
  bool isCurrentLoc = true;
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  String _foodname = '';
  String _address = '';
  String _city = '';
  String valuechoose = '';
  String gv = '';
  String _plates = '0';
  String url = '';
  File? _imageFile;
  GeoPoint? gp;
  bool isDirection = true;

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

  Widget _buildaddress() {
    return TextFormField(
      validator: (val) => val!.isEmpty ? 'Field Required' : null,
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
      validator: (val) => val!.isEmpty ? 'Field Required' : null,
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
      validator: (val) => val!.isEmpty ? 'Field Required' : null,
      decoration: InputDecoration(labelText: 'no. of plates'),
      keyboardType: TextInputType.number,
      initialValue: '0',
      onChanged: (val) {
        _plates = val;
      },
    );
  }

  pickImage(ImageSource source, BuildContext context) async {
    final imagePicker = ImagePicker();
    PickedFile? _image;

    _image = await imagePicker
        .getImage(source: source)
        .whenComplete(() => Navigator.pop(context));
    setState(() {
      _imageFile = File(_image!.path);
    });
  }

  @override
  void initState() {
    getCurrentLoc();
    getCoords('jodhpur ahmedabad');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text('Please Upload Image !!'));
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Food details"),
              backgroundColor: Colors.blueAccent,
            ),
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
                      CircleAvatar(
                        backgroundImage:
                            _imageFile != null ? FileImage(_imageFile!) : null,
                        radius: 40,
                        child: Stack(children: [
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              context: context,
                              builder: (context) => Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // ignore: deprecated_member_use
                                      FlatButton.icon(
                                          onPressed: () => pickImage(
                                              ImageSource.gallery, context),
                                          icon: Icon(Icons.filter),
                                          label: Text('Storage')),
                                      // ignore: deprecated_member_use
                                      FlatButton.icon(
                                          onPressed: () => pickImage(
                                              ImageSource.camera, context),
                                          icon: Icon(Icons.camera_alt),
                                          label: Text('Camera')),
                                    ],
                                  )),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.amber,
                            ),
                          ),
                        ]),
                      ),
                      _buildfoodTittle(),
                      _buildfoodName(),
                      _buildfood(),
                      _buildplates(),
                      _buildaddress(),
                      CheckboxListTile(
                          title: Text('Use Current location'),
                          value: isCurrentLoc,
                          onChanged: (val) {
                            setState(() {
                              isCurrentLoc = val!;
                            });
                          }),
                      _buildcity(),
                      _buildfoodDesc(),
                      ListTile(
                        onTap: () async {
                          DateTime? tempDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
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
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        subtitle: Text(
                          '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          time = (await showTimePicker(
                              context: context, initialTime: TimeOfDay.now()))!;
                          setState(() {
                            // ignore: unnecessary_statements
                            time;
                          });
                        },
                        trailing: Icon(Icons.watch_later),
                        title: Text(
                          'Select Date',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        subtitle: Text(
                          '${time.hour}:${time.minute}',
                          style:
                              TextStyle(color: Colors.grey[900], fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 50),
                      // ignore: deprecated_member_use
                      FlatButton(
                          minWidth: 150,
                          height: 45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.blueAccent,
                          child: Text(
                            'Post',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var uid = auth.currentUser!.uid;
                              if (_imageFile != null) {
                                // ignore: unnecessary_statements
                                isCurrentLoc ? null : await getCoords(_address);

                                setState(() {
                                  loading = true;
                                });
                                await uploadImage(_imageFile!);
                                await DatabaseService()
                                    .uploadFoodData(
                                        url,
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
                                        gp,
                                        widget.donatorName,
                                        widget.phone,
                                        isDirection)
                                    .whenComplete(() {
                                  Navigator.pop(context);
                                });
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  getCurrentLoc() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {}
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        gp = GeoPoint(position.latitude, position.longitude);
      });
    }
  }

  getCoords(String address) async {
    final geoCode = GeocodingPlatform.instance;
    List<Location> loc =
        await geoCode.locationFromAddress(address, localeIdentifier: 'en_IND');

    print(loc);
    if (loc.isEmpty) {
      setState(() {
        isDirection = false;
      });
    } else {
      setState(() {
        gp = GeoPoint(loc.first.latitude, loc.first.longitude);
      });
    }
  }

  uploadImage(File file) async {
    String base = basename(file.path);

    final storage = FirebaseStorage.instance.ref().child('photos/$base');
    var snapshot =
        await storage.putFile(file).whenComplete(() => print('Uploaded'));

    String link = await snapshot.ref.getDownloadURL();
    setState(() {
      url = link;
    });
  }
}
