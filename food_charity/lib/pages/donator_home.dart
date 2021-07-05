import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/authenticate/logIn.dart';
import 'package:food_charity/pages/don_dialogue.dart';
import 'package:food_charity/pages/donate_form.dart';
import 'package:food_charity/services/auth.dart';
import 'package:food_charity/services/database.dart';

// ignore: camel_case_types
class Donater_home extends StatefulWidget {
  const Donater_home({Key? key}) : super(key: key);

  @override
  _Donater_homeState createState() => _Donater_homeState();
}

// ignore: camel_case_types
class _Donater_homeState extends State<Donater_home> {
  String filter = 'all';
  String DonatorName = '';
  String email = '';
  String uid = '';
  Map<String, dynamic>? userDetails = new Map();
  Future getUserDetails() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('UserData').doc(uid).get();

    userDetails = snapshot.data();
    setState(() {
      DonatorName = '${userDetails?['first']} ${userDetails?['last']}';
      email = (firebaseAuth.currentUser!.email)!;
    });
  }

  List _option = ['ALL', 'POSTED', 'BOOKED', 'DONATED'];
  List<Widget> chips = [];
  int _selectedIndex = 0;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService auth = AuthService();
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    uid = firebaseAuth.currentUser!.uid;
    getUserDetails();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(DonatorName),
            accountEmail: Text(email),
          ),
          ListTile(
            title: Text('LogOut'),
            onTap: () async {
              var user = firebaseAuth.currentUser;

              await auth.logOut();
              if (firebaseAuth.currentUser == null) {
                print(firebaseAuth.currentUser);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                    (route) => false);
              }
            },
          )
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          tooltip: 'Donate here',
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Donate_form(
                          donatorName: DonatorName,
                          phone: userDetails?['phone'],
                        )));
          },
          child: Text(
            'Donate',
            style: TextStyle(fontSize: 11),
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        'Hello,\n$DonatorName',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: Container(
                      width: width,
                      height: MediaQuery.of(context).size.height - 230,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(80))),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              'STATUS',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: Colors.blueAccent,
                            thickness: 4,
                            indent: 160,
                            endIndent: 160,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ChoiceChip(
                                label: _selectedIndex == 0
                                    ? Text(
                                        'ALL',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text('ALL'),
                                selected: _selectedIndex == 0,
                                selectedColor: Colors.blueAccent,
                                disabledColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedIndex = 0;
                                    }
                                    filter = 'all';
                                  });
                                },
                              ),
                              ChoiceChip(
                                selectedColor: Colors.blueAccent,
                                disabledColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                label: _selectedIndex == 1
                                    ? Text(
                                        'POSTED',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text('POSTED'),
                                selected: _selectedIndex == 1,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedIndex = 1;
                                    }
                                    filter = 'uploaded';
                                  });
                                },
                              ),
                              ChoiceChip(
                                selectedColor: Colors.blueAccent,
                                disabledColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                label: _selectedIndex == 2
                                    ? Text(
                                        'BOOKED',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text('BOOKED'),
                                selected: _selectedIndex == 2,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedIndex = 2;
                                      filter = 'booked';
                                    }
                                  });
                                },
                              ),
                              ChoiceChip(
                                selectedColor: Colors.blueAccent,
                                disabledColor: Colors.grey[300],
                                labelStyle: TextStyle(color: Colors.grey[800]),
                                label: _selectedIndex == 3
                                    ? Text(
                                        'DONATED',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text('DONATED'),
                                selected: _selectedIndex == 3,
                                onSelected: (bool selected) {
                                  setState(() {
                                    if (selected) {
                                      _selectedIndex = 3;
                                      filter = 'donated';
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                          Container(
                            height: 450,
                            child: StreamBuilder(
                                stream:
                                    DatabaseService().donateStatus(uid, filter),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container(
                                        height: 50,
                                        width: 50,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            CircularProgressIndicator(),
                                          ],
                                        ));
                                  } else {
                                    return ListView.builder(
                                        controller: scrollController,
                                        shrinkWrap: true,
                                        itemCount: snapshot.hasData
                                            ? snapshot.data!.size
                                            : 0,
                                        itemBuilder: (context, index) {
                                          List list = [];
                                          List id = [];
                                          for (var item
                                              in snapshot.data!.docs) {
                                            list.add(item);
                                            id.add(item.id);
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: ListTile(
                                                onTap: () {
                                                  list[index]['status'] ==
                                                          'Booked'
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              DonDialogue(
                                                                  docId:
                                                                      id[index],
                                                                  foodName: list[
                                                                          index]
                                                                      ['name'],
                                                                  recieverName:
                                                                      list[index]
                                                                          [
                                                                          'reciever']),
                                                        )
                                                      : null;
                                                },
                                                trailing: Image(
                                                  image: AssetImage(list[index]
                                                          ['isVeg']
                                                      ? 'assets/veg_icon.png'
                                                      : 'assets/non_veg_icon.png'),
                                                  width: 30,
                                                  height: 30,
                                                ),
                                                isThreeLine: true,
                                                leading: Image(
                                                  height: 40,
                                                  image: AssetImage(
                                                      'assets/placeholder.png'),
                                                ),
                                                title:
                                                    Text(list[index]['tittle']),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(list[index]['name']),
                                                    list[index]['status'] ==
                                                            'Donated'
                                                        ? Text(
                                                            list[index]
                                                                ['status'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green))
                                                        : list[index][
                                                                    'status'] ==
                                                                'Booked'
                                                            ? Text(
                                                                list[index]
                                                                    ['status'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .orange[
                                                                        200]),
                                                              )
                                                            : Text(list[index]
                                                                ['status']),
                                                  ],
                                                )),
                                          );
                                        });
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
