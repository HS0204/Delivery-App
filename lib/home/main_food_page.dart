import 'package:de/home/food_page_body.dart';
import 'package:de/widget/Big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widget/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // 헤더
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    bigText(
                      text: "Korea",
                      color: AppColors.mainColors,
                    ),
                    Row(
                      children: [
                        smallText(
                          text: "Seoul",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.search, color: Colors.white),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColors,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // 슬라이더
        FoodPageBody(),
      ],
    ));
  }
}
