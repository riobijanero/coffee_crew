import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget child;

  const BottomSheetContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25)),
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 1, color: Colors.blue[300], spreadRadius: 1)
        // ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
      child: child,
    );
  }
}
