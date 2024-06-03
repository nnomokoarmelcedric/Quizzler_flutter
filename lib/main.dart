import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: QuizPage() //create new class for 'home' property of MaterialApp()
        //to escape 'No MaterialLocalizations found' error
        );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];

  void quizValidity(bool userPickedAnswer) {
    AlertType value;
    if (quizBrain.getQuizOver() == false) {
      checkAnswer(userPickedAnswer);
    } else {
      if (score < 8) {
        value = AlertType.warning;
      } else {
        value = AlertType.success;
      }
      Alert(
        context: context,
        type: value,
        title: "Quiz completed",
        desc: "Total: $score/15",
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
            child: const Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
      quizBrain.restartQuiz();
      setState(() {
        scoreKeeper = [];
        score = 0;
      });
    }
  }

  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (correctAnswer == userPickedAnswer) {
      print("You got it right");
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      score++;
    } else {
      print("You got it false");
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
    setState(() {
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        quizBrain.getQuestionText(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          quizValidity(true);
                          // checkAnswer(true);
                        },
                        child: const Text(
                          "True",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          quizValidity(false);
                          // checkAnswer(false);
                        },
                        child: const Text(
                          "False",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  //TODO: Add a Row here as your score keeper
                  Row(
                    children: scoreKeeper,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
