import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh/games/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<UghGame>, KeyboardHandler {

  int horizontalDirection = 0;
  //Newton v=a*t
  //Newton d=v*t
  final Vector2 velocity = Vector2.zero();
  final double accelerate = 200;

  EmberPlayer({
    required super.position,
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
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    print("Tecla presionada" + event.data.toString());

    horizontalDirection = 0;
    if(keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      position.y-= 20;
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      position.y+= 20;
    }

    if(keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection = 1;
      }
    if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection = -1;
    }

    return true;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    print(horizontalDirection);
    velocity.x = horizontalDirection * accelerate; //v=a*t
    position += velocity * dt; //d=v*t
    super.update(dt);
  }

}