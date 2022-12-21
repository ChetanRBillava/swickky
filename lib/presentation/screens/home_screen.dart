import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sizer/sizer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:swickky/logic/cubit/home_screen_cubit.dart';
import 'package:swickky/presentation/utils/app_texts.dart';
import 'package:swickky/presentation/utils/custom_print.dart';

import '../../core/constants/images.dart';
import '../../logic/cubit/app_theme_cubit.dart';
import '../utils/custom_text_field.dart';
import '../widgets/food_category_tiles.dart';
import '../widgets/restaurant_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  final ScrollController _scrollViewController = ScrollController(initialScrollOffset: 0);
  TextEditingController searchController = TextEditingController();
  Timer? timer;
  List foodImages = [
    AppImages.food2, AppImages.food3, AppImages.food4, AppImages.food5, AppImages.food6
  ], restaurantImages = [
    AppImages.restaurant2, AppImages.restaurant3, AppImages.restaurant4, AppImages.restaurant5
  ];

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
                  color: (themeState as AppThemeSet).themeClass.backgroundColor,
                  child: CustomScrollView(
                      controller: _scrollViewController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            color: (themeState).themeClass.primaryColor.withOpacity(0.5),
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
                        ),
                        SliverStickyHeader(
                          header: Container(
                            color: (themeState).themeClass.primaryColor.withOpacity(0.5),
                            child: AnimatedContainer(
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
                          ),
                          sliver: MultiSliver(
                            children: [
                              ///offer
                              Container(
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: (themeState).themeClass.appbarBackgroundColor,
                                  border: Border.all(
                                    color: (themeState).themeClass.appbarBackgroundColor,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.w),bottomRight: Radius.circular(8.w),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      //height: 40.w,
                                      child: Image.asset(
                                          AppImages.offer,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: <Color>[
                                                (themeState).themeClass.secondaryColor,
                                                (themeState).themeClass.tileBackground,
                                                (themeState).themeClass.tileBackground,
                                                (themeState).themeClass.tileBackground,
                                                (themeState).themeClass.tileBackground,
                                                (themeState).themeClass.tileBackground,
                                              ]
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.w),
                                                topRight: Radius.circular(5.w),
                                                bottomLeft: Radius.circular(5.w),
                                                bottomRight: Radius.circular(10.w),
                                            ),
                                        ),
                                        //width: 70.w,
                                        //height: 15.h,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 3.w),
                                                  child: AppTexts(
                                                    textString: 'Get',
                                                    textFontSize: 13.sp,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: themeState.themeClass.textColor_3,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 3.w),
                                                  child: AppTexts(
                                                    textString: '60% OFF*',
                                                    textFontSize: 20.sp,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: themeState.themeClass.textColor_3,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 3.w),
                                                  child: AppTexts(
                                                    textString: 'On Amazing Treats',
                                                    textFontSize: 16.sp,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: themeState.themeClass.textColor_3,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 3.w, top: 4.h),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: themeState.themeClass.secondaryColor,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(2.w),),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: themeState.themeClass.tileBackground,
                                                        size: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40.w,
                                              height: 40.w,
                                              child: Image.asset(
                                                AppImages.food,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ///mini tiles
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4.h, top: 1.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(5.w),),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AppTexts(
                                                  textString: 'Best of\n2022',
                                                  textFontSize: 10.sp,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: themeState.themeClass.textColor_3,

                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: SizedBox(
                                                    width: 20.w,
                                                    child: Image.asset(
                                                      AppImages.food,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(5.w),),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AppTexts(
                                                  textString: 'Best of\n2022',
                                                  textFontSize: 10.sp,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: themeState.themeClass.textColor_3,

                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: SizedBox(
                                                    width: 20.w,
                                                    child: Image.asset(
                                                      AppImages.food,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(5.w),),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AppTexts(
                                                  textString: 'Best of\n2022',
                                                  textFontSize: 10.sp,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: themeState.themeClass.textColor_3,

                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: SizedBox(
                                                    width: 20.w,
                                                    child: Image.asset(
                                                      AppImages.food,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ///food categories
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 2.h),
                                        child: AppTexts(
                                          textString: 'What\'s on your mind?',
                                          textFontSize: 18.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ///horizontal list
                                  SizedBox(
                                    width: 100.w,
                                    height: 15.h,
                                    child: ListView.builder(
                                        itemCount: 10,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i){
                                          return FoodCategoryTile(foodImages: foodImages, index: i,);
                                        }
                                    ),
                                  ),
                                ],
                              ),
                              ///restaurants
                              Column(
                                children: [
                                  ///heading
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.w, top: 2.h, bottom: 2.h),
                                        child: AppTexts(
                                          textString: 'Restaurants to explore',
                                          textFontSize: 18.sp,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                      itemCount: 10,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i){
                                        return RestaurantsTile(restaurantImages: restaurantImages, index: i);
                                      }
                                  ),
                                ],
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