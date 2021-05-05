import 'dart:convert';

import 'package:final_project/constants.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/SelectCategoryBy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../my_constant.dart';

class CategoryListItem extends StatefulWidget {
  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  List categors = List();

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/CategoryAll.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categors = jsonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
          itemCount: categors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryItem(
              category_name: categors[index]['name_category'],
            );
          }),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final category_name;
  CategoryItem({this.category_name});
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Text(
            widget.category_name,
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectCategortBy(category_name: widget.category_name,),
              ),
            );
            debugPrint(widget.category_name);
          },
        ),
      ),
    );
  }
}
