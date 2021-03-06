import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
          child: const SpinKitChasingDots(
        color: Colors.brown,
        size: 50.0,
      )),
    );
  }
}
