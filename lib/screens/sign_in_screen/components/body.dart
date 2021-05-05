import 'package:final_project/components/no_account_text.dart';
import 'package:final_project/components/socal_card.dart';
import 'package:final_project/screens/sign_in_screen/components/sign_in_form.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "ยินดีต้อนรับ",
                  style: TextStyle(
                    color: Color(0xFFFF7643),
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ลงชื่อเข้าใช้ด้วยอีเมลและรหัสผ่านของคุณ \nหรือดำเนินการต่อด้วยโซเชียลมีเดียอื่นๆ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
