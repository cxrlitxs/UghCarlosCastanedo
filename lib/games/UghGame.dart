import 'dart:ui';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ugh/elementos/Gota.dart';
import '../bodies/EmberBody.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../config/config.dart';
import '../elementos/Estrella.dart';

class UghGame extends Forge2DGame with HasKeyboardHandlerComponents, HasCollisionDetection{

  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player, _player2;
  late TiledComponent mapComponent;
  double wScale=1.0, hScale=1.0;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'ember.png',
      'tilemap1_32.png'
    ]);

    cameraComponent = CameraComponent(world: world);

    wScale=size.x/gameWidth;
    hScale=size.y/gameHeight;

    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent=await TiledComponent.load('mapa1.tmx', Vector2(32*wScale, 32*hScale));
    world.add(mapComponent);

    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for(final estrella in estrellas!.objects){
      Estrella spriteStar = Estrella(position: Vector2(estrella.x*wScale,estrella.y*wScale),
      size: Vector2(64*wScale, 64*hScale));
      add(spriteStar);
    }

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x*wScale,gota.y*wScale),
          size: Vector2(64*wScale, 64*hScale));
      add(spriteGota);
    }

    _player = EmberPlayerBody(initialPosition: Vector2(128, canvasSize.y - 350,),
        iTipo: EmberPlayerBody.I_PLAYER_SUBZERO,tamano: Vector2(64*wScale, 64*hScale)
    );
    add(_player);

    _player2 = EmberPlayerBody(initialPosition: Vector2(140, canvasSize.y - 350,),
        iTipo: EmberPlayerBody.I_PLAYER_SCORPIO,tamano: Vector2(64*wScale, 64*hScale)
    );
    add(_player2);
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Color.fromRGBO(43, 6, 77, 1.0);
  }

}