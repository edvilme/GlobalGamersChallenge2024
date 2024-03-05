import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trash_game/trashgame.dart';


class CameraMinigameScreen extends StatelessWidget {
  // https://developers.google.com/ml-kit/vision/image-labeling/label-map
  final List<String> image_options = [
    'Paper', 'Cup', 'Food', 'Bag', 'Plant'
  ];
  final ImagePicker imagePicker = ImagePicker();
  final imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));

  CameraMinigameScreen({Key? key, 
    this.game
  }) : super(key: key) {
    desiredImageLabel = image_options.elementAt(Random().nextInt(image_options.length));
  }

  late TrashGame? game;
  late String desiredImageLabel;

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
              Text(desiredImageLabel, 
                style: Theme.of(context).textTheme.headlineLarge,),
              Text("Set the example in real life by finding this item and tossing it in the correct bin. Results are verified using AI.", 
                style: Theme.of(context).textTheme.bodyLarge,),
              Spacer(), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                    game?.resumeGame();
                  }, child: Text("Cancel")),
                  ElevatedButton(onPressed: (){
                    chooseImage();
                    // game?.resumeGame();
                  }, child: Text("Take picture"))
                ],
              )
            ],
          ),
        )
      )
    );
  }

  // TODO: ADD more feedback
  void chooseImage() async {
    final XFile? imageRaw = await imagePicker.pickImage(source: ImageSource.gallery);
    final InputImage inputImage = InputImage.fromFilePath(imageRaw!.path);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    imageLabeler.close();
    if (labels.any((ImageLabel element) => element.label == desiredImageLabel)) {
      game!.score += 10;
    }
    game!.resumeGame();
  }
}