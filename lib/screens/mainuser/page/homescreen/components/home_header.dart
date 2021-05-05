import 'package:final_project/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../size_config.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          color: kPrimaryColor,
          height: 200.0,
          width: 700.0,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SearchField(),
              IconBtnWithCounter(
                svgSrc: "assets/icons/stro.svg",
                press: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
