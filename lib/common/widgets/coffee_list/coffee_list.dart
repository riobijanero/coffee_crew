import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../animation_effect.dart';
import 'coffee_tile.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  static List<Coffee> _initialList = [];
  List<Coffee> _coffeeList;

  Duration _listRenderDelayDuration = Duration(milliseconds: 150);

  bool hasListViewAnimatedAlready = false;
  bool mounted = true;

  void populateListWithDelay() async {
    _removeAllItems();
    _initialList.clear();
    for (Coffee coffee in _coffeeList) {
      int indexOfItem = _coffeeList.indexOf(coffee);
      try {
        await Future.delayed(_listRenderDelayDuration, () {
          if (mounted) {
            if (!_initialList.contains(coffee)) {
              _insertSingleItem(coffee, indexOfItem);
            }
          }
        });
      } catch (e) {
        print(e);
      }
    }
    hasListViewAnimatedAlready = true;
  }

  void _insertSingleItem(Coffee item, int index) {
    int insertIndex = _initialList.length;
    _initialList.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

  @override
  Widget build(BuildContext context) {
    _coffeeList = Provider.of<List<Coffee>>(context) ?? [];
    populateListWithDelay();
    return AnimatedList(
      key: _listKey,
      initialItemCount: _initialList.length,
      itemBuilder: (context, index, animation) {
        return AnimationEffect(
          animationDouble: animation,
          child: CoffeeTile(coffee: _coffeeList[index]),
        );
      },
    );
  }

  void _removeAllItems() {
    final length = _initialList.length;
    for (int i = length - 1; i >= 0; i--) {
      Coffee removedItem = _initialList.removeAt(i);
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        return AnimationEffect(
            child: CoffeeTile(coffee: removedItem), animationDouble: animation);
      };
      _listKey.currentState.removeItem(i, builder);
    }
  }

  @override
  void dispose() {
    super.dispose();

    mounted = false;

    _initialList.clear();
  }
}

/*
import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coffee_tile.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  static List<Coffee> _initialList = [];
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>>(context) ?? [];
    coffees.forEach((coffee) {
      print(coffee.name);
      print(coffee.sugars);
      print(coffee.strength);
    });
    return AnimatedList(
      key: _listKey,
      initialItemCount: coffees.length,
      itemBuilder: (context, index, animation) {
        return CoffeeTile(coffee: coffees[index]);
      },
    );
  }
}
*/