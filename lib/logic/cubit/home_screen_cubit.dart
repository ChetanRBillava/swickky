import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenInitial(opacity: 1.0, appbarColor: Colors.transparent, textColor: Colors.transparent));

  void setColors(opacity, appBar, text){
    emit(HomeScreenLoaded(opacity: opacity, appbarColor: appBar, textColor: text));
  }

}
