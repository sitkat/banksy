import 'dart:async';
import 'package:banksy/theme/app_colors.dart';
import 'package:banksy/theme/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_color/random_color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<int> symbols;
  late List<int> cardValues;
  late List<bool> cardFlips;
  int? firstFlippedIndex;
  int? secondFlippedIndex;
  Map<int, Color> pairColors = {};
  final RandomColor _randomColor = RandomColor();
  int points = 0;

  @override
  void initState() {
    super.initState();
    symbols = [1, 2, 3, 4, 5, 6, 7, 8];
    cardValues = _generateCardValues();
    cardFlips = List.filled(cardValues.length, true);
    firstFlippedIndex = null;
    secondFlippedIndex = null;
    _assignPairColors();
  }

  List<int> _generateCardValues() {
    List<int> values = symbols + symbols;
    values.shuffle();
    return values;
  }

  void _assignPairColors() {
    for (int i = 0; i < symbols.length; i++) {
      pairColors[symbols[i]] = _randomColor.randomColor();
    }
  }

  void restartGame() {
    setState(() {
      cardValues = _generateCardValues();
      cardFlips = List.filled(cardValues.length, true);
      firstFlippedIndex = null;
      secondFlippedIndex = null;
      _assignPairColors();
    });
  }

  void checkWin() {
    if (cardFlips.every((flipped) => !flipped)) {
      // Все карты перевернуты, отображаем Toast "You WON!"
      Fluttertoast.showToast(
        msg: 'You WON!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      // Показываем диалоговое окно
      showAlertDialog();
    }
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('Do you want to play one more time?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, 'Game'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Find a pair and score the most points',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$points  Points',
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: cardValues.length,
                itemBuilder: (context, index) {
                  return _buildCard(index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: InkWell(
                onTap: () {
                  restartGame();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 7),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    return GestureDetector(
      onTap: cardFlips[index] ? () => _flipCard(index) : null,
      child: Container(
        margin: const EdgeInsets.all(4),
        color: _getCardColor(index),
        child: Center(
          child: Text(
            cardValues[index].toString(),
            style: TextStyle(fontSize: 24, color: _getTextColor(index)),
          ),
        ),
      ),
    );
  }

  Color _getCardColor(int index) {
    if (index == firstFlippedIndex || index == secondFlippedIndex) {
      return Colors.yellow;
    } else {
      int value = cardValues[index];
      return cardFlips[index] ? pairColors[value]! : AppColors.surface;
    }
  }

  Color _getTextColor(int index) {
    if (index == firstFlippedIndex || index == secondFlippedIndex) {
      return Colors.yellow;
    } else {
      return cardFlips[index] ? AppColors.white : AppColors.surface;
    }
  }

  void _flipCard(int index) {
    if (firstFlippedIndex == null) {
      setState(() {
        firstFlippedIndex = index;
      });
    } else if (secondFlippedIndex == null && index != firstFlippedIndex) {
      setState(() {
        secondFlippedIndex = index;
      });

      _handleCardSelection();
    }
  }

  void _handleCardSelection() {
    if (cardValues[firstFlippedIndex!] == cardValues[secondFlippedIndex!]) {
      _closeCards();
    } else {
      _closeCardsAfterDelay();
    }
  }

  void _closeCards() {
    setState(() {
      cardFlips[firstFlippedIndex!] = false;
      cardFlips[secondFlippedIndex!] = false;
      firstFlippedIndex = null;
      secondFlippedIndex = null;
      points += 2;
      checkWin();
    });
  }
  void _closeCardsAfterDelay() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        firstFlippedIndex = null;
        secondFlippedIndex = null;
      });
    });
  }
}
