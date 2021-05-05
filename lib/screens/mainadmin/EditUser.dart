import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../my_constant.dart';
import '../../size_config.dart';

List<Map> _myjson_gender = [
  {"id": '1', "name": 'ผู้'},
  {"id": '2', "name": 'เมีย'}
];

class EditUser extends StatefulWidget {
  final userList;
  final index;

  const EditUser({Key key, this.userList, this.index}) : super(key: key);
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool editMode = false;
  String selectedCategory;
  File _image;
  final picker = ImagePicker();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future addEditUser() async {
    if (editMode) {
      var uri = Uri.parse("${MyConstant().domain}/homestay/updateuser.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['id'] = widget.userList[widget.index]['id'];
      request.fields['email'] = email.text;
      request.fields['username'] = username.text;
      request.fields['password'] = password.text;
      request.fields['gender'] = gender.text;
      request.fields['phone'] = phone.text;

      var pic = await http.MultipartFile.fromPath('pathImage', _image.path,
          filename: _image.path);

      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'อัปเดตโพสต์สำเร็จ');
        Navigator.pop(context);
        print(email.text);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addEditUser();
    if (widget.index != null) {
      editMode = true;
      email.text = widget.userList[widget.index]['email'];
      username.text = widget.userList[widget.index]['username'];
      phone.text = widget.userList[widget.index]['phone'];
      password.text = widget.userList[widget.index]['password'];
      gender.text = widget.userList[widget.index]['gender'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข'),
      ),
      body: ListView(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.image,
              size: 50,
            ),
            onPressed: () {
              choiceImage();
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          editMode
              ? Container(
                  child: Image.network(
                      '${MyConstant().domain}/homestay/Users/${widget.userList[widget.index]['pathImage']}'),
                  width: 100,
                  height: 100,
                )
              : Text(''),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            child: _image == null
                ? Center(child: Text('ไม่มีรูป'))
                : Image.file(_image),
            width: 100,
            height: 150,
          ),
        TextField(
            controller: email,
            // maxLines: 4,
            decoration: InputDecoration(labelText: 'อีเมล'),
          ),
          TextField(
            controller: username,
            // maxLines: 4,
            decoration: InputDecoration(labelText: 'ผู้ใช้'),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(labelText: 'รหัสผ่าน'),
          ),

          TextField(
            controller: phone,
            // maxLines: 4,
            decoration: InputDecoration(labelText: 'phone'),
          ),
          TextField(
            controller: gender,
            // maxLines: 4,
            decoration: InputDecoration(labelText: 'gender'),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          // DropdownButton(
          //   items: _myjson_gender.map((category) {
          //     return DropdownMenuItem(
          //         value: category['name'].toString(),
          //         child: Text(category['name']));
          //   }).toList(),
          //   value: selectedCategory,
          //   onChanged: (newValue) {
          //     setState(() {
          //       selectedCategory = newValue;
          //     });
          //   },
          //   hint: Text('หมวดหมู่'),
          //   isExpanded: true,
          // ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          RaisedButton(
            color: kPrimaryColor,
            onPressed: () {
              addEditUser();
            },
            child: Text(
              editMode ? 'แก้ไข' : 'ตกลง',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(50),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
        ],
      ),
    );
  }
}
