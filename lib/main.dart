import 'package:banksy/theme/theme_provider.dart';
import 'package:banksy/ui/navigation_screen.dart';
import 'package:banksy/ui/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database_helper.dart';


int? isViewed;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  await databaseHelper.database;
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.darkTheme,
      home: isViewed != 0 ? const OnBoardScreen() : const NavigationScreen(),
    );
  }
}