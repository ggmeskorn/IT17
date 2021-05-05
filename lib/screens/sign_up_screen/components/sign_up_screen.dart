import 'dart:io';
import 'dart:math';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:dio/dio.dart';
import 'package:final_project/components/default_button.dart';
import 'package:final_project/components/form_error.dart';
import 'package:final_project/firebaseserver/helper/helperfunctions.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'dart:async';

class SignUpForm extends StatefulWidget {
  final Function toggleView;
  const SignUpForm({Key key, this.toggleView}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  static final Map<String, String> genderMap = {
    // 'เลือก': '  เลือก ',
    'ชาย': ' ชาย ',
    'หญิง': ' หญิง ',
    'ไม่ระบุ': '   ไม่ระบุ   ',
  };
  // File file;
  PickedFile file;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String username, password, email, gender, phone, urlimage;
  // name_surname, email, phone;
  bool remember = false;
  final List<String> errors = [];
  String _userId;
  singUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": usernameEditingController.text,
            "userEmail": emailEditingController.text
          };

          databaseMethods.addUserInfo(userDataMap, _userId);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(
              emailEditingController.text);

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(40)),
            buildimage(),
            SizedBox(height: getProportionateScreenHeight(50)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildUsernameFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            buildphoneFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(10)),
            buildgender(),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "สมัครสมาชิก",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // if all are valid then go to success screen

                  print(
                      '\nemail = $email, \nusername = $username,\npassword = $password, \ngender = $gender');
                  // ,\nname_surname = $name_surname,\nemail = $email,\nphoneNumber = $phone');
                  if (email == null ||
                      email.isEmpty ||
                      username == null ||
                      username.isEmpty ||
                      password == null ||
                      password.isEmpty ||
                      gender == null ||
                      gender.isEmpty) {
                    print('Have Space');
                  } else {
                    checkUsername();
                  }
                  // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> checkUsername() async {
    String url =
        'http://10.0.2.2/homestay/getUserWhereUser.php?isAdd=true&username=$username';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
        singUp();
      } else {
        addError(error: kusernameRepeatNullError);
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String namePicImage = 'user$i.jpg';
    print('namePiceImage = $namePicImage pathImage = ${file.path}');
    String url = 'http://10.0.2.2/homestay/SaveRegisterUserImage.php';
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: namePicImage);
      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) async {
        print('Response ===>>> $value');
        urlimage = '$namePicImage';
        print('UrlImage: $urlimage');

        String urladduser =
            'http://10.0.2.2/homestay/addUser.php?isAdd=true&email=$email&username=$username&password=$password&gender=$gender&phone=$phone&pathImage=$urlimage&status=User&status_online=Active now';
        try {
          Response response = await Dio().get(urladduser);
          print('res = $response');

          if (response.toString() != "true") {
          } else {
            Navigator.pop(context);
          }
          addError(error: kFormregNullError);
        } catch (e) {}
      });
    } catch (e) {}
  }

  Widget buildgender() {
    return Container(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('เพศ',
              style: TextStyle(color: kTextColor, fontSize: 15.0)),
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
          ),
          CupertinoRadioChoice(
            //  choices: genderMap,
            //     onChange: onGenderSelected,
            //     initialKeyValue: _selectedGender,
            choices: genderMap,
            onChange: (genderMap) {
              setState(() {
                gender = genderMap;
              });
            },
            // initialKeyValue:'ชาย',
            selectedColor: kPrimaryColor,
            notSelectedColor: CupertinoColors.systemGrey,
            initialKeyValue: genderMap.keys.first,
          )
        ],
      ),
    );
  }

  Widget buildimage() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundImage: file == null
                ? AssetImage("assets/images/profile.jpeg")
                : FileImage(File(file.path)),
          ),
          Positioned(
            bottom: 3.5,
            right: 1.5,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomsheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: kPrimaryColor,
                size: 22.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passwordEditingController,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "รหัสผ่าน",
        hintText: "รหัสผ่าน",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: usernameEditingController,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFormusernameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kInvalidusernameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ชื่อ",
        hintText: "ชื่อ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('กล้อง'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('คลังรูปภาพ'),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      file = pickedFile;
    });
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "อีเมล",
        hintText: "อีเมล",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 1,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 1,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 1,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: Icon(Icons.alternate_email),
      ),
    );
  }

  TextFormField buildphoneFormField() {
    return TextFormField(
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFormusernameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kInvalidusernameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "เบอร์",
        hintText: "เบอร์",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kTextColor),
          gapPadding: 10,
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
