// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firstapp/page/keyboard_view.dart';
import 'package:firstapp/page/wordleview.dart';
import 'package:firstapp/state/providee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/state/support.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void didChangeDependencies() {
    Provider.of<Providee>(context, listen: false).init();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hurdle"),
        ),
        body: Center(
          child: Column(children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Consumer<Providee>(
                    builder: (context, value, child) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: value.boardlist.length,
                        itemBuilder: (context, index) {
                          final wordle = value.boardlist[index];
                          return WordleView(wordle: wordle);
                        })),
              ),
            ),
            Consumer<Providee>(
                builder: (context, value, child) => KeyboardView(
                      excludedLetters: value.excudedlist,
                      onPressed: (letter) {
                        value.inputword(letter);
                      },
                    )),
            Consumer<Providee>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      value.deleteletter();
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text('delete'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!value.isvalid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Not a valid word!"), duration: Duration(seconds: 1)));
                      } 
                      if (value.longenough) {
                        value.checkAnswer();
                        
                        
                      }
                      if (value.wins) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Popup(wins: value.wins);
                            },
                          );
                      } else if (value.noAttemptsLeft) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Popup(wins: false);
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text('submit'),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
