
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
        title: const Text('You Won!'),
        content: const Text('Congratulations! You have won the game.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Try Again'),
            onPressed: () {
              Provider.of<Providee>(context, listen: false).reset();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Game Over'),
        content: const Text('Sorry, you didn\'t win this time. Better luck next time!'),
        actions: <Widget>[
          TextButton(
            child: const Text('Try Again'),
            onPressed: () {
              Provider.of<Providee>(context, listen: false).reset();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }
}