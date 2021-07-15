import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/pages/Reciever_home.dart';
import 'package:food_charity/pages/donator_home.dart';
import 'package:food_charity/services/admin.dart';

class Choose extends StatefulWidget {
  const Choose({
    Key? key,
  }) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  bool? isAdmin;
  checkRole() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    final CollectionReference userDataCollection =
        FirebaseFirestore.instance.collection('UserData');
    DocumentSnapshot snapshot = await userDataCollection.doc(uid).get();
    setState(() {
      isAdmin = snapshot.get('isAdmin');
    });
    if (isAdmin == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Admin Privilage Acquired')));
    }
  }

  @override
  void initState() {
    checkRole();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.lightBlue,
          Colors.blueAccent,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/pablo.png',
                  height: height * 0.25,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Help a Needy',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Reduce Waste of Food',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 20,
                ),
                isAdmin == null
                    ? SizedBox(
                        height: 50,
                      )
                    : isAdmin == true
                        // ignore: deprecated_member_use
                        ? FlatButton(
                            height: 45,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.white70,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Admin(),
                                  ));
                            },
                            child: Text(
                              'Admin Panel',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 16),
                            ))
                        : SizedBox(
                            height: 70,
                          ),
                Option(
                    height: height,
                    width: width,
                    tittle: 'Donate Food',
                    object: Donater_home()),
                SizedBox(
                  height: 10,
                ),
                Option(
                  height: height,
                  width: width,
                  tittle: 'Recieve Food',
                  object: Reciever_home(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String tittle;
  final double width;
  final double height;
  final Widget object;
  const Option(
      {Key? key,
      required this.tittle,
      required this.width,
      required this.height,
      required this.object})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => object));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: width * 0.65,
          height: height * 0.17,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(5, 5),
                    spreadRadius: 2,
                    blurRadius: 2),
                BoxShadow(
                    color: Colors.white10,
                    offset: Offset(-5, -5),
                    spreadRadius: 2,
                    blurRadius: 2)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(width * 0.3))),
          child: Center(
            child: Text(
              tittle,
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
