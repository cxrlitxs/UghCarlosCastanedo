import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config/config.dart';

class Vidas extends PositionComponent {
  final Sprite vidaSprite;
  int numeroVidas;
  final String texto;
  late final TextComponent textComponent;
  double wScale=1.0, hScale=1.0;

  Vidas({required this.vidaSprite, this.numeroVidas = 4, required this.texto}) {
  textComponent = TextComponent(text: texto,
  textRenderer: TextPaint(
      style: TextStyle(
          fontSize: 24.0 * wScale,
          color: Colors.white,
          fontWeight: FontWeight.bold)
      )
    );
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    wScale=size.x/gameWidth;
    hScale=size.y/gameHeight;
    add(textComponent);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    for (int i = 0; i < numeroVidas; i++) {
      vidaSprite.render(
          canvas,
          position: Vector2(i * 35.0 + textComponent.width + 20, 0),
      );
    }
  }

  void quitarVida() {
    if (numeroVidas > 0) {
      numeroVidas--;
    }
  }
}
