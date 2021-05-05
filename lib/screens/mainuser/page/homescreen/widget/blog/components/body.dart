import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/components/TopPostCard.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/addPost.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../../../../../../constants.dart';
import '../../../../../../../my_constant.dart';
import 'CategoryListitem.dart';
import 'RecentPostItem.dart';

class Body extends StatefulWidget {


  @override
  _BodyState createState() => _BodyState();
}



class _BodyState extends State<Body> {
  List postall = List();

Future getAllPost() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        postall = jsonData;
      });
    }
    print(postall);
  }

  var curdate = DateFormat("d MMMM y").format(DateTime.now());

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'กระทู้วันนี้',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Nasalization',
                    color: Colors.black),
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
            TopPostCard(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text(
                  'หมวดหมู่ยอดนิยม',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: 'Nasalization',
                  ),
                ),
              ),
            ),
            CategoryListItem(),
            new Divider(
              color: Colors.grey[100],
              // height: 20,
              // thickness: 8,
              // indent: 0,
              // endIndent: 4,
            ),
            RecentPostItem(),
          ],
        ),
        addButton()
      ],
    );
  }

  Row addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(LineIcons.plus),
                backgroundColor: kPrimaryColor,
                onPressed: ()async {
  SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              String username = preferences.getString('username');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(
                    author_post: username,
                  ),
                ),
              ).whenComplete(() {
                getAllPost();
              });

                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
