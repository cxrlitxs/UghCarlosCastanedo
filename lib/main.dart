import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'games/UghGame.dart';


void main() {
  runApp(
    const GameWidget<UghGame>.controlled(
      gameFactory: UghGame.new,
    ),
  );
}