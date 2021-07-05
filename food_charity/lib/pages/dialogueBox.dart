import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailDialogue extends StatelessWidget {
  final String name,
      address,
      city,
      quantity,
      tittle,
      donator,
      phone,
      docId,
      recieverName,
      reciverId;
  final bool isVeg;
  final Timestamp date;
  final String time;

  const DetailDialogue({
    Key? key,
    required this.name,
    required this.address,
    required this.city,
    required this.quantity,
    required this.tittle,
    required this.donator,
    required this.phone,
    required this.isVeg,
    required this.docId,
    required this.recieverName,
    required this.date,
    required this.time,
    required this.reciverId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = date.toDate();
    return Dialog(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                height: 15,
              ),
              Row(
                children: [
                  buildText(
                    text: 'Food Name: ',
                  ),
                  buildSubText(
                    text: name,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'is Veg: ',
                  ),
                  buildSubText(
                    text: '$isVeg',
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
                    text: quantity,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'City: ',
                  ),
                  buildSubText(
                    text: city,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'Address: ',
                  ),
                  buildSubText(
                    text: address,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'Date of Picking: ',
                  ),
                  buildSubText(
                    text: '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'Time of Picking: ',
                  ),
                  buildSubText(
                    text: time,
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
                    text: donator,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  buildText(
                    text: 'Phone: ',
                  ),
                  buildSubText(
                    text: phone,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('DonatedFood')
                        .doc(docId)
                        .update({
                      "reciverId": reciverId,
                      "status": 'Booked',
                      "reciever": recieverName
                    }).whenComplete(() => Navigator.pop(context));
                  },
                  child: Text(
                    'Book Now',
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
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}
