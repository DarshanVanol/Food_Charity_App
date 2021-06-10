import 'package:flutter/material.dart';

class Donater_home extends StatefulWidget {
  const Donater_home({Key? key}) : super(key: key);

  @override
  _Donater_homeState createState() => _Donater_homeState();
}

class _Donater_homeState extends State<Donater_home> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/darsh.jpg'),
            ),
            accountName: Text('Darshansinh vanol'),
            accountEmail: Text('darshanvanol@gmail.com'),
          ),
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
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
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: Text(
                        'Hello,\nDonator',
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
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ListTile(
                              leading: Image(
                                image: AssetImage('assets/placeholder.png'),
                              ),
                              title: Text('Donating banana'),
                              tileColor: Colors.blueAccent,
                              subtitle: Text('Donated'),
                            ),
                            itemCount: 3,
                          )
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
    ));
  }
}
