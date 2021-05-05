import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/SelectCategoryBy.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/page/selectCategoryBynews.dart';
import 'package:flutter/material.dart';

import '../../../../../../../my_constant.dart';
import 'package:http/http.dart' as http;

class CategoryNews extends StatefulWidget {
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List categors = List();

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/category_news.php';
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
              category_news: categors[index]['news_category'],
            );
          }),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final category_news;
  CategoryItem({this.category_news});
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
            widget.category_news,
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelctCategoryBynews(
category_news: widget.category_news,
                ),
              ),
            );
            debugPrint(widget.category_news);
          },
        ),
      ),
    );
  }
}
