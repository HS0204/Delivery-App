import 'dart:ffi';

import 'package:de/utils/colors.dart';
import 'package:de/widget/Big_text.dart';
import 'package:de/widget/icon_and_text.dart';
import 'package:de/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController =
      PageController(viewportFraction: 0.85); // 슬라이더 좌우 공백 조절
  var _currPageValue = 0.0; // 현재 인덱스 초기화
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    // 초기 설정
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!; // 현재 페이지
        //print("Current value is " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    // 페이지를 떠날 때 메모리 제거
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.redAccent,
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    // 슬라이더 화면 조절 (y값으로)
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      // 현재 슬라이더 스케일 0
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      // 현재 슬라이더 다음 슬라이더 스케일 0.8
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // 현재 슬라이더 이전 슬라이더 스케일 0.8
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        // 그냥 컨테이너로 하면 상위 컨테이너 때문에 높이가 안 먹혀서 Stack으로 하위 컨테이너 매핑. Stack은 위젯을 겹쳐서 배치 가능
        children: [
          // 음식 메뉴 사진
          Container(
            height: 220,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven
                    ? Color.fromARGB(255, 235, 132, 63)
                    : Color.fromARGB(255, 204, 186, 146),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/food1.jpg"))),
          ),
          // 음식 메뉴 설명
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // 틀
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                // 설명
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 좌정렬
                  children: [
                    // 제목
                    bigText(text: "Lotus"),
                    SizedBox(
                      height: 10,
                    ),
                    // 평점
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColors.mainColors,
                                    size: 15,
                                  )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        smallText(text: "4.5"),
                        SizedBox(
                          width: 10,
                        ),
                        smallText(text: "1287"),
                        SizedBox(
                          width: 10,
                        ),
                        smallText(text: "comments")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // 아이콘
                    Row(
                      children: [
                        IconAndText(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        SizedBox(
                          width: 5,
                        ),
                        IconAndText(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.iconColor2),
                        SizedBox(
                          width: 5,
                        ),
                        IconAndText(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor3),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
