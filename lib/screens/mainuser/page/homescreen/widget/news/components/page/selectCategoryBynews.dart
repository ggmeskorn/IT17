import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/page/newsdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../../my_constant.dart';
import '../../../../../../../../size_config.dart';

class SelctCategoryBynews extends StatefulWidget {
  final category_news;
  SelctCategoryBynews({Key key, this.category_news}) : super(key: key);

  @override
  _SelctCategoryBynewsState createState() => _SelctCategoryBynewsState();
}

class _SelctCategoryBynewsState extends State<SelctCategoryBynews> {
  List categoryByNews = List();
  Future categoryByDate() async {
    var url = '${MyConstant().domain}/homestay/categorybynews.php';
    var response =
        await http.post(url, body: {"news_category": widget.category_news});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryByNews = jsonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category_news),
      ),
      body: Container(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 11 / 13),
            itemCount: categoryByNews.length,
            itemBuilder: (context, index) {
              return GridViewP(
                pathImagenews:
                    '${MyConstant().domain}/homestay/News/${categoryByNews[index]['pathImagenews']}',
                title: categoryByNews[index]['title'],
                created_at: categoryByNews[index]['created_at'],
                body: categoryByNews[index]['body'],
                username: categoryByNews[index]['username'],
                category_news: categoryByNews[index]['category_news'],
                views: categoryByNews[index]['Views'],
              );
            }),
      ),
    );
  }
}

class GridViewP extends StatefulWidget {
  final id;
  final username;
  final title;
  final body;
  final category_news;
  final update_at;
  final created_at;
  final pathImagenews;
  final views;

  const GridViewP(
      {Key key,
      this.id,
      this.username,
      this.title,
      this.body,
      this.category_news,
      this.update_at,
      this.created_at,
      this.pathImagenews,
      this.views})
      : super(key: key);

  @override
  _GridViewPState createState() => _GridViewPState();
}

class _GridViewPState extends State<GridViewP> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.pathImagenews,
              height: 178.0,
              width: 140.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 7.0),
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
            // maxLines: 2,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 3.0),
          Text(
            widget.created_at,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Colors.blueGrey[300],
            ),
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 3.0),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetails(
              id: widget.id,
              username: widget.username,
              title: widget.title,
              body: widget.body,
              pathImagenews: widget.pathImagenews,
              created_at: widget.created_at,
              category_news: widget.category_news,
            ),
          ),
        );
      },
    );
  }
}
