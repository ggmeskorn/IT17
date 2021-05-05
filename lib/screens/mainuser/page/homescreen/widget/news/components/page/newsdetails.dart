import 'package:final_project/constants.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/newscard.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../size_config.dart';

class NewsDetails extends StatefulWidget {
  final id;
  final username;
  final title;
  final body;
  final category_news;
  final update_at;
  final created_at;
  final pathImagenews;
  final views;

  const NewsDetails(
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
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image.network(
                  '${widget.pathImagenews}',
                  height: 250,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                // Text('  by'),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.username}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('โพตส์เมื่อ : ' + '${widget.created_at}',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              ],
            ),
            // Divider(),
            // Positioned(child: Text('รายละเอียด')),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'รายละเอียด',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w400),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '${widget.body}' == null ? "" : '${widget.body}',
                style: TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: 'Muli'),
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ข่าวสารอื่นๆ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: getProportionateScreenWidth(18)),
                ),
              ),
            ),
            NewsCard()
          ],
        ),
      ),
    );
  }
}
