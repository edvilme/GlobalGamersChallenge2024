import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_game/trashcan.dart';
import 'package:trash_game/trashitem.dart';
import 'package:trash_game/utils.dart';

class PauseButton extends SpriteComponent with HasGameRef<TrashGame>, Tappable {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite("pause.circle.fill.png");
  }
  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.pauseGame();
    return true;
  }
}

class TrashGame extends FlameGame with
KeyboardEvents, PanDetector, ScrollDetector, HasCollisionDetection, HasTappables {
  late double trashCanWidth;
  late double trashItemWidth;
  Trashcan organicTrashcan = Trashcan(type: 'organic');
  Trashcan paperTrashcan = Trashcan(type: 'paper');
  Trashcan glassTrashcan = Trashcan(type: 'glass');
  Trashcan plasticTrashcan = Trashcan(type: 'plastic');
  SpriteComponent trashMountain = SpriteComponent();
  TextComponent scoreTextComponent = TextComponent();
  PauseButton pauseButton = PauseButton();

  late TrashItem currentTrashItem;
  // Game params
  late double trashMountainHeight;
  late double fallSpeed;
  late int score;

  late bool hasAccessibleNavigation;
  @override
  Color backgroundColor() => const Color(0xFF00ACE6);

  @override
  Future<void>? onLoad() async {
    trashCanWidth = min(size.x, size.y/2)/4;
    trashItemWidth = trashCanWidth * 0.75;
    // Reset game
    resetGameParameters();
    // Score component
    add(pauseButton
      ..position = Vector2(size.x - 40, 100)
      ..anchor = Anchor.centerRight
      ..size = Vector2.all(40));
    add(scoreTextComponent
      ..position = Vector2(size.x/2, 100)
      ..anchor = Anchor.center
      ..text = score.toString()
      ..textRenderer = TextPaint(
        style: const TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace'
        )
      ));
    // Mountain
    add(trashMountain
      ..sprite = await loadSprite("trash_mountain.png")
      ..size = Vector2(size.x, size.y)
      ..anchor = Anchor.topCenter
      ..position.x = size.x/2
      ..position.y = size.y - trashCanWidth - trashMountainHeight
      ..setColor(Colors.yellow)
      ..priority = 2);
    // Trashcans
    add(organicTrashcan
      ..position.x = (size.x - 4 * trashCanWidth) / 2 + trashCanWidth - trashCanWidth/2
      ..size = Vector2.all(trashCanWidth));
    add(paperTrashcan
      ..position.x = (size.x - 4 * trashCanWidth) / 2 + 2 * trashCanWidth - trashCanWidth/2
      ..size = Vector2.all(trashCanWidth));
    add(glassTrashcan
      ..position.x = (size.x - 4 * trashCanWidth) / 2 + 3 * trashCanWidth - trashCanWidth/2
      ..size = Vector2.all(trashCanWidth));
    add(plasticTrashcan
      ..position.x = (size.x - 4 * trashCanWidth) / 2 + 4 * trashCanWidth - trashCanWidth/2
      ..size = Vector2.all(trashCanWidth));
    // Trash item
    generateTrashItem();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!currentTrashItem.isInbound()) missedScore();
    if (trashMountainHeight > size.y / 2) setGameOver();
    scoreTextComponent.text = score.toString();
  }

  void setGameOver() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('score', score);
    pauseEngine();
    overlays.add('gameover');
  }

  void resetGameParameters(){
    trashMountainHeight = 0;
    fallSpeed = 200;
    score = 0;
    resumeEngine();
    // Reset positions
    organicTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    paperTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    glassTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    plasticTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    trashMountain.position.y = size.y - trashCanWidth - trashMountainHeight; 
  }

  void generateTrashItem() {
    currentTrashItem = TrashItem()
      ..position = Vector2(size.x/2, -trashItemWidth/2)
      ..size = Vector2.all(trashItemWidth);
    currentTrashItem.add(
      MoveToEffect(Vector2(size.x/2, size.y), EffectController(speed: fallSpeed, curve: Curves.easeIn))
    );
    add(currentTrashItem);
    if (fallSpeed < 500) fallSpeed *= 1.02;
  }

  void recoverLives(){
    trashMountainHeight /= 3;
    resumeEngine();
    organicTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    paperTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    glassTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    plasticTrashcan.position.y = size.y - trashCanWidth - trashMountainHeight;
    trashMountain.position.y = size.y - trashCanWidth - trashMountainHeight; 
  }

  void addScore(){
    remove(currentTrashItem);
    generateTrashItem();
    score++;
    // Haptic feedback
    HapticFeedback.lightImpact();
    // Scale text score
    scoreTextComponent.add(
      ScaleEffect.by(Vector2.all(1.2), EffectController(duration: 0.05, alternate: true))
    );
  }

  void missedScore(){
    remove(currentTrashItem);
    generateTrashItem();
    // Shake text score
    scoreTextComponent.add(
      SequenceEffect([
        MoveByEffect(Vector2(-10, 0), EffectController(duration: 0.04)),
        MoveByEffect(Vector2(10, 0), EffectController(duration: 0.04)),
      ], alternate: true, repeatCount: 2)
    );
    // Move trash mountain
    trashMountainHeight += size.y/100;
    organicTrashcan.add(MoveByEffect(Vector2(0, -size.y/100), EffectController(duration: 0.05)));
    paperTrashcan.add(MoveByEffect(Vector2(0, -size.y/100), EffectController(duration: 0.05)));
    glassTrashcan.add(MoveByEffect(Vector2(0, -size.y/100), EffectController(duration: 0.05)));
    plasticTrashcan.add(MoveByEffect(Vector2(0, -size.y/100), EffectController(duration: 0.05)));
    trashMountain.add(MoveByEffect(Vector2(0, -size.y/100), EffectController(duration: 0.05)));
  }

  void moveCurrentTrashItemHorizontally(double distance) {
    currentTrashItem.position.x = adjustToRange(
      currentTrashItem.position.x + distance, 
      trashCanWidth/2, 
      size.x - trashCanWidth/2);
  }

  void pauseGame(){
    pauseEngine();
    overlays.add('pause');
  }

  void resumeGame() {
    overlays.clear();
    resumeEngine();
  }

  void showCameraMinigame(){
    remove(currentTrashItem);
    generateTrashItem();
    pauseEngine();
    overlays.add('camera_minigame');
  }



  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        moveCurrentTrashItemHorizontally(-trashCanWidth/2);
      }
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        moveCurrentTrashItemHorizontally(trashCanWidth/2);
      }
      if (keysPressed.contains(LogicalKeyboardKey.escape)) {
        pauseGame();
      }
    }
    return KeyEventResult.handled;
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    if (info.eventPosition.viewport.x < currentTrashItem.position.x) {
      moveCurrentTrashItemHorizontally(-trashCanWidth/2);
    }
    if (info.eventPosition.viewport.x > currentTrashItem.position.x) {
      moveCurrentTrashItemHorizontally(trashCanWidth/2);
    }
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    moveCurrentTrashItemHorizontally(info.delta.game.x);
  }
}