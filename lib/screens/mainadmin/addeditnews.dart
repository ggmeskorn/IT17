import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../my_constant.dart';
import '../../size_config.dart';

class AddEditNews extends StatefulWidget {
  final postList;
  final index;
  final admin_id;
  const AddEditNews({Key key, this.postList, this.index, this.admin_id})
      : super(key: key);
  @override
  _AddEditNewsState createState() => _AddEditNewsState();
}

class _AddEditNewsState extends State<AddEditNews> {
  File _image;
  final picker = ImagePicker();

  String selectedCategory;
  List categoryItem = List();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController admin_id = TextEditingController();
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
      String id = preferences.getString('id');
      print('id_Image = $id');
      var uri = Uri.parse("${MyConstant().domain}/homestay/updatanews.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['id'] = widget.postList[widget.index]['id'];
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['admin_id'] = id;
      request.fields['category_news'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('pathImagenews', _image.path,
          filename: _image.path);

      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'อัปเดตโพสต์สำเร็จ');
        Navigator.pop(context);
        print(title.text);
      }
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String id = preferences.getString('id');
      print('id_Image = $id');
      var uri = Uri.parse("${MyConstant().domain}/homestay/add.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['admin_id'] = id;
      request.fields['category_news'] = selectedCategory;

      var pic = await http.MultipartFile.fromPath('pathImagenews', _image.path,
          filename: _image.path);

      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'เพิ่มโพสต์สำเร็จ');
        Navigator.pop(context);
        print(title.text);
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
      title.text = widget.postList[widget.index]['title'];
      body.text = widget.postList[widget.index]['body'];
      selectedCategory = widget.postList[widget.index]['category_news'];
    }
  }

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/category_news.php';
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
              controller: title,
              decoration: InputDecoration(labelText: 'หัวข้อ'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: body,
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
                      '${MyConstant().domain}/homestay/News/${widget.postList[widget.index]['pathImagenews']}'),
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
                  value: category['news_category'],
                  child: Text(category['news_category']));
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
