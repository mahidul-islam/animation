import 'package:flutter/material.dart';

class AnimatedCharacterShower extends StatefulWidget {
  const AnimatedCharacterShower({super.key});

  @override
  _AnimatedCharacterShowerState createState() =>
      _AnimatedCharacterShowerState();
}

class _AnimatedCharacterShowerState extends State<AnimatedCharacterShower>
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

      _positions.add(Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
        parent: _controllers[i],
        curve: Curves.easeInOut,
      )));

      _characters.add(AnimatedCharacter(
        animation: _positions[i],
        character: characters[i],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _characters,
    );
  }
}

class AnimatedCharacter extends StatelessWidget {
  final Animation animation;
  final String character;

  const AnimatedCharacter({
    super.key,
    required this.animation,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
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
