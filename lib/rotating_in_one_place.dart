import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedDancingCharacter extends StatefulWidget {
  const AnimatedDancingCharacter({super.key});

  @override
  _AnimatedDancingCharacterState createState() =>
      _AnimatedDancingCharacterState();
}

class _AnimatedDancingCharacterState extends State<AnimatedDancingCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween(begin: 0.0, end: pi).animate(CurvedAnimation(
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

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _animation.value,
      child: const SizedBox(
        height: 200,
        width: 200,
        child: Icon(
          Icons.ac_unit_sharp,
          size: 100,
        ),
      ),
    );
  }
}
