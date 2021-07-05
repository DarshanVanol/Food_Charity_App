import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_charity/pages/Reciever_home.dart';
import 'package:food_charity/pages/donator_home.dart';

class Choose extends StatefulWidget {
  const Choose({Key? key}) : super(key: key);

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          height: height * 0.19,
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
