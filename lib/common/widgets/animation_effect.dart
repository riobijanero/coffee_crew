import 'package:flutter/material.dart';

class AnimationEffect extends StatefulWidget {
  final Widget child;
  final Animation<double> animationDouble;

  const AnimationEffect({
    Key key,
    this.child,
    this.animationDouble,
  }) : super(key: key);
  @override
  _AnimationEffectState createState() => _AnimationEffectState();
}

class _AnimationEffectState extends State<AnimationEffect>
    with TickerProviderStateMixin {
  AnimationController _slideUpAnimationController;
  Animation<Offset> _slideAnimation;
  AnimationController _fadeAnimationController;
  dynamic _fadeAnimation;
  CurvedAnimation _curvedAnimation;

  Duration _slideUpDuration = Duration(milliseconds: 300);
  Duration _fadeDuration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _slideUpAnimationController = AnimationController(
      vsync: this,
      duration: _slideUpDuration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _slideUpAnimationController,
      curve: Curves.linear,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.8),
      end: Offset.zero,
    ).animate(_curvedAnimation);

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: _fadeDuration,
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      _fadeAnimationController,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationDouble == null) {
      _fadeAnimationController.forward();
    }
    _slideUpAnimationController.forward();
    return FadeTransition(
      opacity: widget.animationDouble != null
          ? widget.animationDouble
          : _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SlideTransition(
  //     position: _slideAnimation,
  //     child: widget.child,
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    _slideUpAnimationController.dispose();
    _fadeAnimationController.dispose();
    // _removeAllItems();
  }
}
