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

  Future<Color> getColor(context, String color) async{
    if(color == 'appBarScrolled'){
      return (state as AppThemeSet).themeClass.secondaryColor;
    }
    else if(color == 'appBarNotScrolled'){
      return (state as AppThemeSet).themeClass.primaryColor;
    }
    else if(color == 'scrolledText'){
      return (state as AppThemeSet).themeClass.textColor_1;
    }
    else if(color == 'notScrolledText'){
      return (state as AppThemeSet).themeClass.textColor_3;
    }
    else{
      return Colors.transparent;
    }
  }


  void setLightTheme() {
    LightTheme lightTheme = LightTheme();

    emit(AppThemeSet(brightness: Brightness.light,
        themeClass: lightTheme,
    ));
  }
}
