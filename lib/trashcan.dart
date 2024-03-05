import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:trash_game/main.dart';
import 'package:trash_game/trashgame.dart';
import 'package:trash_game/trashitem.dart';
import 'package:flame/effects.dart';

class Trashcan extends SpriteComponent with HasGameRef<TrashGame>, CollisionCallbacks {
  late String? type;
  late Function? onSameTypeTrashItemCollision;
  Trashcan({this.type}) : super();

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("trashcan_$type.png");
    priority = 2;
    anchor = Anchor.center;
    add(RectangleHitbox());
    // debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is TrashItem) {
      if (other.type == type) {
        gameRef.addScore();
        bounce();
      } else if (other.type == 'magic') {
        gameRef.showCameraMinigame();
        bounce();
      }
    }
  }

  void bounce(){
    add(
      MoveByEffect(Vector2(0, size.y/4), EffectController(duration: 0.05, curve: Curves.bounceOut, alternate: true)),
    );
  }
}