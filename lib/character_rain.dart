import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedCharacterRaining extends StatefulWidget {
  const AnimatedCharacterRaining({super.key});

  @override
  _AnimatedCharacterRainingState createState() =>
      _AnimatedCharacterRainingState();
}

class _AnimatedCharacterRainingState extends State<AnimatedCharacterRaining>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation> _positions = [];
  final List<Widget> _characters = [];

  @override
  void initState() {
    super.initState();

    const characters = [
      '🎉',
      '😎',
      '🎊',
      '🎈',
      '😃',
      '🎂',
      '🎁',
      '🎉',
      '😎',
      '🎊'
    ];

    for (int i = 0; i < characters.length; i++) {
      _controllers.add(AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ));

      _positions.add(Tween(begin: -100.0, end: 200.0).animate(CurvedAnimation(
        parent: _controllers[i],
        curve: Curves.easeInOut,
      )));

      _characters.add(AnimatedCharacter(
        animation: _positions[i],
        character: characters[i],
        delay: i * 0.1,
      ));
    }

    for (var controller in _controllers) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _characters,
    );
  }
}

class AnimatedCharacter extends StatelessWidget {
  final Animation animation;
  final String character;
  final double delay;

  const AnimatedCharacter({
    super.key,
    required this.animation,
    required this.character,
    this.delay = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            margin: EdgeInsets.only(left: Random().nextDouble() * 400),
            child: Text(
              character,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
