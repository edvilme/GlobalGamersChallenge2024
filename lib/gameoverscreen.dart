import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trash_game/trashgame.dart';


class GameOverScreen extends StatelessWidget {
  GameOverScreen({Key? key, 
    this.game
  }) : super(key: key);

  late TrashGame? game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Game over",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white
                ),), 
              ElevatedButton(
                onPressed: (){
                  game!.overlays.remove('gameover');
                  game!.resetGameParameters();
                }, 
                child: const Text("Restart"))
            ],
          )
        ),
      )
    );
    // return Container(
    //   color: Colors.grey.shade800,
    //   alignment: Alignment.center,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       const Text("Game Over",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           fontSize: 100
    //         ),),
    //       OutlinedButton(onPressed: (){
    //         game!.overlays.remove('gameover');
    //         game!.resetGameParameters();
    //       }, child: Text("Try again"))
    //     ],
    //   ),
    // );
  }
}