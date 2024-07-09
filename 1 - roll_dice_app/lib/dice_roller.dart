import 'dart:math';

import 'package:flutter/material.dart';

final Random randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  int _diceNumber = 2;

  void rollDice() {
    setState(() {
      _diceNumber = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$_diceNumber.png',
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(18),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent[700],
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll dice'),
        )
      ],
    );
  }
}
