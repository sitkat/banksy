import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.dark_primary,
    primaryColor: AppColors.primary,
    iconTheme:  IconThemeData(color: AppColors.primary),
    cardColor: AppColors.dark_surface,
    canvasColor: AppColors.dark_incomes,
    dividerColor: AppColors.inout,
  );
}