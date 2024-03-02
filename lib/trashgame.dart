import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_game/trashcan.dart';
import 'package:trash_game/trashitem.dart';
import 'package:trash_game/utils.dart';

class TrashGame extends FlameGame with KeyboardEvents, PanDetector, TapDetector, ScrollDetector, HasCollisionDetection {
  static int KEYBOARD_EVENT_HORIZONTAL_DISTANCE = 20;
  static double FALL_SPEED = 2;
  static double PAN_GESTURE_SENSITIVITY = 1;
  static late double FLOOR_DEPTH_GROW_RATE;

  int score = 1;
  double floorDepth = 100;

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
  SpriteComponent trashMountain = SpriteComponent();

  @override
  //Color backgroundColor() => const Color(0xFF87CEFA);
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FLOOR_DEPTH_GROW_RATE = size.y/100;
    add(
      trashMountain
        ..sprite = await loadSprite("trash_mountain.png")
        ..size = Vector2(size.x, 2*size.y)
        ..priority = 1
        ..anchor = Anchor.topCenter
        ..position.x = size.x/2
        ..position.y = size.y - floorDepth - (size.x/5)
    );
    add(
      scoreTextComponent
        ..text = score.toString()
        ..position = Vector2(size.x/2, 100)
    );
    add(trashcanOrganic
        ..position = Vector2(size.x/4 - size.x/8, size.y - floorDepth));
    add(trashcanPaper
        ..position = Vector2(2*size.x/4 - size.x/8, size.y - floorDepth));
    add(trashcanGlass
        ..position = Vector2(3*size.x/4 - size.x/8, size.y - floorDepth));
    add(trashcanPlastic
        ..position = Vector2(size.x - size.x/8, size.y - floorDepth));
    generateTrashItem();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (floorDepth > size.y * 0.8) {
      overlays.add('gameover');
      pauseEngine();
    }
    if (!currentTrashItem.isInbound()) missedScore();
    currentTrashItem.position.y += FALL_SPEED;
  }

  void generateTrashItem(){
    currentTrashItem = new TrashItem();
    add(
      currentTrashItem
        ..position = Vector2(size.x/2, 0)
        ..anchor = Anchor.center
        ..priority = 2
    );
    FALL_SPEED *= 1.01;
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
    trashMountain.position.y -= FLOOR_DEPTH_GROW_RATE * 1.75;

    trashcanOrganic.position.y -= FLOOR_DEPTH_GROW_RATE;
    trashcanPaper.position.y -= FLOOR_DEPTH_GROW_RATE;
    trashcanGlass.position.y -= FLOOR_DEPTH_GROW_RATE;
    trashcanPlastic.position.y -= FLOOR_DEPTH_GROW_RATE;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed){
    if (event is RawKeyEvent){
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
        currentTrashItem.position.x = adjustToRange(
          currentTrashItem.position.x - KEYBOARD_EVENT_HORIZONTAL_DISTANCE, 
          currentTrashItem.size.x/2, 
          size.x - currentTrashItem.size.x/2);
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)){
        currentTrashItem.position.x = adjustToRange(
          currentTrashItem.position.x + KEYBOARD_EVENT_HORIZONTAL_DISTANCE, 
          currentTrashItem.size.x/2, 
          size.x - currentTrashItem.size.x/2);
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    double panDistance = info.delta.game.x * PAN_GESTURE_SENSITIVITY;
    currentTrashItem.position.x = adjustToRange(
      currentTrashItem.position.x + panDistance, 
      currentTrashItem.size.x/2, 
      size.x - currentTrashItem.size.x/2);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (info.eventPosition.viewport.x < size.x / 2){
      currentTrashItem.position.x = adjustToRange(
        currentTrashItem.position.x - KEYBOARD_EVENT_HORIZONTAL_DISTANCE, 
        currentTrashItem.size.x/2, 
        size.x - currentTrashItem.size.x/2);
    }
    if (info.eventPosition.viewport.x > size.x / 2){
      currentTrashItem.position.x = adjustToRange(
        currentTrashItem.position.x + KEYBOARD_EVENT_HORIZONTAL_DISTANCE, 
        currentTrashItem.size.x/2, 
        size.x - currentTrashItem.size.x/2);
    }
  }

  @override
  void onScroll(PointerScrollInfo info) {
    // TODO: implement onScroll
    super.onScroll(info);
  }
}

