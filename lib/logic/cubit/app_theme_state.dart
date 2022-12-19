part of 'app_theme_cubit.dart';

abstract class AppThemeState extends Equatable {
  final Brightness brightness;
  const AppThemeState({required this.brightness});
}

class AppThemeInitial extends AppThemeState {
  const AppThemeInitial({required super.brightness});

  @override
  List<Object> get props => [brightness];
}

class AppThemeSet extends AppThemeState {
  AppTheme themeClass;
  AppThemeSet({required super.brightness, required this.themeClass});

  @override
  List<Object> get props => [brightness, themeClass];
}
