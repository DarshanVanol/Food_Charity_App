import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonDialogue extends StatelessWidget {
  final String recieverName, foodName, docId, url;
  const DonDialogue(
      {Key? key,
      required this.recieverName,
      required this.foodName,
      required this.docId,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 300,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                    tag: url,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                  Text(
                    foodName,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your Food is Accepted by ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    recieverName,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'is Food Donated ?',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ignore: deprecated_member_use
                      FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('DonatedFood')
                                .doc(docId)
                                .update({
                              "status": 'Donated',
                            }).whenComplete(() => Navigator.pop(context));
                          },
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          )),
                      // ignore: deprecated_member_use
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Not yet',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
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
