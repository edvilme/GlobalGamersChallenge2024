import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trash_game/gameover_screen.dart';
import 'package:trash_game/pause_screen.dart';
import 'package:trash_game/trashgame.dart';
void main() async {
  TrashGame game = TrashGame();
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
        },
      ),
    )
  ); 
}
