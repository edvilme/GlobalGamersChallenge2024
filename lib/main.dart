import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_game/trashcan.dart';
import 'package:trash_game/trashitem.dart';

late List TRASH_ITEM_ASSETS;

void main() async {
  // Get list of trash item assets
  runApp(GameWidget(game: TrashGame())); 
}

class TrashGame extends FlameGame with KeyboardEvents, PanDetector, TapDetector, ScrollDetector, HasCollisionDetection {
  static const int KEYBOARD_EVENT_HORIZONTAL_DISTANCE = 20;
  static const int DEFAULT_SPEED = 3;
  static const double PAN_GESTURE_SENSITIVITY = 1/5;
  static const int FLOOR_DEPTH_GROW_RATE = 20;

  int score = 0;
  int floorDepth = 100;

  TrashItem currentTrashItem = TrashItem();
  TextComponent scoreTextComponent = TextComponent()
    ..priority = 1
    ..anchor = Anchor.center
    ..textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 80, 
        fontWeight: FontWeight.bold
      )
    );

    Trashcan trashcanOrganic = Trashcan()..type = 'organic';
    Trashcan trashcanPaper = Trashcan()..type = 'paper';
    Trashcan trashcanGlass = Trashcan()..type = 'glass';
    Trashcan trashcanPlastic = Trashcan()..type = 'plastic';

  @override
  Color backgroundColor() => const Color(0x87cefa);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      scoreTextComponent
        ..text = score.toString()
        ..position = Vector2(size.x/2, 100)
    );

    add(trashcanOrganic
        ..position = Vector2(size.x/5 - size.x/10, size.y - floorDepth));
    add(trashcanPaper
        ..position = Vector2(2*size.x/5 - size.x/10, size.y - floorDepth));
    add(trashcanGlass
        ..position = Vector2(4*size.x/5 - size.x/10, size.y - floorDepth));
    add(trashcanPlastic
        ..position = Vector2(5*size.x/5 - size.x/10, size.y - floorDepth));
    generateTrashItem();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (floorDepth > size.y * 0.8) pauseEngine();
    if (!currentTrashItem.isInbound()) missedScore();
    currentTrashItem.position.y += DEFAULT_SPEED;
  }

  void generateTrashItem(){
    currentTrashItem = new TrashItem();
    add(
      currentTrashItem
        ..position = Vector2(size.x/2, 0)
        ..anchor = Anchor.center
    );
  }

  void addScore(){
    remove(currentTrashItem);
    generateTrashItem();
    score++;
    scoreTextComponent.text = score.toString();
  }

  void missedScore(){
    remove(currentTrashItem);
    generateTrashItem();
    floorDepth += FLOOR_DEPTH_GROW_RATE;

    trashcanOrganic.position.y = size.y - floorDepth;
    trashcanPaper.position.y = size.y - floorDepth;
    trashcanGlass.position.y = size.y - floorDepth;
    trashcanPlastic.position.y = size.y - floorDepth;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed){
    if (event is RawKeyEvent){
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
        currentTrashItem.position.x -= KEYBOARD_EVENT_HORIZONTAL_DISTANCE;
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)){
        currentTrashItem.position.x += KEYBOARD_EVENT_HORIZONTAL_DISTANCE;
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    currentTrashItem.position.x += info.delta.game.x * PAN_GESTURE_SENSITIVITY;
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (info.eventPosition.viewport.x < size.x / 2){
      currentTrashItem.position.x -= KEYBOARD_EVENT_HORIZONTAL_DISTANCE;
    }
    if (info.eventPosition.viewport.x > size.x / 2){
      currentTrashItem.position.x += KEYBOARD_EVENT_HORIZONTAL_DISTANCE;
    }
  }

  @override
  void onScroll(PointerScrollInfo info) {
    // TODO: implement onScroll
    super.onScroll(info);
  }
}

