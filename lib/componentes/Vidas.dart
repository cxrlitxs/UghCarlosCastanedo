import 'dart:ui';
import 'package:flame/components.dart';

class Vidas extends PositionComponent {
  final Sprite vidaSprite;
  int numeroVidas;
  final String texto;
  late final TextComponent textComponent;

  Vidas({required this.vidaSprite, this.numeroVidas = 4, required this.texto}) {
  textComponent = TextComponent(text: texto,);
  }

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    add(textComponent);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    for (int i = 0; i < numeroVidas; i++) {
      vidaSprite.render(canvas, position: Vector2(i * 32.0 + textComponent.width + 10, 0)); // Ajusta el valor de 32.0 según sea necesario
    }
  }

  void quitarVida() {
    if (numeroVidas > 0) {
      numeroVidas--;
    }
  }
}
