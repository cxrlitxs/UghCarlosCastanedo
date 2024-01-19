import 'dart:ui';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:ugh/bodies/EstrellaBody.dart';
import '../bodies/EmberBody.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../bodies/GotaBody.dart';
import '../bodies/TierraBody.dart';
import '../componentes/Vidas.dart';
import '../config/config.dart';

class UghGame extends Forge2DGame with HasKeyboardHandlerComponents, HasCollisionDetection{

  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player, _player2;
  late TiledComponent mapComponent;
  double wScale=1.0, hScale=1.0;
  late Vidas vidasPlayer;
  late Vidas vidasPlayer2;

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
      EstrellaBody estrellaBody = EstrellaBody(posXY: Vector2(estrella.x*wScale,estrella.y*wScale),
          tamWH: Vector2(64*wScale,64*hScale));
      add(estrellaBody);
    }


    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      GotaBody gotaBody = GotaBody(posXY: Vector2(gota.x*wScale,gota.y*wScale),
          tamWH: Vector2(64*wScale,64*hScale));
      gotaBody.onBeginContact = InicioContactosDelJuego;
      add(gotaBody);
    }


    ObjectGroup? tierras=mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for(final tiledObjectTierra in tierras!.objects){
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra,
          scales: Vector2(wScale,hScale));
      add(tierraBody);
    }

    _player = EmberPlayerBody(initialPosition: Vector2(128, canvasSize.y - 350,),
        iTipo: EmberPlayerBody.I_PLAYER_SUBZERO,tamano: Vector2(64*wScale, 64*hScale)
    );
    _player.onBeginContact = InicioContactosDelJuego;
    add(_player);

    _player2 = EmberPlayerBody(initialPosition: Vector2(140, canvasSize.y - 350,),
        iTipo: EmberPlayerBody.I_PLAYER_SCORPIO,tamano: Vector2(64*wScale, 64*hScale)
    );
    _player2.onBeginContact = InicioContactosDelJuego;
    add(_player2);

    final vidaSprite = await loadSprite('heart.png');
    vidasPlayer = Vidas(vidaSprite: vidaSprite, texto: "Ember");
    vidasPlayer.position = Vector2(
      (size.x - 32) / 2,
      30,);
    add(vidasPlayer);

    vidasPlayer2 = Vidas(vidaSprite: vidaSprite, texto: "Ember 2");
    vidasPlayer2.position = Vector2(
      (size.x - 32) / 2,
      65 + 35, // 35 es el tamaño de la imagen de la vida
    );
    add(vidasPlayer2);
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Color.fromRGBO(43, 6, 77, 1.0);
  }

  void InicioContactosDelJuego(Object objeto,Contact contact){
    if(objeto is EstrellaBody){
      objeto.removeFromParent();
    }

    if(objeto == _player){
      perderVida(_player);
    }

    if(objeto == _player2){
      perderVida(_player2);
    }
  }

  void perderVida(EmberPlayerBody jugador) {
    jugador.iVidas--;
    if (jugador.iVidas == 0) {
      if (jugador == _player) {
        vidasPlayer.numeroVidas = jugador.iVidas;
      } else if (jugador == _player2) {
        vidasPlayer2.numeroVidas = jugador.iVidas;
      }
      jugador.removeFromParent();
    } else {
        // Actualizar el componente de vidas del jugador correspondiente
        if (jugador == _player) {
          vidasPlayer.numeroVidas = jugador.iVidas;
        } else if (jugador == _player2) {
          vidasPlayer2.numeroVidas = jugador.iVidas;
        }
    }
  }


}