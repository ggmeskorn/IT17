import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => signouting(context),
          child: Text(
            'ออกจากระบบ',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }

  Future<Null> signouting(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    MaterialPageRoute route =
        new MaterialPageRoute(builder: (context) => new SplashScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
    // Navigator.pushReplacementNamed(context,SplashScreen.routeName);
  }
}
