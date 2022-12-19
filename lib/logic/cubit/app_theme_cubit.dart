import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/themes/app_theme.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeInitial(
      brightness: Brightness.light));


  void setLightTheme() {
    LightTheme lightTheme = LightTheme();

    emit(AppThemeSet(brightness: Brightness.light,
        themeClass: lightTheme,
    ));
  }
}
