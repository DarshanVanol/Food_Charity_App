import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/services/database.dart';

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
                        onTap: () {},
                        trailing: Image(
                          image: AssetImage(list[index]['isVeg']
                              ? 'assets/veg_icon.png'
                              : 'assets/non_veg_icon.png'),
                          width: 30,
                          height: 30,
                        ),
                        isThreeLine: true,
                        leading: Image(
                          height: 40,
                          image: AssetImage('assets/placeholder.png'),
                        ),
                        title: Text(list[index]['tittle']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index]['name']),
                            list[index]['status'] == 'Donated'
                                ? Text('Recived',
                                    style: TextStyle(color: Colors.green))
                                : list[index]['status'] == 'Booked'
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
