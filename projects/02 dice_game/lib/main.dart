import 'package:dice_game/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          colors: [
            Color.fromARGB(255, 143, 185, 145),
            Color.fromARGB(255, 143, 185, 145),
          ],
        ),
      ),
    ),
  );
}
