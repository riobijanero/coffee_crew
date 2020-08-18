import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final bool isMyCoffee;
  final Function onTap;

  const CoffeeTile({this.coffee, this.isMyCoffee, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: const Color(0xFF6CA8F1),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.white, width: 1.0),
          ),
          margin: const EdgeInsets.only(
              left: 15.0, top: 6.0, right: 15.0, bottom: 0.0),
          child: ListTile(
            trailing: (isMyCoffee != null) ? Text('Edit My Order') : null,
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[coffee.strength],
              backgroundImage: AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(
              coffee.name,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Takes ${coffee.sugars} sugar(s)',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
