import 'dart:convert';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:trash_game/main.dart';
import 'package:trash_game/trashgame.dart';

class TrashItem extends SpriteComponent with HasGameRef<TrashGame>, CollisionCallbacks{
  late String type;
  @override
  Future<void>? onLoad() async {
    // Get random cat
    type = ['glass', 'organic', 'paper', 'plastic'].elementAt(Random().nextInt(4));

    // Get all files
    List icons = json.decode(await rootBundle.loadString('AssetManifest.json')).keys
      .where((String key) => key.contains('assets/images/$type'))
      .map((String key) => key.replaceAll(RegExp('assets/images'), ''))
      .toList();
    // Select random sprite
    sprite = await gameRef.loadSprite(icons.elementAt(Random().nextInt(icons.length)));
    size = Vector2.all( 0.75 * min(gameRef.size.x, gameRef.size.y) / 5 );
    add(RectangleHitbox());
    // debugMode = true;
  }

  bool isInbound(){
    double gameWidth = gameRef.size.x;
    double gameHeight = gameRef.size.y;
    return (0 <= position.x && position.x < gameWidth) && (0 <= position.y && position.y < gameHeight - gameRef.floorDepth);
  }
}