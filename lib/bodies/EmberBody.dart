import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../players/EmberPlayer.dart';

class EmberPlayerBody extends BodyComponent with KeyboardHandler,ContactCallbacks{
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 600;
  late int iTipo=-1;
  late Vector2 tamano;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  static const  int I_PLAYER_SUBZERO = 0;
  static const  int I_PLAYER_SCORPIO = 1;
  late EmberPlayer emberPlayer;
  Vector2 initialPosition;
  int iVidas = 4;
  bool partidaPerdida = false;

  EmberPlayerBody({required this.initialPosition,required this.iTipo,
    required this.tamano})
      : super();

  @override
  Body createBody() {
    // TODO: implement createBody

    BodyDef definicionCuerpo= BodyDef(position: initialPosition,
        type: BodyType.dynamic,angularDamping: 0.8,userData: this, fixedRotation: true);

    Body cuerpo= world.createBody(definicionCuerpo);


    final shape=CircleShape();
    shape.radius=tamano.x/2;

    FixtureDef fixtureDef=FixtureDef(
        shape,
        friction: 0.2,
        restitution: 0.5, userData: this
    );
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
}

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad

    emberPlayer = EmberPlayer(position: Vector2(0,0),iTipo: iTipo, size:tamano);
    add(emberPlayer);
    await super.onLoad();
    body.gravityOverride = Vector2(0, 100);
  }

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent

    horizontalDirection = 0;
    verticalDirection = 0;

    if(event is RawKeyDownEvent){

      if(iTipo == I_PLAYER_SUBZERO){
        if(keysPressed.contains(LogicalKeyboardKey.keyW)) {
          verticalDirection = -2;
        }
        if(keysPressed.contains(LogicalKeyboardKey.keyX)) {
          verticalDirection = 2;
        }

        if(keysPressed.contains(LogicalKeyboardKey.keyD)) {
          horizontalDirection = 2;
        }
        if(keysPressed.contains(LogicalKeyboardKey.keyA)) {
          horizontalDirection = -2;
        }
      }

      if(iTipo == I_PLAYER_SCORPIO){
        if(keysPressed.contains(LogicalKeyboardKey.numpad8)) {
          verticalDirection = -2;
        }
        if(keysPressed.contains(LogicalKeyboardKey.numpad2)) {
          verticalDirection = 2;
        }

        if(keysPressed.contains(LogicalKeyboardKey.numpad6)) {
          horizontalDirection = 2;
        }
        if(keysPressed.contains(LogicalKeyboardKey.numpad4)) {
          horizontalDirection = -2;
        }
      }

      if(iTipo == I_PLAYER_SUBZERO){
        if(keysPressed.contains(LogicalKeyboardKey.keyS)){
            body.gravityOverride = (body.gravityOverride?.y ?? 0) > 1
                ? Vector2(0, -100)
                : Vector2(0, 100);
        }
      }

      if(iTipo == I_PLAYER_SCORPIO){
        if(keysPressed.contains(LogicalKeyboardKey.numpad5)){
            body.gravityOverride = (body.gravityOverride?.y ?? 0) > 1
                ? Vector2(0, -100)
                : Vector2(0, 100);
        }
      }
    }
    return true;
  }



  @override
  void update(double dt) {
    // TODO: implement update

    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;

    body.applyLinearImpulse(velocidad*dt*1000);

    if (horizontalDirection < 0 && emberPlayer.scale.x > 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer.scale.x < 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }

}