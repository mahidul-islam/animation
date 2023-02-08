import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedDancingText extends StatefulWidget {
  const AnimatedDancingText({super.key});

  @override
  _AnimatedDancingTextState createState() => _AnimatedDancingTextState();
}

class _AnimatedDancingTextState extends State<AnimatedDancingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _rotationAnimation;
  late Animation _dropAnimation;

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
        child: Container(
          child: const Text(
            'Dance!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
