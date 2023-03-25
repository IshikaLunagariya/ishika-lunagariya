import 'package:flutter/material.dart';

class MyAlwaysDisplayOn extends StatelessWidget {
  const MyAlwaysDisplayOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Text(
        "Clock Demo",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
