import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Container(
          child: Center(
            child: SpinKitFoldingCube(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
