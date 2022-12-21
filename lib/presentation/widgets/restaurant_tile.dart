import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/constants/images.dart';
import '../../logic/cubit/app_theme_cubit.dart';
import '../utils/app_texts.dart';

class RestaurantsTile extends StatelessWidget {
  const RestaurantsTile({
    Key? key,
    required this.restaurantImages,
    required this.index,
  }) : super(key: key);

  final List restaurantImages;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppThemeState>(
      builder: (context, themeState) {
        return Row(
          children: [
            ///image
            Padding(
              padding: EdgeInsets.all(4.w),
              child: SizedBox(
                height: 25.h,
                width: 20.h,
                child: Stack(
                  children: [
                    ///image
                    Container(
                      height: 25.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4.w),),
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage(
                                  restaurantImages[(index%restaurantImages.length)]
                              )
                          )
                      ),
                    ),
                    ///black filter
                    Container(
                      height: 25.h,
                      width: 20.h,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    ///heart
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Icon(
                          Icons.favorite_border,
                          color: (themeState as AppThemeSet).themeClass.textColor_3,
                        ),
                      ),
                    ),
                    ///offer value
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: AppTexts(
                              textString: '60% OFF',
                              textFontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              textColor:themeState.themeClass.textColor_3,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                            child: AppTexts(
                              textString: 'UPTO ₹100',
                              textFontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              textColor:themeState.themeClass.textColor_3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ///description
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///description
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: SizedBox(
                        width: 45.w,
                        child: AppTexts(
                          textString: 'Name of the restaurant',
                          textFontSize: 14.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                ///ratings and ETA
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: themeState.themeClass.successColor,
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.star,
                          color: themeState.themeClass.textColor_3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: AppTexts(
                          textString: '4 (100+) 1 Hr',
                          textFontSize: 14.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ///categories
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: SizedBox(
                        width: 45.w,
                        child: AppTexts(
                          textString: 'Chinese, North Indian, South Indian',
                          textFontSize: 10.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                          textColor: themeState.themeClass.textCaptionColor,
                        ),
                      ),
                    ),
                  ],
                ),
                ///location
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: SizedBox(
                        width: 30.w,
                        child: AppTexts(
                          textString: 'Near shastri circle, Kundapura',
                          textFontSize: 10.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                          textColor: themeState.themeClass.textCaptionColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                      child: AppTexts(
                        textString: '5.0 KM',
                        textFontSize: 10.sp,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.bold,
                        textOverflow: TextOverflow.ellipsis,
                        textColor: themeState.themeClass.textCaptionColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}