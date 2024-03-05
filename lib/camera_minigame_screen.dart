import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:trash_game/trashgame.dart';


class CameraMinigameScreen extends StatelessWidget {
  CameraMinigameScreen({Key? key, 
    this.game
  }) : super(key: key);

  late TrashGame? game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("TAKE A PHOTO OF", 
                style: Theme.of(context).textTheme.overline,),
              Text("Paper", 
                style: Theme.of(context).textTheme.headline3,),
              Spacer(), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    game?.resumeGame();
                  }, child: Text("Cancel")),
                  ElevatedButton(onPressed: (){
                    game?.resumeGame();
                  }, child: Text("OK"))
                ],
              )
            ],
          ),
        )
      )
    );
  }

  void chooseImage(){
    
  }
}