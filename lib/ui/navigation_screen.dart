import 'package:banksy/ui/community_screen.dart';
import 'package:banksy/ui/game_screen.dart';
import 'package:banksy/ui/home_screen.dart';
import 'package:banksy/ui/income_screen.dart';
import 'package:banksy/ui/news_screen.dart';
import 'package:banksy/ui/onboard_screen.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NavigationScreen extends StatefulWidget {
  final int initialTabIndex;

  const NavigationScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _MyAppState(initialTabIndex);
}

class _MyAppState extends State<NavigationScreen> {
  int _currentIndex;

  _MyAppState(this._currentIndex);

  final tabs = const [
    HomeScreen(),
    IncomeScreen(),
    NewsScreen(),
    CommunityScreen(),
    GameScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          iconSize: 25.0,
          unselectedIconTheme: Theme.of(context).iconTheme,
          unselectedItemColor: Theme.of(context).primaryColor,
          selectedItemColor: AppColors.accent,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.signal_cellular_alt_sharp),
              label: 'Income',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.slideshow),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.casino_outlined),
              label: 'Game',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
