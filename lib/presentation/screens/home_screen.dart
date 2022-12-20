import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sizer/sizer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:swickky/logic/cubit/home_screen_cubit.dart';
import 'package:swickky/presentation/utils/app_texts.dart';
import 'package:swickky/presentation/utils/custom_print.dart';

import '../../logic/cubit/app_theme_cubit.dart';
import '../utils/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  final ScrollController _scrollViewController = ScrollController(initialScrollOffset: 0);
  TextEditingController searchController = TextEditingController();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loop();
    });
  }

  void loop(){
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      double opac = 1;
      Color appBar = Colors.transparent, text = Colors.transparent;
      opac = (_scrollViewController.offset/5.h);
      if(opac>1.0 || opac == 0){
        opac = 1.0;
      }
      if(_scrollViewController.offset>0.5.h){
        appBar = await BlocProvider.of<AppThemeCubit>(context).getColor(context, 'appBarScrolled');
        text = await BlocProvider.of<AppThemeCubit>(context).getColor(context, 'scrolledText');
      }
      else{
        appBar = await BlocProvider.of<AppThemeCubit>(context).getColor(context, 'appBarNotScrolled');
        text = await BlocProvider.of<AppThemeCubit>(context).getColor(context, 'notScrolledText');
      }
      BlocProvider.of<HomeScreenCubit>(context).setColors(opac, appBar, text);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, homeState) {
            return SafeArea(
              child: Scaffold(
                body: Container(
                  color: (themeState as AppThemeSet).themeClass.primaryColor.withOpacity(0.5),
                  child: CustomScrollView(
                      controller: _scrollViewController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            color: homeState.appbarColor.withOpacity(homeState.opacity),
                            child: Padding(
                              padding: EdgeInsets.only(top: 3.h, bottom: 1.h, left: 5.w),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.work,
                                            color: homeState.textColor,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 3.w),
                                            child: AppTexts(
                                              textString: 'Work',
                                              textFontSize: 18.sp,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.bold,
                                              textColor: homeState.textColor,
                                            ),
                                          ),
                                          Icon(
                                            Icons.expand_more,
                                            color: homeState.textColor,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: AppTexts(
                                              textString: 'Random place name, district, state, country - 576576',
                                              textFontSize: 10.sp,
                                              textOverflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.bold,
                                              textColor: homeState.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Icon(
                                      Icons.account_circle,
                                      color: homeState.textColor,
                                      size: 30.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverStickyHeader(
                          header: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            decoration: homeState.textColor==(themeState).themeClass.textColor_3? BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: <Color>[
                                      (themeState).themeClass.primaryColor,
                                      (themeState).themeClass.appbarBackgroundColor,
                                    ]
                                )
                            ): BoxDecoration(
                              color: homeState.appbarColor.withOpacity(homeState.opacity),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: CustomTextField(
                                controller: searchController,
                                hintText: 'type something',
                                suffixIcon: const Icon(
                                    Icons.search
                                ),
                              ),
                            ),
                          ),
                          sliver: MultiSliver(
                            children: [
                              Container(
                                height: 40.h,
                                width: 100.w,
                                color: (themeState).themeClass.appbarBackgroundColor,
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (context, i) => ListTile(
                                    leading: const CircleAvatar(
                                      child: Text('0'),
                                    ),
                                    title: Text('List tile #$i'),
                                  ),
                                  childCount: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}