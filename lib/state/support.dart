// ignore_for_file: prefer_const_constructors

import 'package:firstapp/state/providee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Popup extends StatefulWidget {
  const Popup({super.key, required this.wins});
  final bool wins;

  @override
  State<Popup> createState() => PpopupState();
}

class PpopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    if (widget.wins) {
      return AlertDialog(
        title: Text('You Won!'),
        content: Text('Congratulations! You have won the game.'),
        actions: <Widget>[
          TextButton(
            child: Text('Try Again'),
            onPressed: () {
              Provider.of<Providee>(context, listen: false).reset();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text('Game Over'),
        content: Text('Sorry, you didn\'t win this time. Better luck next time!'),
        actions: <Widget>[
          TextButton(
            child: Text('Try Again'),
            onPressed: () {
              Provider.of<Providee>(context, listen: false).reset();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}