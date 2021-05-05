import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/page/newsdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../my_constant.dart';

class NewsCard extends StatefulWidget {
  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  List newsdata = List();

  Future showAllnews() async {
    var url = '${MyConstant().domain}/homestay/getnewsDecs.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        newsdata = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllnews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: newsdata.length,
          itemBuilder: (context, index) {
            return CP(
              pathImagenews:
                  '${MyConstant().domain}/homestay/News/${newsdata[index]['pathImagenews']}',
              title: newsdata[index]['title'],
              created_at: newsdata[index]['created_at'],
              body: newsdata[index]['body'],
              username: newsdata[index]['username'],
              category_news: newsdata[index]['category_news'],
              views: newsdata[index]['Views'],
            );
          },
        ),
      ),
    );
  }
}

class CP extends StatefulWidget {
  final id;
  final username;
  final title;
  final body;
  final category_news;
  final update_at;
  final created_at;
  final pathImagenews;
  final views;

  const CP(
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
  _CPState createState() => _CPState();
}

class _CPState extends State<CP> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        child: Container(
          height: 250.0,
          width: 140.0,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${widget.pathImagenews}',
                  height: 178.0,
                  width: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3.0),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     'คนดู : ' + '${widget.views}',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 13.0,
              //       color: Colors.blueGrey[300],
              //     ),
              //     maxLines: 1,
              //     textAlign: TextAlign.left,
              //   ),
              // ),
            ],
          ),
        ),
        onTap: () async {
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
      ),
    );
  }
}
