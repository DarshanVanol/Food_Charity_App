import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class FoodDetails extends StatefulWidget {
  final String name,
      address,
      city,
      quantity,
      tittle,
      donator,
      phone,
      docId,
      recieverName,
      reciverId,
      url;

  final GeoPoint gp;
  final bool isVeg, isDirection;
  final Timestamp date;
  final String time;
  const FoodDetails({
    Key? key,
    required this.name,
    required this.address,
    required this.city,
    required this.quantity,
    required this.time,
    required this.date,
    required this.docId,
    required this.donator,
    required this.isVeg,
    required this.phone,
    required this.recieverName,
    required this.reciverId,
    required this.tittle,
    required this.url,
    required this.gp,
    required this.isDirection,
  }) : super(key: key);

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.date.toDate();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Hero(
              tag: widget.tittle,
              child: Container(
                height: size.height * 0.35,
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 40),
                      bottomRight: Radius.elliptical(200, 40),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.url))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.tittle,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.blueAccent,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                        Image(
                          image: AssetImage(widget.isVeg
                              ? 'assets/veg_icon.png'
                              : 'assets/non_veg_icon.png'),
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        buildText(
                          text: 'Food Name: ',
                        ),
                        buildSubText(
                          text: widget.name,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        buildText(
                          text: 'Quantity: ',
                        ),
                        buildSubText(
                          text: widget.quantity,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        buildText(
                          text: 'Donator: ',
                        ),
                        buildSubText(
                          text: widget.donator,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BuildBox(
                          size: size,
                          widget: widget,
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.grey[700],
                          ),
                          text: 'City',
                          subtext: widget.city,
                        ),
                        BuildBox(
                          size: size,
                          widget: widget,
                          icon: Icon(
                            Icons.access_time_filled,
                            color: Colors.grey[700],
                          ),
                          text: 'Time',
                          subtext: widget.time,
                        ),
                        BuildBox(
                          size: size,
                          widget: widget,
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey[700],
                          ),
                          text: 'Date',
                          subtext:
                              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildText(
                      text: 'Address',
                    ),
                    buildSubText(
                      text: widget.address,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildText(
                      text: 'Phone',
                    ),
                    buildSubText(
                      text: widget.phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.isDirection
                        // ignore: deprecated_member_use
                        ? FlatButton.icon(
                            icon: Icon(
                              Icons.directions,
                              color: Colors.white,
                            ),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onPressed: () async {
                              final ismapAvailable =
                                  await MapLauncher.isMapAvailable(
                                      MapType.google);
                              if (ismapAvailable == null) {
                                print('returning null');
                              } else {
                                MapLauncher.showDirections(
                                    mapType: MapType.google,
                                    destination: Coords(widget.gp.latitude,
                                        widget.gp.longitude));
                              }
                            },
                            label: Text(
                              'Get Direction',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                        : SizedBox(
                            height: 10,
                          ),
                    // ignore: deprecated_member_use
                    FlatButton(
                        height: size.height * 0.065,
                        minWidth: size.width * 0.5,
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('DonatedFood')
                              .doc(widget.docId)
                              .update({
                            "recieverId": widget.reciverId,
                            "status": 'Accepted',
                            "reciever": widget.recieverName
                          }).whenComplete(() => Navigator.pop(context));
                        },
                        child: Text(
                          'Accept Donation',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildBox extends StatelessWidget {
  const BuildBox({
    Key? key,
    required this.size,
    required this.widget,
    required this.icon,
    required this.text,
    required this.subtext,
  }) : super(key: key);

  final Size size;
  final FoodDetails widget;
  final Icon icon;
  final String text, subtext;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.1,
        width: size.width * 0.25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4, 4),
                  blurRadius: 3,
                  spreadRadius: 1.5)
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 7,
          ),
          icon,
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Text(
            subtext,
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
        ]));
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
      maxLines: 2,
      style: TextStyle(
          color: Colors.grey[700], fontStyle: FontStyle.italic, fontSize: 17),
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
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 17, color: Colors.blue),
    );
  }
}
