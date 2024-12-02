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
  int rowindecator = 0;

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
        boardlist[rowindecator * maxperrow + count] = Wordle(letter: letter); // Update the board
      print('count: $rowindecator');
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
      rowinputs.removeAt(rowinputs.length - 1);
    }
    boardlist[rowindecator * maxperrow + count - 1] = Wordle(letter: " ");
    count--;
    print("rowinputs: $rowinputs");
    notifyListeners();
  }



    void checkAnswer() {
    final input = rowinputs.join('');
    rowindecator++;

    if(targetword == input) {
      wins = true;

      //print("attempts : $attempts");
          } 
          else{
            _markLetterOnBoard();
            if (attempts<totalAttempts) {
              print("is it tho");
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
    print("before cleared");
    attempts++;
    count = 0;
    rowinputs.clear();
    print("after cleared");
    notifyListeners();

  }

  reset() {
    count = 0;
    index = 0;
    rowinputs.clear();
    boardlist.clear();
    excudedlist.clear();
    attempts = 0;
    wins = false;
    rowindecator = 0;
    targetword = '';
    generateboard();
    generateword();
    notifyListeners();
  }
}
