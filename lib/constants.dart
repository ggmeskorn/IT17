import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const appBackground = Color(0xFFEFF5F4);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "กรุณากรอกอีเมลของคุณ";
const String commentsNullError = "กรุณากรอกข้อความของคุณ";
const String kcommentsNullError = "ไม่สามารถกรอกข้อความ กรุณากรอกใหม่อีกครั้ง";

const String kInvalidEmailError = "กรุณากรอกอีเมลที่ถูกต้อง";
const String kPassNullError = "กรุณากรอกรหัสผ่านของคุณ";
const String kShortPassError = "รหัสผ่านสั้นเกินไป";
const String kMatchPassError = "รหัสผ่านไม่ตรงกัน";
const String kNamelNullError = "กรุณากรอกชื่อของคุณ";
const String kLastNamelNullError = "กรุณากรอกนามสกุลของคุณ";
const String kPhoneNumberNullError = "กรุณากรอกหมายเลขโทรศัพท์ของคุณ";
const String kAddressNullError = "กรุณากรอกที่อยู่ของคุณ";
const String kFormregNullError = "ไม่สามารถสมัครได้ กรุณากรอกใหม่อีกครั้ง";
const String kusernameRepeatNullError =
    "มีคนใช้ชื่อผู้ใช้นี้ไปแล้ว กรุณากรอกใหม่อีกครั้ง";
const String kFormusernameNullError = "กรุณากรอกชื่อผู้ใช้ของคุณ";
const String kInvalidusernameError = "กรุณากรอกชื่อผู้ใช้ที่ถูกต้อง";
const String kInvalidusernamesigninError = "กรุณาลองใหม่";
const String kInvalidphoneError = "กรุณากรอกชื่อผู้ใช้ที่ถูกต้อง";
const String kInvalidpphoneError = "กรุณาลองใหม่";
const String kInvalidpasswordError = "รหัสผ่านไม่ถูกต้อง";
const String knamepetsError = "กรุณากรอกชื่อสัตว์เลี้ยง";
const String kInvalidnamepetsError = "กรุณากรอกชื่อสัตว์เลี้ยง";
const String kInvaliddetailpetsErrors = "กรุณากรอกรายละเอียดสัตว์เลี้ยง";

const BASE_URL = 'http://10.0.2.2/}/homestay/';
const UPLOAD_URL = BASE_URL + 'SavePetsImage.php';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

Widget showProgress() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
