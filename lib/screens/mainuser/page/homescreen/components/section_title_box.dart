import 'package:flutter/material.dart';

import '../../../../../size_config.dart';

class SectionTitleBox extends StatelessWidget {
  const SectionTitleBox({
    Key key,
    @required this.press,
  }) : super(key: key);

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: press,
          child: Text(
            "ดูเพิ่มเติม",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}
