import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedScaleCharacter extends StatefulWidget {
  const AnimatedScaleCharacter({super.key});

  @override
  _AnimatedScaleCharacterState createState() => _AnimatedScaleCharacterState();
}

class _AnimatedScaleCharacterState extends State<AnimatedScaleCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _rotationAnimation;
  late Animation _dropAnimation;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _rotationAnimation = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _dropAnimation = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _dropAnimation.value),
      child: Transform.rotate(
        angle: _rotationAnimation.value,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: const SizedBox(
            height: 200,
            width: 200,
            child: Icon(
              Icons.ac_unit_sharp,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
