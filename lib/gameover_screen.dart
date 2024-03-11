import 'dart:io';
import 'dart:ui';

// import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trash_game/trashgame.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum ScoreAchievement {none, score_10, score_15, score_20, score_50, score_100, score_150, score_200, score_300, score_400, score_500, score_600}

ScoreAchievement getAchievementFromScore(int score){
  if (score >= 600) return ScoreAchievement.score_600;
  if (score >= 500) return ScoreAchievement.score_500;
  if (score >= 400) return ScoreAchievement.score_400;
  if (score >= 300) return ScoreAchievement.score_300;
  if (score >= 200) return ScoreAchievement.score_200;
  if (score >= 150) return ScoreAchievement.score_150;
  if (score >= 100) return ScoreAchievement.score_100;
  if (score >= 50) return ScoreAchievement.score_50;
  if (score >= 20) return ScoreAchievement.score_20;
  if (score >= 15) return ScoreAchievement.score_15;
  if (score >= 10) return ScoreAchievement.score_10;
  return ScoreAchievement.none;
}

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
  ScoreAchievement achievement = ScoreAchievement.none;

  @override
  void initState() {
    super.initState();
    updateHighScore();
  }

  void updateHighScore() async {
    SharedPreferences scoreData = await SharedPreferences.getInstance();
    int score = scoreData.getInt('score') ?? 0;
    int previousHighScore = scoreData.getInt('highscore') ?? 0;
    ScoreAchievement previousScoreAchievement = getAchievementFromScore(previousHighScore);
    ScoreAchievement currentScoreAchievement = getAchievementFromScore(score);
    if (score > previousHighScore){
      scoreData.setInt('highscore', score);
      setState(() {
        isHighScore = true;
        highScore = score;
        achievement = currentScoreAchievement != previousScoreAchievement ? currentScoreAchievement : ScoreAchievement.none;
      });
    }
  }

  String generateGoogleWalletPass(){
    final String _passId = const Uuid().v4();
    const String _passClass = 'trashball_score_test';
    const String _issuerEmail = "eduardo.villalpando.mello@gmail.com";
    const String _issuerId = "3388000000022324171";

    return """ 
      {
        "iss": "$_issuerEmail",
        "aud": "google",
        "typ": "savetowallet",
        "origins": [],
        "payload": {
          "genericObjects": [
            {
              "id": "$_issuerId.$_passId",
              "classId": "$_issuerId.$_passClass",
              "genericType": "GENERIC_TYPE_UNSPECIFIED",
              "groupingInfo": {
                "groupingId": "trashball_high_score",
                "sortIndex": 1
              },
              "hexBackgroundColor": "#4285f4",
              "logo": {
                "sourceUri": {
                  "uri": "https://raw.githubusercontent.com/edvilme/TrashBall/main/assets/images/app_icon.png"
                }
              },
              "cardTitle": {
                "defaultValue": {
                  "language": "en",
                  "value": "TrashBall"
                }
              },
              "subheader": {
                "defaultValue": {
                  "language": "en",
                  "value": "Achievement unlocked: $highScore"
                }
              },
              "header": {
                "defaultValue": {
                  "language": "en",
                  "value": "Thanks for playing! Now keep helping the environment!"
                }
              },
              "heroImage": {
                "sourceUri": {
                  "uri": "https://github.com/edvilme/TrashBall/blob/main/assets/images/passes/${achievement.name}.jpg?raw=true"
                }
              },
              "textModulesData": [
                {
                  "header": "POINTS",
                  "body": "1234",
                  "id": "points"
                }
              ]
            }
          ]
        }
      }""";
  }

  Widget renderAddToGoogleWalletButton(){
    if (kIsWeb || Platform.isAndroid){
      return AddToGoogleWalletButton(pass: generateGoogleWalletPass());
    }
    else {
      return Container();
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
              const Spacer(),
              Text("TRASH LEVELS TOO HIGH", 
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).primaryTextTheme.titleSmall,),
              Text( isHighScore ? "High Score: \n$highScore" : "GAME OVER",
                textAlign: TextAlign.center,
                style: 
                  Theme.of(context).textTheme.displayLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),), 
              Text(!kIsWeb && (Platform.isIOS || Platform.isAndroid) ? "Gain extra lives by cleaning up the environment in the real world and uploading a picture of any litter around you" : "There is too much trash!", 
                textAlign: TextAlign.center,
                style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
              const Spacer(),
              renderAddToGoogleWalletButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      widget.game!.overlays.clear();
                      widget.game!.resetGameParameters();
                    }, 
                    icon: const Icon(Icons.restart_alt),
                    label: const Text("Restart"),),
                  !kIsWeb && (Platform.isIOS || Platform.isAndroid) ? ElevatedButton.icon(
                    onPressed: (){
                      chooseImage(context);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Get more lives"),) : Container()
                ],
              )
            ],
          )
        ),
      )
    );
  }

  void chooseImage(BuildContext context) async {
    Set<String> trashLabels = {
      'Comics', 'Cheeseburger', 'Petal', 'Fast Food', 'Hot dog', 'Junk', 'Juice', 'Icicle', 'Flesh', 'Food', 'Fruit', 'Shell', 'Newspaper', 'Plant', 'Paper', 'Pizza', 'Sushi', 'Cup', 'Wine', 'Soil', 'Branch', 'Garden', 'Flower', 'Vegetable', 'Glasses', 'Bag'
    }; 
    final XFile? imageRaw = await imagePicker.pickImage(source: ImageSource.gallery);
    final InputImage inputImage = InputImage.fromFilePath(imageRaw!.path);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    imageLabeler.close();

    Set<String> identifiedLabels = labels.map((e) => e.label).toSet().intersection(trashLabels);

    if (identifiedLabels.isNotEmpty) {
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