import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../animation_effect.dart';
import 'coffee_tile.dart';

class CoffeeList extends StatefulWidget {
  final AnimationController screenController;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  const CoffeeList(
      {Key key,
      this.screenController,
      this.listSlideAnimation,
      this.listSlidePosition})
      : super(key: key);
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  static List<Coffee> _initialList = [];
  List<Coffee> _coffeeList;

  Duration _listRenderDelayDuration = const Duration(milliseconds: 150);

  bool hasListViewAnimatedAlready;
  int animatedlistItems = 0;
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
      animatedlistItems++;
    }
  }

  void _insertSingleItem(Coffee item, int index) {
    int insertIndex = _initialList.length;
    _initialList.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem(Coffee coffee) {
    int indexOfItem = _coffeeList.indexOf(coffee);
    Coffee removedItem = _coffeeList.removeAt(indexOfItem);

    _listKey.currentState.removeItem(
        indexOfItem,
        (context, animation) => AnimationEffect(
            child: CoffeeTile(coffee: removedItem),
            animationDouble: animation));
  }

  @override
  Widget build(BuildContext context) {
    _coffeeList = Provider.of<List<Coffee>>(context) ?? [];
    hasListViewAnimatedAlready = animatedlistItems == _coffeeList.length;
    return animateListTopDown(
        listSlideAnimation: widget.listSlideAnimation,
        screenController: widget.screenController,
        listSlidePosition: widget.listSlidePosition);
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

  AnimatedBuilder animateListTopDown(
      {AnimationController screenController,
      Animation<Alignment> listSlideAnimation,
      Animation<EdgeInsets> listSlidePosition}) {
    return AnimatedBuilder(
      animation: screenController,
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: listSlidePosition.value,
          child: Stack(
            alignment: listSlideAnimation.value,
            children: _coffeeList.reversed
                .toList()
                .asMap()
                .entries
                .map((item) => Container(
                    margin: listSlidePosition.value * (2.5 + item.key + 1),
                    // width: listTileWidth.value,
                    child: CoffeeTile(coffee: item.value)))
                .toList(),
          ),
        );
      },
    );
  }

  Widget animateListBottomUp() {
    if (hasListViewAnimatedAlready) {
      return ListView(
        key: _listKey,
        children: _coffeeList.map((item) => CoffeeTile(coffee: item)).toList(),
      );
    } else {
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
  }

  @override
  void dispose() {
    super.dispose();

    mounted = false;
    hasListViewAnimatedAlready = false;

    _initialList.clear();
  }
}
