import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugh/elementos/Estrella.dart';
import 'package:ugh/elementos/Gota.dart';
import 'package:ugh/games/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<UghGame>, KeyboardHandler, CollisionCallbacks {

  int horizontalDirection = 0;
  int verticalDirection = 0;
  //Newton v=a*t
  //Newton d=v*t
  final Vector2 velocity = Vector2.zero();
  final double accelerate = 200;
  final Set<LogicalKeyboardKey> magiaSubZero = {LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.keyA};
  final Set<LogicalKeyboardKey> magiaScorpio = {LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.keyK};

  static const int I_PLAYER_SUBZERO = 0;
  static const int I_PLAYER_SCORPIO = 1;
  static const int I_PLAYER_TANYA = 2;

  late int iTipo = -1;

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  EmberPlayer({
    required super.position, required this.iTipo,
  }) : super(size: Vector2(100,160), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('reading.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        amountPerRow: 5,
        textureSize: Vector2(60,88),
        stepTime: 0.12,
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

  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    print("Tecla presionada" + event.data.toString());

    horizontalDirection = 0;
    verticalDirection = 0;

    if(keysPressed.containsAll(magiaScorpio) && iTipo == I_PLAYER_SCORPIO){

    }
    else if(keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      verticalDirection = -1;
    }
    else if(keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      verticalDirection = 1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection = 1;
      }
    else if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection = -1;
    }

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if(other is Gota){
      this.removeFromParent();
    } else if (other is Estrella){
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    velocity.x = horizontalDirection * accelerate; //v=a*t
    velocity.y = verticalDirection * accelerate; //v=a*t
    position += velocity * dt; //d=v*t
    super.update(dt);
  }

}