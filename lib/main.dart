import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_game/camera_minigame_screen.dart';
import 'package:trash_game/gameoverscreen.dart';
import 'package:trash_game/pausescreen.dart';
import 'package:trash_game/trashgame.dart';


late List TRASH_ITEM_ASSETS;

void main() async {

  TrashGame game = TrashGame();
  // Get list of trash item assets
  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
        overlayBuilderMap: {
          'pause': (BuildContext context, TrashGame game) {
            return PauseScreen(game: game);
          },
          'gameover': (BuildContext context, TrashGame game) {
            return GameOverScreen(game: game);
          },
          'camera_minigame': (BuildContext context, TrashGame game) {
            return CameraMinigameScreen(game: game);
          }
        },
      ),
    )
  ); 
}
