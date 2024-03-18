import 'package:flutter/widgets.dart';
import 'package:identidaddigital/core/utils/colors.dart';

class AppThemeData {
  final Color backgroundColor;
  final Color accentColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color secondaryHeaderColor;

  const AppThemeData({
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.primaryColor,
    @required this.secondaryColor,
    @required this.secondaryHeaderColor,
  });

  factory AppThemeData.light() {
    return const AppThemeData(
      backgroundColor: AppColors.backgroundColor,
      accentColor: AppColors.accentColor,
      primaryColor: AppColors.primaryColor,
      secondaryColor: AppColors.secondaryColor,
      secondaryHeaderColor: AppColors.secondaryHeaderColor,
    );
  }
}
