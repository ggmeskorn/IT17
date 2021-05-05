import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:dio/dio.dart';
import 'package:final_project/components/default_button.dart';
import 'package:final_project/components/form_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../my_constant.dart';
import '../../size_config.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  static final Map<String, String> genderMap = {
    'เลือก': '  เลือก ',
    'ชาย': ' ชาย ',
    'หญิง': ' หญิง ',
    'ไม่ระบุ': '   ไม่ระบุ   ',
  };
  List categoryItem = List();
  String selectedCategory;

  // File file;
  PickedFile file;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String urlimage,
      post_date,
      comments_post,
      total_Like,
      title_post,
      category_name,
      author_post,
      body_post;
  // String username, password, email, gender, urlimage;
  // name_surname, email, phone;
  bool remember = false;
  final List<String> errors = [];

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

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/CategoryAll.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItem = jsonData;
      });
    }
    print(categoryItem);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(40)),
            buildimage(),
            // SizedBox(height: getProportionateScreenHeight(50)),
            // buildEmailFormField(),
            // SizedBox(height: getProportionateScreenHeight(20)),
            // buildUsernameFormField(),
            // SizedBox(height: getProportionateScreenHeight(20)),
            // DropdownButton(
            //   items: categoryItem.map((category) {
            //     return DropdownMenuItem(
            //         value: category['name_category'],
            //         child: Text(category['name_category']));
            //   }).toList(),
            //   value: selectedCategory,
            //   onChanged: (newValue) {
            //     setState(() {
            //       selectedCategory = newValue;
            //     });
            //   },
            //   hint: Text('Select Button'),
            //   isExpanded: true,
            // ),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "สมั",
              press: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // if all are valid then go to success screen

                  print(
                      '\ntitle = $title_post, \nbody_post = $body_post,\ncategory_name = $category_name');
                  // ,\nname_surname = $name_surname,\nemail = $email,\nphoneNumber = $phone');
                  if (title_post == null ||
                      title_post.isEmpty ||
                      body_post == null ||
                      body_post.isEmpty) {
                    print('Have Space');
                  } else {
                    registerThread();
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
  void routetoAddInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddPost(),
    );
    Navigator.push(context, materialPageRoute);
  }

  // Future<Null> checkUsername() async {
  //   String url =
  //       'http://10.0.2.2/homestay/getUserWhereUser.php?isAdd=true&username=$username';
  //   try {
  //     Response response = await Dio().get(url);
  //     if (response.toString() == 'null') {
  //       registerThread();
  //     } else {
  //       addError(error: kusernameRepeatNullError);
  //     }
  //   } catch (e) {}
  // }

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
        urlimage = 'http://10.0.2.2/homestay/Users/$namePicImage';
        print('UrlImage: $urlimage');
        String urladduser =
            'http://10.0.2.2/homestay1/homestay/addpo.php?isAdd=true&image_post=$urlimage&post_date=$post_date&comments_post=$comments_post&total_Like=$total_Like&title_post=$title_post&category_name=$selectedCategory&author_post=$author_post&body_post=$body_post';
        // /addUser.php?isAdd=true&email=$email&username=$username&password=$password&gender=$gender&pathImage=$urlimage&status=User';
        try {
          await Dio().get(urladduser).then((value) => Navigator.pop(context));
          print('res = $urladduser');
        } catch (e) {}
        //   Response response = await Dio().get(urladduser);
        //   print('res = $response');

        //   if (response.toString() != "true") {
        //     Navigator.pop(context);
        //   } else {
        //     addError(error: kFormregNullError);
        //   }
        // } catch (e) {}
      });
    } catch (e) {}
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

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => title_post = newValue,
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
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => body_post = newValue,
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
}
