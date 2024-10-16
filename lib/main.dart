import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text('Quizzler'),
          backgroundColor: Colors.grey.shade900,
        ),
        body: Quickpage(),
      ),
    );
  }
}

class Quickpage extends StatefulWidget {
  @override
  _QuickpageState createState() => _QuickpageState();
}

class _QuickpageState extends State<Quickpage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userpickAns) {
    bool correctAns = quizBrain.getCorrectAnswer();
    setState(() {
      if (userpickAns == correctAns) {
        scorekeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        showResultAlert(true);
      } else {
        scorekeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        showResultAlert(false);
      }
      if (quizBrain.isFinished()) {
        // Show alert when quiz is finished
        Alert(
          context: context,
          type: AlertType.info,
          title: "Quiz Finished!",
          desc: "You've reached the end of the quiz. Do you want to restart?",
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                resetQuiz();
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  void resetQuiz() {
    setState(() {
      quizBrain.reset();
      scorekeeper = [];
    });
  }

  void showResultAlert(bool isCorrect) {
    Alert(
      context: context,
      type: isCorrect ? AlertType.success : AlertType.error,
      title: isCorrect ? "Correct!" : "Wrong!",
      desc: isCorrect ? "You got it right!" : "That's not correct.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(16.0),
                    minimumSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'True',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(16.0),
                    minimumSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
