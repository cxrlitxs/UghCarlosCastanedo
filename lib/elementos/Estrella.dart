import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ugh/games/UghGame.dart';

class Estrella extends SpriteComponent with HasGameRef<UghGame>, CollisionCallbacks{


  Estrella({required super.position, required super.size});

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite = Sprite(game.images.fromCache('star.png'));
    anchor = Anchor.center;

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid = true
      ..renderShape = true;
    add(hitbox);
    return super.onLoad();
  }
}