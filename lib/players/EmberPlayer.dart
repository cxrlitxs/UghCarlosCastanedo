import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ugh/games/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<UghGame> {

  late int iTipo = -1;

  EmberPlayer({
    required super.position, required this.iTipo, required super.size
  }) : super( anchor: Anchor.center);


  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.50,
      ),
    );
  }
}