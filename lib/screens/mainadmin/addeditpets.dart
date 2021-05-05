import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../my_constant.dart';

class AddeditPets extends StatefulWidget {
  final categoryList;
  final index;

  const AddeditPets({Key key, this.categoryList, this.index}) : super(key: key);

  @override
  _AddeditPetsState createState() => _AddeditPetsState();
}

class _AddeditPetsState extends State<AddeditPets> {
  bool editMode = false;
  TextEditingController categoryNamer = TextEditingController();

  // addEditCategory() {
  //   var url = '${MyConstant().domain}/homestay/addCategory.php';
  //   http.post(url, body: {
  //     'name_category': categoryNamer.text,
  //   });
  // }

  Future addEditCategory() async {
    if (categoryNamer.text != "") {
      if (editMode) {
        var url = '${MyConstant().domain}/homestay/updatecategorypets.php';
        http.post(
          url,
          body: {
            'id': widget.categoryList[widget.index]['id'],
            'name_category': categoryNamer.text,
          },
        );
        Fluttertoast.showToast(msg: 'อัพเดตสำเร็จ');

        Navigator.pop(context);
      } else {
        var url = '${MyConstant().domain}/homestay/addcategorypets.php';
        http.post(url, body: {
          'name_category': categoryNamer.text,
        });

        Fluttertoast.showToast(msg: 'เพิ่มสำเร็จ');

        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index != null) {
      editMode = true;
      categoryNamer.text = widget.categoryList[widget.index]['name_category'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'เปลี่ยน' : 'เพิ่ม'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: categoryNamer,
              decoration: InputDecoration(labelText: 'ชื่อหมวดหมู่'),
            ),
          ),
          MaterialButton(
            color: Colors.purple,
            child: Text(
              editMode ? 'แก้ไข' : 'ตกลง',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              addEditCategory();
            },
          )
        ],
      ),
    );
  }
}
