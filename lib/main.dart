import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trash_game/gameoverscreen.dart';
import 'package:trash_game/trashgame.dart';

late List TRASH_ITEM_ASSETS;

void main() async {

  TrashGame game = TrashGame();
  // Get list of trash item assets
  runApp(GameWidget(
    game: game,
    overlayBuilderMap: {
      'gameover': (BuildContext context, TrashGame game) {
        return GameOverScreen(game: game);
      }
    },
  )); 
}
