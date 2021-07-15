import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailDialogue extends StatelessWidget {
  final String name, quantity, tittle, docId;

  const DetailDialogue({
    Key? key,
    required this.name,
    required this.quantity,
    required this.tittle,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 210,
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

              buildText(
                text: 'Food Name',
              ),
              buildSubText(
                text: name,
              ),
              SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

              SizedBox(
                height: 15,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('DonatedFood')
                        .doc(docId)
                        .delete()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text(
                    'Cancel Donation',
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
