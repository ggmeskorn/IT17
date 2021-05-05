import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../my_constant.dart';
import '../../../../../../../size_config.dart';

class TopPostCard extends StatefulWidget {
  @override
  _TopPostCardState createState() => _TopPostCardState();
}

class _TopPostCardState extends State<TopPostCard> {
  List postData = List();

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        postData = jsonData;
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
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postData.length == null
            ? CircularNotchedRectangle()
            : postData.length,
        itemBuilder: (context, index) {
          return NewPostItem(
            id: postData[index]['id'],
            post_id: postData[index]['post_id'],
            author_post: postData[index]['author_post'],
            body_post: postData[index]['body_post'],
            category_name: postData[index]['category_name'],
            comments_post: postData[index]['comments_post'],
            pathImage:
                '${MyConstant().domain}/homestay/Users/${postData[index]['pathImage']}',
            image_post:
                '${MyConstant().domain}/homestay/Post/${postData[index]['image_post']}',
            post_date: postData[index]['post_date'],
            total_Like: postData[index]['total_Like'],
            create_date: postData[index]['create_date'],
            title_post: postData[index]['title_post'],
          );
        },
      ),
    );
  }
}

class NewPostItem extends StatefulWidget {
  final image_post;
  final id;
  final post_id;

  final author_post;
  final post_date;
  final comments_post;
  final total_Like;
  final user_email;
  final title_post;
  final category_name;
  final create_date;
  final pathImage;
  final body_post;
  NewPostItem(
      {this.image_post,
      this.author_post,
      this.post_id,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.id,
      this.user_email,
      this.pathImage});

  @override
  _NewPostItemState createState() => _NewPostItemState();
}

class _NewPostItemState extends State<NewPostItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String email = preferences.getString('email');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetails(
                id: widget.id,
                post_id: widget.post_id,
                pathImage: widget.pathImage,
                user_email: email,
                total_Like: widget.total_Like,
                title_post: widget.title_post,
                image_post: widget.image_post,
                author_post: widget.author_post,
                create_date: widget.create_date,
                body_post: widget.body_post,
                post_date: widget.post_date,
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topRight,
                    //   end: Alignment.bottomLeft,
                    //   colors: [
                    //     Colors.amber,
                    //     Colors.pink,
                    //   ],
                    // ),
                    image: DecorationImage(
                        image: NetworkImage(widget.image_post),
                        // coffeeShops[index].thumbNail),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                // color: Colors.amber,
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: CircleAvatar(
                radius: 20,
                // child: Icon(Icons.person),
                backgroundImage: NetworkImage(widget.pathImage),
              ),
            ),
            Positioned(
              top: 30,
              left: 100,
              child: Text(
                "by  :  " + widget.author_post,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli'),
              ),
            ),
            Positioned(
              top: 30,
              left: 200,
              child: Text(
                "เมื่อ : " + widget.create_date,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli'),
              ),
            ),
            // Positioned(
            //   top: 60,
            //   left: 100,
            //   child: Icon(
            //     Icons.comment,
            //     color: Colors.white,
            //   ),
            // ),
            // Positioned(
            //   top: 60,
            //   left: 140,
            //   child: Text(
            //     widget.comments_post,
            //     style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontFamily: 'Muli'),
            //   ),
            // ),
            Positioned(
              top: 60,
              left: 180,
              child: Icon(
                Icons.label,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 60,
              left: 210,
              child: Text(
                widget.total_Like,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli'),
              ),
            ),
            Positioned(
              top: 95,
              left: 30,
              child: Container(
                width: 300,
                child: Text(
                  widget.title_post,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  maxLines: 2,
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: 30,
              child: Text(
                "Read More",
                style: TextStyle(color: Colors.white, fontFamily: 'Muli'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
