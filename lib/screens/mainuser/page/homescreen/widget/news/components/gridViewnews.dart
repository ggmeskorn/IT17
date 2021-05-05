import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/page/newsdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../my_constant.dart';

class GridViewNews extends StatefulWidget {
  @override
  _GridViewNewsState createState() => _GridViewNewsState();
}

class _GridViewNewsState extends State<GridViewNews> {
  List petsdata2 = List();

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/getnewsall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata2 = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllpost();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 11 / 13),
        itemCount: petsdata2.length,
        itemBuilder: (context, index) {
          return GridViewP(
            pathImagenews:
                '${MyConstant().domain}/homestay/News/${petsdata2[index]['pathImagenews']}',
            title: petsdata2[index]['title'],
            created_at: petsdata2[index]['created_at'],
            body: petsdata2[index]['body'],
            username: petsdata2[index]['username'],
            category_news: petsdata2[index]['category_news'],
            views: petsdata2[index]['Views'],
          );
        });
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
