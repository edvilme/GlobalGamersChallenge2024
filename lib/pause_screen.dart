import 'dart:ui';

import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
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
              const Spacer(),
              Text("PAUSE",
                style: 
                  Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      game!.overlays.clear();
                      game!.resetGameParameters();
                    },
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text("Restart"),),
                  ElevatedButton.icon(
                    onPressed: (){
                      game!.overlays.clear();
                      game!.resumeGame();
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text("Resume"),),
                ],
              ),
              const Spacer(),
              Text("Gameplay and development: Eduardo Villalpando\nGraphic design: Rebeca Juárez\nImage Labeling: Google ML Kit Image Labeling (Base Model)\n\n@edvilme 2024",
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),),
            ],
          )
        ),
      )
    );
  }
}