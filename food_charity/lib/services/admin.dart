import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_charity/authenticate/logIn.dart';
import 'package:food_charity/services/adminService.dart';
import 'package:food_charity/services/auth.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int noOfUser = 0;
  String uid = '';
  String first = 'Someone';
  String last = 'Someone';
  String isAdmin = 'Nill';
  String email = 'test@gmail.com';
  String phone = '0000000000';
  String currentUserEmail = '';
  String currentUserName = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService auth = AuthService();
  Map userDetails = Map();
  String chooseValue = 'True';
  Future getUserDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    userDetails = snapshot.data()!;
    setState(() {
      currentUserName = '${userDetails['first']} ${userDetails['last']}';
      currentUserEmail = (firebaseAuth.currentUser!.email)!;
    });
  }

  @override
  void initState() {
    getUserDetails();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue, Colors.blueAccent])),
                accountName: Text(currentUserName),
                accountEmail: Text(currentUserEmail)),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () async {
                var user = firebaseAuth.currentUser;
                print('before user---$user');
                await auth.logOut();
                if (firebaseAuth.currentUser == null) {
                  print(firebaseAuth.currentUser);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                      (route) => false);
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Welcome Admin',
                  style: TextStyle(color: Colors.white70, fontSize: 23),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber[600],
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 270,
                          height: 40,
                          child: TextField(
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 2),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'test@gmail.com',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () => getData(email),
                        color: Colors.white,
                        child: Text('Get Data',
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'UID : ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    uid,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'FIRST NAME : ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    first,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'LAST NAME : ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    last,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'IS ADMIN? : ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    isAdmin,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'PHONE : ',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    phone,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                      uid.isEmpty
                          ? SizedBox(
                              height: 20,
                            )
                          // ignore: deprecated_member_use
                          : RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => updateData(
                                          uid: uid,
                                          isAdmin: isAdmin,
                                        )).whenComplete(() => getData(email));
                              },
                              color: Colors.white,
                              child: Text('Update Role of User',
                                  style: TextStyle(color: Colors.blueAccent)),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              // ignore: deprecated_member_use
              RaisedButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Colors.blueAccent,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CreateUser(),
                      ));
                },
                color: Colors.white,
                label: Text('Add New User',
                    style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getData(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Query query =
        firestore.collection('UserData').where('email', isEqualTo: email);
    QuerySnapshot snapshot = await query.get();

    Map map = snapshot.docs.first.data();
    setState(() {
      first = map['first'];
      last = map['last'];
      isAdmin = map['isAdmin'].toString();
      phone = map['phone'];
      uid = snapshot.docs.first.id;
    });
  }
}

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _phone = '';
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Add New User',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'required' : null,
                        onSaved: (val) {
                          setState(() {
                            _firstName = val!;
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'First Name'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'required' : null,
                        onSaved: (val) {
                          setState(() {
                            _lastName = val!;
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Last Name'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'required' : null,
                        onSaved: (val) {
                          setState(() {
                            _email = val!;
                          });
                        },
                        initialValue: _firstName,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) => val!.length >= 6
                            ? 'lenght must be greater than 6 character'
                            : null,
                        onSaved: (val) {
                          setState(() {
                            _password = val!;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (val) => val!.isEmpty ? 'required' : null,
                        onSaved: (val) {
                          setState(() {
                            _phone = val!;
                          });
                        },
                        initialValue: _firstName,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Phone'),
                      ),
                    ],
                  ),
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      createNewUser(_email, _password);
                    }
                  },
                  child: Text(
                    'Create New User',
                    style: TextStyle(color: Colors.blueAccent),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  createNewUser(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        String uid = user.user!.uid;

        await firebaseFirestore.collection('UserData').doc(uid).set({
          "first": _firstName,
          "last": _lastName,
          "phone": _phone,
          "isAdmin": false,
        }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User Created Successfully'))));

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
