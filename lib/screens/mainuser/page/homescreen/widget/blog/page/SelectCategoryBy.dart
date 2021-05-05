import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../my_constant.dart';
import '../../../../../../../size_config.dart';

class SelectCategortBy extends StatefulWidget {
  final category_name;
  SelectCategortBy({this.category_name});
  @override
  _SelectCategortByState createState() => _SelectCategortByState();
}

class _SelectCategortByState extends State<SelectCategortBy> {
  List categoryByPosts = List();
  Future categoryByDate() async {
    var url = '${MyConstant().domain}/homestay/categoryByPost.php';
    var response =
        await http.post(url, body: {"name_category": widget.category_name});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryByPosts = jsonData;
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
        title: Text(widget.category_name),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: categoryByPosts.length,
          itemBuilder: (context, index) {
            return NewPostItem(
              id: categoryByPosts[index]['id'],
              post_id: categoryByPosts[index]['post_id'],
              comments: categoryByPosts[index]['comments'],
              author_post: categoryByPosts[index]['author_post'],
              body_post: categoryByPosts[index]['body_post'],
              category_name: categoryByPosts[index]['category_name'],
              comments_post: categoryByPosts[index]['comments_post'],
              pathImage:
                  '${MyConstant().domain}/homestay/Users/${categoryByPosts[index]['pathImage']}',
              image_post:
                  '${MyConstant().domain}/homestay/Post/${categoryByPosts[index]['image_post']}',
              post_date: categoryByPosts[index]['post_date'],
              total_Like: categoryByPosts[index]['total_Like'],
              create_date: categoryByPosts[index]['create_date'],
              title_post: categoryByPosts[index]['title_post'],
            );
          },
        ),
      ),
    );
  }
}

class NewPostItem extends StatefulWidget {
  final image_post;
  final author_post;
  final post_date;
  final comments_post;
  final total_Like;
  final title_post;
  final category_name;
  final create_date;
  final id;
  final post_id;
  final user_email;
  final comments;
  final pathImage;
  final body_post;
  NewPostItem(
      {this.image_post,
      this.author_post,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.id,
      this.post_id,
      this.user_email,
      this.comments,
      this.pathImage});

  @override
  _NewPostItemState createState() => _NewPostItemState();
}

class _NewPostItemState extends State<NewPostItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
