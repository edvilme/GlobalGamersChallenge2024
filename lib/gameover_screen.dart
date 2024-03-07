import 'dart:io';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_game/trashgame.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class GameOverScreen extends StatefulWidget {
  late TrashGame? game;

  GameOverScreen ({Key? key, 
    this.game
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => GameOverScreenState();
}

class GameOverScreenState extends State<GameOverScreen> {  
  final ImagePicker imagePicker = ImagePicker();
  final imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));

  int highScore = 0;
  bool isHighScore = false;
  bool hasUnlockedAchievement = false;

  @override
  void initState() {
    super.initState();
    updateHighScore();
  }

  void updateHighScore() async {
    SharedPreferences scoreData = await SharedPreferences.getInstance();
    int score = scoreData.getInt('score') ?? 0;
    int currentHighScore = scoreData.getInt('highscore') ?? 0;
    if (score > currentHighScore){
      scoreData.setInt('highscore', score);
      // Achievements
      setState(() {
        isHighScore = true;
        highScore = score;
      });
    }
  }

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
              Text( isHighScore ? "High Score: \n$highScore" : "GAME OVER",
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),), 
              Text( isHighScore ? "" : "There is too much trash for sustainable living!",
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
              const Spacer(),
              Text((Platform.isIOS || Platform.isAndroid) ? "Gain extra lives by saving the environment in the real world! Upload a picture of any litter around you!" : "", 
                style: 
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      widget.game!.overlays.clear();
                      widget.game!.resetGameParameters();
                    }, 
                    child: const Text("Restart")),
                  (Platform.isIOS || Platform.isAndroid) ? ElevatedButton(
                    onPressed: (){
                      chooseImage(context);
                    },
                    child: const Text("Get more lives"),) : const Spacer()
                ],
              )
            ],
          )
        ),
      )
    );
  }

  // TODO: ADD more feedback
  void chooseImage(BuildContext context) async {
    final XFile? imageRaw = await imagePicker.pickImage(source: ImageSource.gallery);
    final InputImage inputImage = InputImage.fromFilePath(imageRaw!.path);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    imageLabeler.close();
    if (labels.any((ImageLabel element) => element.label == 'Paper')) {
      widget.game!.overlays.clear();
      widget.game!.recoverLives();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CupertinoAlertDialog(
            title: Text("No trash was recognized in your picture. Please try again!"),
          );
        });
    }
  }
}