import 'package:flutter/material.dart';

class FlattenOneAxisCharacter extends StatefulWidget {
  const FlattenOneAxisCharacter({super.key});

  @override
  _FlattenOneAxisCharacterState createState() =>
      _FlattenOneAxisCharacterState();
}

class _FlattenOneAxisCharacterState extends State<FlattenOneAxisCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _dropAnimation;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _dropAnimation = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
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

    _scaleAnimation = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
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
      child: Container(
        color: Colors.amberAccent,
        height: 200 * double.parse(_scaleAnimation.value.toString()),
        width: 200,
        child: const Icon(
          Icons.ac_unit_sharp,
          size: 100,
        ),
      ),
    );
  }
}
