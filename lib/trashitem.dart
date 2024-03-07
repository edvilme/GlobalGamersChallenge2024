import 'dart:convert';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:trash_game/main.dart';

import 'package:trash_game/trashgame.dart';

class TrashItem extends SpriteComponent with HasGameRef<TrashGame>, CollisionCallbacks{
  static final List categories = ['glass', 'organic', 'paper', 'plastic'];
  late String type;
  @override
  Future<void>? onLoad() async {
    // Get random category
    type = categories.elementAt(Random().nextInt( categories.length ));
    List icons = json.decode(await rootBundle.loadString('AssetManifest.json')).keys
      .where((String key) => key.contains('assets/images/$type'))
      .map((String key) => key.replaceAll(RegExp('assets/images'), ''))
      .toList();
    // Select random sprite (and get a11y name)
    String spriteName = icons.elementAt(Random().nextInt(icons.length));
    sprite = await gameRef.loadSprite(spriteName);
    anchor = Anchor.center;
    priority = 1;
    add(RectangleHitbox());
  }

  bool isInbound(){
    double gameWidth = gameRef.size.x;
    double gameHeight = gameRef.size.y;
    return (0 <= position.x && position.x < gameWidth) 
      && position.y < gameHeight - gameRef.trashMountainHeight;
  }
}