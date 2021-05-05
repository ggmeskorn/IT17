import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../my_constant.dart';
import '../../../../../../../size_config.dart';

class RecentPostItem extends StatefulWidget {
  @override
  _RecentPostItemState createState() => _RecentPostItemState();
}

class _RecentPostItemState extends State<RecentPostItem> {
  List recentData = List();
  ScrollController controller = ScrollController();
  Future recentPostData() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        recentData = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentPostData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: recentData.length,
      itemBuilder: (context, index) {
        return RecentItem(
          id: recentData[index]['id'],
          post_id: recentData[index]['post_id'],
          comments: recentData[index]['comments'],
          author_post: recentData[index]['author_post'],
          body_post: recentData[index]['body_post'],
          category_name: recentData[index]['category_name'],
          comments_post: recentData[index]['comments_post'],
          pathImage:
              '${MyConstant().domain}/homestay/Users/${recentData[index]['pathImage']}',
          image_post:
              '${MyConstant().domain}/homestay/Post/${recentData[index]['image_post']}',
          post_date: recentData[index]['post_date'],
          total_Like: recentData[index]['total_Like'],
          create_date: recentData[index]['create_date'],
          title_post: recentData[index]['title_post'],
          // title_post: recentData[index]['title_post'],
          // author_post: recentData[index]['author_post'],
          // create_date: recentData[index]['create_date'],
          // body_post: recentData[index]['body_post'],
          // image_post:
          //     '${MyConstant().domain}/homestay/Post/${recentData[index]['image_post']}',
        );
      },
    );
  }
}

class RecentItem extends StatefulWidget {
  final id;
  final post_id;
  final user_email;
  final image_post;
  final author_post;
  final post_date;
  final comments_post;
  final total_Like;
  final comments;
  final title_post;
  final pathImage;

  final category_name;
  final create_date;
  final body_post;

  const RecentItem(
      {Key key,
      this.id,
      this.post_id,
      this.comments,
      this.user_email,
      this.image_post,
      this.author_post,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.pathImage})
      : super(key: key);

  @override
  _RecentItemState createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return 
    InkWell(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String username = preferences.getString('username');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(
              id: widget.id,
              // pathImage : widget.pathImage,
              post_id: widget.post_id,
              user_email: username,
              pathImage: widget.pathImage,
              comments: widget.comments,
              title_post: widget.title_post,
              image_post: widget.image_post,
              total_Like: widget.total_Like,
              author_post: widget.author_post,
              body_post: widget.body_post,
              create_date: widget.create_date,
              post_date: widget.post_date,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(widget.pathImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              // SizedBox(
                              //   height: getProportionateScreenHeight(2),
                              // ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.author_post,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 2,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.create_date,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.title_post,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                padding: EdgeInsets.all(5),
                child: Image.network(
                  widget.image_post,
                  width: 80,
                  height: 80,
                ),
                // width: 100,
                // height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
