import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/Categorynews.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/gridViewnews.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/news/components/newscard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

var curdate = DateFormat("d MMMM y").format(DateTime.now());

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ข่าววันนี้',
            style: TextStyle(
                fontSize: 25, fontFamily: 'Nasalization', color: Colors.black),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                curdate,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nasalization',
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.today,
                color: Colors.pink,
              ),
            ),
          ],
        ),
        NewsCard(),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Text(
              'หมวดหมู่ต่างๆ',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontFamily: 'Nasalization',
              ),
            ),
          ),
        ),
        CategoryNews(),
        GridViewNews()
      ])
    ]);
  }
}
