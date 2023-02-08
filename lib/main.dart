import 'package:character/character_dance.dart';
import 'package:character/character_rain.dart';
import 'package:character/dancing_character.dart';
import 'package:character/dropping_animation.dart';
import 'package:character/flatten.dart';
import 'package:character/flatten_one_axis.dart';
import 'package:character/rotating_in_one_place.dart';
import 'package:character/scale_update.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          children: const <Widget>[
            Center(child: AnimatedDancingCharacter()),
            Center(child: AnimatedDroppingCharacter()),
            Center(child: AnimatedScaleCharacter()),
            Center(child: FlattenCharacter()),
            Center(child: FlattenOneAxisCharacter()),
            Center(child: AnimatedDancingText()),
            Center(child: AnimatedCharacterShower()),
            Center(child: AnimatedCharacterRaining()),
          ],
        ),
      ),
    );
  }
}
