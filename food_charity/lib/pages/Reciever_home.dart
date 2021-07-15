import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/authenticate/logIn.dart';
import 'package:food_charity/pages/RecieverOrderStatus.dart';

import 'package:food_charity/pages/foodDetails.dart';
import 'package:food_charity/services/auth.dart';
import 'package:food_charity/services/database.dart';

// ignore: camel_case_types
class Reciever_home extends StatefulWidget {
  const Reciever_home({Key? key}) : super(key: key);

  @override
  _Reciever_homeState createState() => _Reciever_homeState();
}

// ignore: camel_case_types
class _Reciever_homeState extends State<Reciever_home> {
  String uid = '';
  String city = '';
  ScrollController scrollController = new ScrollController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthService auth = AuthService();
  String email = '';
  String name = '';
  Map<String, dynamic>? userDetails = new Map();
  Future getUserDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserData')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    userDetails = snapshot.data();
    setState(() {
      name = '${userDetails?['first']} ${userDetails?['last']}';
      email = (firebaseAuth.currentUser!.email)!;
    });
  }

  @override
  void initState() {
    setState(() {
      getUserDetails();
      // getItems();
      email = firebaseAuth.currentUser!.email!;
      uid = firebaseAuth.currentUser!.uid;
    });
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.lightBlue, Colors.blueAccent])),
                  accountName: Text(name),
                  accountEmail: Text(email)),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Orders'),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => RecieverOrderStatus()));
                },
              ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      width: width / 2,
                      height: 250,
                      decoration: BoxDecoration(color: Colors.blueAccent),
                    ),
                    Positioned(
                      left: width / 2,
                      child: Container(
                        width: width / 2,
                        height: 250,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: width,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              offset: Offset(20, -2),
                            )
                          ],
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width * 0.3))),
                      child: Column(
                        children: [
                          Text(
                            'Lets,\nFind a Food',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white70,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                            child: TextField(
                              onChanged: (cityValue) {
                                setState(() {
                                  city = cityValue;
                                });
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 5)),
                                  filled: true,
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  hintText: 'City',
                                  fillColor: Colors.white60,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.3))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 150,
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white24,
                                spreadRadius: 2,
                                offset: Offset(-20, 2),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * 0.3))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Which type of food you looking',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),

                              // from here.....
                              Container(
                                width: width,
                                height: height * 0.63,
                                child: StreamBuilder(
                                  stream:
                                      DatabaseService().reciveFoodData(city),
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
                                                    Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    FoodDetails(
                                                                      url: list[
                                                                              index]
                                                                          [
                                                                          'url'],
                                                                      address: list[
                                                                              index]
                                                                          [
                                                                          'address'],
                                                                      city: list[
                                                                              index]
                                                                          [
                                                                          'city'],
                                                                      date: list[
                                                                              index]
                                                                          [
                                                                          'date'],
                                                                      docId: id[
                                                                          index],
                                                                      donator: list[
                                                                              index]
                                                                          [
                                                                          'donator'],
                                                                      isVeg: list[
                                                                              index]
                                                                          [
                                                                          'isVeg'],
                                                                      name: list[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      phone: list[
                                                                              index]
                                                                          [
                                                                          'phone'],
                                                                      quantity:
                                                                          list[index]
                                                                              [
                                                                              'quantity'],
                                                                      recieverName:
                                                                          name,
                                                                      reciverId:
                                                                          uid,
                                                                      time: list[
                                                                              index]
                                                                          [
                                                                          'time'],
                                                                      tittle: list[
                                                                              index]
                                                                          [
                                                                          'tittle'],
                                                                      gp: list[
                                                                              index]
                                                                          [
                                                                          'geoPoint'],
                                                                      isDirection:
                                                                          list[index]
                                                                              [
                                                                              'isDirection'],
                                                                    )));
                                                  },
                                                  trailing: Image(
                                                    image: AssetImage(list[
                                                            index]['isVeg']
                                                        ? 'assets/veg_icon.png'
                                                        : 'assets/non_veg_icon.png'),
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                  isThreeLine: true,
                                                  leading: Hero(
                                                    tag: list[index]['tittle'],
                                                    child: CircleAvatar(
                                                      radius: 29,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              list[index]
                                                                  ['url']),
                                                    ),
                                                  ),
                                                  title: Text(
                                                      list[index]['tittle']),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(list[index]['name']),
                                                      Text(
                                                        list[index]['city'],
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          });
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
