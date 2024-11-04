// ignore_for_file: avoid_print

import 'dart:math';
import 'package:english_words/english_words.dart' as words;
import 'package:firstapp/state/wordle.dart';
import 'package:flutter/material.dart';

class Providee extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalwords = [];
  List<String> rowinputs = [];
    int index = 0;
  List<String> excudedlist = [];
  List<Wordle> boardlist = [];
  String targetword = '';
  int count = 0;
  int maxperrow = 5;
  final lettersPerRow = 5;
  final totalAttempts = 6;

  int attempts = 0;
  bool wins = false;

  bool get longenough => rowinputs.length == maxperrow;
  bool get iscorrect => rowinputs.join('') == targetword;
    bool get noAttemptsLeft => attempts == totalAttempts;

  init() {
    totalwords = words.all.where((element) => element.length == 5).toList();
    generateboard();
    generateword();
  }

  bool get isvalid => totalwords.contains(rowinputs.join('').toLowerCase());

  
  generateboard() {
    boardlist = List.generate(
      30,
      (index) => Wordle(letter: ''),
    );
  }

  generateword() {
    targetword = totalwords[random.nextInt(totalwords.length)].toUpperCase();
    print(targetword);
  }

  inputword(String letter) {
    if (count < maxperrow) {
      rowinputs.add(letter);
      boardlist[count] = Wordle(letter: letter);
      count++;
      index++;
      print("rowinputs: $rowinputs");
      notifyListeners();
    } else {
      print("overbound");
    }
  }

  deleteletter() {
    if (rowinputs.isNotEmpty) {
      rowinputs.removeLast();
      boardlist[count - 1] = Wordle(letter: '');
      count--;
      index--;
      print("rowinputs: $rowinputs");
    }
    notifyListeners();
  }
    void checkAnswer() {
    final input = rowinputs.join('');
    if(targetword == input) {
       wins = true;
               print("attterefderferfffffffffffffffffffffffff $attempts");

    } else {
      _markLetterOnBoard();
      if(attempts < totalAttempts) {
        _goToNextRow();
      }
    }
  }
    void _markLetterOnBoard() {
    for(int i = 0; i < boardlist.length; i++) {
      if(boardlist[i].letter.isNotEmpty && targetword.contains(boardlist[i].letter)) {
        boardlist[i].existsInTarget = true;
      } else if(boardlist[i].letter.isNotEmpty && !targetword.contains(boardlist[i].letter)) {
        boardlist[i].doesNotExistInTarget = true;
        excudedlist.add(boardlist[i].letter);
      }
    }
    notifyListeners();
  }
  
  void _goToNextRow() {
    attempts++;
    count = 0;
    rowinputs.clear();
  }

  reset() {
    count = 0;
    index = 0;
    rowinputs.clear();
    boardlist.clear();
    excudedlist.clear();
    attempts = 0;
    wins = false;
    targetword = '';
    generateboard();
    generateword();
    notifyListeners();
  }
}
