import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../my_constant.dart';
import 'addeditCategoryNews.dart';

class CategoryNews extends StatefulWidget {
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List category = List();
  Future getAllcategory() async {
    var url = '${MyConstant().domain}/homestay/category_news.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        category = jsonData;
      });
    }
    print(category);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllcategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หมวดหมู่ข่าว'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditNews(),
                ),
              ).whenComplete(() {
                getAllcategory();
              });
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: category.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditNews(
                          categoryList: category,
                          index: index,
                        ),
                      ),
                    ).whenComplete(() {
                      getAllcategory();
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
                title: Text(category[index]['news_category']),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: (context),
                        builder: (context) => AlertDialog(
                              title: Text("ข้อความ"),
                              content: Text('ลบหมวดหมู่สำเร็จ'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      var url =
                                          '${MyConstant().domain}/homestay/deletenews.php';
                                      var res = await http.post(url, body: {
                                        'id': category[index]['id'],
                                      });
                                      if (res.statusCode == 200) {
                                        Fluttertoast.showToast(msg: 'ลบสำเร็จ');
                                        setState(() {
                                          getAllcategory();
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text('ตกลง')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('ยกเลิก'))
                              ],
                            ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget cancelButton = FlatButton(onPressed: () {}, child: Text('ยกเลิก'));
  Widget continueButton = FlatButton(onPressed: () {}, child: Text('ตกลง'));
}
