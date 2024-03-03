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
  late String type;
  String? a11y_name;
  @override
  Future<void>? onLoad() async {
    // Get random category
    type = ['glass', 'organic', 'paper', 'plastic'].elementAt(Random().nextInt(4));
    // Get all files
    List icons = json.decode(await rootBundle.loadString('AssetManifest.json')).keys
      .where((String key) => key.contains('assets/images/$type'))
      .map((String key) => key.replaceAll(RegExp('assets/images'), ''))
      .toList();
    // Select random sprite (and get a11y name)
    String spriteName = icons.elementAt(Random().nextInt(icons.length));
    sprite = await gameRef.loadSprite(spriteName);
    // Accesibility (announce on generation)
    // a11y_name = spriteName.replaceAll('_', ' ').replaceAll('.png', '').replaceAll(RegExp(r'^\/\w+\/'), '');
    // SemanticsService.announce("Trash item is $a11y_name", TextDirection.ltr);
    // Rendering
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