import 'package:flame/game.dart';
import 'package:flutter/material.dart';


class GameOverScreen extends StatelessWidget {
  GameOverScreen({Key? key, 
    this.game
  }) : super(key: key);

  late FlameGame? game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Game Over",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 100
            ),),
          OutlinedButton(onPressed: (){
            game!.overlays.remove('gameover');
          }, child: Text("Try again"))
        ],
      ),
    );
  }
}