part of 'home_screen_cubit.dart';

abstract class HomeScreenState extends Equatable {
  final double opacity;
  final Color appbarColor, textColor;

  const HomeScreenState({required this.opacity, required this.appbarColor, required this.textColor});

  @override
  List<Object> get props => [opacity, appbarColor, textColor];
}

class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial({required super.opacity, required super.appbarColor, required super.textColor});

  @override
  List<Object> get props => [opacity, appbarColor, textColor];
}

class HomeScreenLoaded extends HomeScreenState{
  const HomeScreenLoaded({required super.opacity, required super.appbarColor, required super.textColor});

  @override
  List<Object> get props => [opacity, appbarColor, textColor];
}