import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ugh/games/UghGame.dart';

class Gota extends SpriteAnimationComponent with HasGameRef<UghGame>, CollisionCallbacks{

  Gota({
    required super.position, required super.size
  }) : super(anchor: Anchor.center);

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.50,
      ),
    );


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