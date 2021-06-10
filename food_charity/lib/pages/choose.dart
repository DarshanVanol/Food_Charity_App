import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                options('Donate Food', width, height),
                SizedBox(
                  height: 10,
                ),
                options('Recieve Food', width, height)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget options(String tittle, double width, double height) {
  return InkWell(
    onTap: () {},
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
