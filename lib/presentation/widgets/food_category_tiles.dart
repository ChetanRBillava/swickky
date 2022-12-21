import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_texts.dart';

class FoodCategoryTile extends StatelessWidget {
  const FoodCategoryTile({
    Key? key,
    required this.foodImages,
    required this.index,
  }) : super(key: key);

  final List foodImages;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///food image
        SizedBox(
          height: 10.h,
          //height: 40.w,
          child: Image.asset(
              foodImages[(index%foodImages.length)]
          ),
        ),
        ///food title
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: AppTexts(
            textString: 'food ${index+1}',
            textFontSize: 10.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}