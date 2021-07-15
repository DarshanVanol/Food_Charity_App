import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/services/database.dart';
import 'package:map_launcher/map_launcher.dart';

class RecieverOrderStatus extends StatefulWidget {
  const RecieverOrderStatus({Key? key}) : super(key: key);

  @override
  _RecieverOrderStatusState createState() => _RecieverOrderStatusState();
}

class _RecieverOrderStatusState extends State<RecieverOrderStatus> {
  String uid = '';
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid;
    });

    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Orders'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: snapshot.hasData ? snapshot.data!.size : 0,
                itemBuilder: (context, index) {
                  List list = [];
                  List id = [];
                  for (var item in snapshot.data!.docs) {
                    list.add(item);
                    id.add(item.id);
                    print(item);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListTile(
                        onTap: () {
                          list[index]['status'] == 'Accepted'
                              ? showDialog(
                                  context: context,
                                  builder: (context) => DialogueBox(
                                    address: list[index]['address'],
                                    city: list[index]['city'],
                                    donator: list[index]['donator'],
                                    foodName: list[index]['name'],
                                    isDirection: list[index]['isDirection'],
                                    phone: list[index]['phone'],
                                    tittle: list[index]['tittle'],
                                    gp: list[index]['geoPoint'],
                                  ),
                                )
                              // ignore: unnecessary_statements
                              : null;
                        },
                        trailing: Image(
                          image: AssetImage(list[index]['isVeg']
                              ? 'assets/veg_icon.png'
                              : 'assets/non_veg_icon.png'),
                          width: 30,
                          height: 30,
                        ),
                        isThreeLine: true,
                        leading: CircleAvatar(
                          radius: 29,
                          backgroundImage: NetworkImage(list[index]['url']),
                        ),
                        title: Text(list[index]['tittle']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index]['name']),
                            list[index]['status'] == 'Donated'
                                ? Text('Recived',
                                    style: TextStyle(color: Colors.green))
                                : list[index]['status'] == 'Accepted'
                                    ? Text(
                                        list[index]['status'],
                                        style: TextStyle(
                                            color: Colors.orange[200]),
                                      )
                                    : Text(list[index]['status']),
                          ],
                        )),
                  );
                });
          }
        },
        stream: DatabaseService().orderStatus(uid),
      ),
    );
  }
}

class DialogueBox extends StatelessWidget {
  final String foodName, tittle, phone, donator, city, address;
  final bool isDirection;
  final GeoPoint gp;
  const DialogueBox(
      {Key? key,
      required this.foodName,
      required this.tittle,
      required this.phone,
      required this.donator,
      required this.city,
      required this.address,
      required this.isDirection,
      required this.gp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Container(
          height: 240,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                tittle,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  buildText(text: 'Food Name:'),
                  buildSubText(text: foodName)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(text: 'Donator:'),
                  buildSubText(text: donator)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [buildText(text: 'City'), buildSubText(text: city)],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(text: 'Address:'),
                  buildSubText(text: address)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [buildText(text: 'Phone'), buildSubText(text: phone)],
              ),
              SizedBox(
                height: 5,
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                  icon: Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {
                    final ismapAvailable =
                        await MapLauncher.isMapAvailable(MapType.google);
                    if (ismapAvailable == null) {
                      print('returning null');
                    } else {
                      MapLauncher.showDirections(
                          mapType: MapType.google,
                          destination: Coords(gp.latitude, gp.longitude));
                    }
                  },
                  label: Text(
                    'Get Direction',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class buildSubText extends StatelessWidget {
  final String text;
  const buildSubText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey[700], fontStyle: FontStyle.italic, fontSize: 16),
    );
  }
}

// ignore: camel_case_types
class buildText extends StatelessWidget {
  final String text;
  const buildText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}
