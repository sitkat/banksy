import 'package:banksy/theme/app_colors.dart';
import 'package:banksy/ui/settings_screen.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(color: AppColors.accent),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.settings_outlined),
        onPressed: () {Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SettingsScreen()));
        },
      ),
    ],
  );
}
