import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:swickky/logic/cubit/app_theme_cubit.dart';

import '../../core/constants/images.dart';
import '../../core/constants/strings.dart';
import '../router/app_router.dart';
import '../utils/app_texts.dart';
import '../utils/custom_text_field.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed(AppRouter.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: (themeState as AppThemeSet).themeClass.backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo),
                AppTexts(
                  textString: Strings.appDesc,
                  textFontSize: 14.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  textColor: (themeState).themeClass.textColor_1,
                ),
                SizedBox(height: 5.h,),
                AppTexts(
                  textString: Strings.appDev,
                  textFontSize: 10.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  textColor: (themeState).themeClass.textCaptionColor,
                ),
                AppTexts(
                  textString: Strings.appVersion,
                  textFontSize: 10.sp,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  textColor: (themeState).themeClass.textCaptionColor,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
