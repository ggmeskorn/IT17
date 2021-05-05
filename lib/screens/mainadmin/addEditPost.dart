import 'dart:convert';
import 'dart:io';

import 'package:final_project/constants.dart';
import 'package:final_project/model/category.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_constant.dart';

class AddEditPost extends StatefulWidget {
  final postList;
  final index;
  final author_post;
  AddEditPost({this.postList, this.index, this.author_post});
  @override
  _AddEditPostState createState() => _AddEditPostState();
}

class _AddEditPostState extends State<AddEditPost> {
  File _image;
  final picker = ImagePicker();

  String selectedCategory;
  List categoryItem = List();
  TextEditingController title_post = TextEditingController();
  TextEditingController body_post = TextEditingController();
  TextEditingController author_post = TextEditingController();

  bool editMode = false;

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future addEditPost() async {
    if (editMode) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String username = preferences.getString('username');
      print('id_Image = $username');
      var uri = Uri.parse("${MyConstant().domain}/homestay/updatepo.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['id'] = widget.postList[widget.index]['id'];
      request.fields['title_post'] = title_post.text;
      request.fields['body_post'] = body_post.text;
      request.fields['author_post'] = username;
      request.fields['category_name'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('image_post', _image.path,
          filename: _image.path);

      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'อัปเดตโพสต์สำเร็จ');
        Navigator.pop(context);
        print(title_post.text);
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String username = preferences.getString('username');
      print('id_Image = $username');
      var uri = Uri.parse("${MyConstant().domain}/homestay/addpo.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['title_post'] = title_post.text;
      request.fields['body_post'] = body_post.text;
      request.fields['author_post'] = username;

      request.fields['category_name'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('image_post', _image.path,
          filename: _image.path);

      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'เพิ่มโพสต์สำเร็จ');
        Navigator.pop(context);
        print(title_post.text);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
    if (widget.index != null) {
      editMode = true;
      title_post.text = widget.postList[widget.index]['title_post'];
      body_post.text = widget.postList[widget.index]['body_post'];
      selectedCategory = widget.postList[widget.index]['category_name'];
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'แก้ไขโพสต์' : 'เพิ่มโพสต์'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: title_post,
              decoration: InputDecoration(labelText: 'หัวข้อ'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: body_post,
              maxLines: 4,
              decoration: InputDecoration(labelText: 'เนื้อหา'),
            ),
          ),
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
                      '${MyConstant().domain}/homestay/Post/${widget.postList[widget.index]['image_post']}'),
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
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DropdownButton(
            items: categoryItem.map((category) {
              return DropdownMenuItem(
                  value: category['name_category'],
                  child: Text(category['name_category']));
            }).toList(),
            value: selectedCategory,
            onChanged: (newValue) {
              setState(() {
                selectedCategory = newValue;
              });
            },
            hint: Text('หมวดหมู่'),
            isExpanded: true,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          RaisedButton(
            color: kPrimaryColor,
            onPressed: () {
              addEditPost();
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
