import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coffee_tile.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>>(context) ?? [];
    coffees.forEach((coffee) {
      print(coffee.name);
      print(coffee.sugars);
      print(coffee.strength);
    });
    return ListView.builder(
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        return CoffeeTile(coffee: coffees[index]);
      },
    );
  }
}
