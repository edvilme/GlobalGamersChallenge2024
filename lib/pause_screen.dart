import 'dart:io';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trash_game/trashgame.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class PauseScreen extends StatelessWidget {
  PauseScreen({Key? key, 
    this.game
  }) : super(key: key);
  late TrashGame? game;
  final ImagePicker imagePicker = ImagePicker();
  final imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("PAUSE",
                style: 
                  Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),), 
              const Spacer(),
              Text("Gameplay and development: Eduardo Villalpando\nGraphic design: Rebeca Juárez\nImage Labeling: Google ML Kit Image Labeling (Base Model)", 
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      game!.overlays.clear();
                      game!.resetGameParameters();
                    },
                    child: Text("Restart"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      game!.overlays.clear();
                      game!.resumeGame();
                    },
                    child: Text("Resume")),
                ],
              )
            ],
          )
        ),
      )
    );
  }
}