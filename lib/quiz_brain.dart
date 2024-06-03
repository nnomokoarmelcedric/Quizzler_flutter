import 'package:flutter/material.dart';

import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizBrain {
  int _questionNumber = 0;
  bool _quizOver = false;
  List<Question> _questionBank = [
    Question('Git is a distributed version control system', true),
    Question(
        'Docker containers share the same kernel as the host operating system',
        true),
    Question('Linux uses a command called `copy` to duplicate files', false),
    Question(
        'Git uses branches to isolate different lines of development', true),
    Question(
        'Docker Compose is a tool for defining and running multi-container Docker applications',
        true),
    Question(
        'In Linux, the command `ls` is used to list directory contents', true),
    Question(
        'Git commits are reversible by using the `git reverse` command', false),
    Question(
        'Docker Swarm is a native clustering and scheduling tool for Docker',
        true),
    Question(
        'In Linux, `rm -rf /` will safely remove all files in the root directory',
        false),
    Question(
        'Git repositories can be cloned using the `git clone` command', true),
    Question('Docker Hub is a public registry for Docker images', true),
    Question(
        'The Linux command `chmod` is used to change file permissions', true),
    Question('Git tracks changes to files in the `.git` directory', true),
    Question('Docker images can be updated directly without rebuilding', false),
    Question(
        'In Linux, the `sudo` command allows a permitted user to execute a command as the superuser',
        true)
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    } else {
      _quizOver = true;
    }
  }

  void restartQuiz() {
    _quizOver = false;
    _questionNumber = 0;
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool getQuizOver() {
    return _quizOver;
  }
}
