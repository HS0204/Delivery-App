import 'package:flutter/cupertino.dart';

class bigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  bigText(
      {Key? key,
      this.color = const Color.fromARGB(255, 13, 13, 13),
      required this.text,
      this.size = 20,
      this.overFlow = TextOverflow.ellipsis // 텍스트가 특정 길이를 넘을 경우 ...으로 표시
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overFlow,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w400,
        ));
  }
}
