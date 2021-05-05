import 'dart:convert';

import 'package:final_project/components/form_error.dart';
import 'package:final_project/constants.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../my_constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PostDetails extends StatefulWidget {
  final image_post;
  final id;
  final post_id;
  final author_post;
  final post_date;
  final pathImage;
  final comments_post;
  final total_Like;
  final title_post;
  final category_name;
  final comments;
  final create_date;
  final body_post;
  final user_email;

  const PostDetails(
      {Key key,
      this.post_id,
      this.image_post,
      this.id,
      this.comments,
      this.author_post,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.user_email,
      this.pathImage})
      : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TextEditingController commentsController = TextEditingController();

  String isLikeOrDislike = "";
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final fieldText = TextEditingController();

  String commentsText;
  Future addLike() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url = '${MyConstant().domain}/homestay/addLike.php';
    var res = await http
        .post(url, body: {'user_email': username, 'post_id': widget.id});
    if (res.statusCode == 200) {
      print('ขอบคุณ');
    }
  }

  Future getLike() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    var url = '${MyConstant().domain}/homestay/selectLike.php';
    var res = await http
        .post(url, body: {'user_email': id, 'post_id': widget.id});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      setState(() {
        isLikeOrDislike = data;
      });
    }
    print(isLikeOrDislike);
  }

  Future addComments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url = '${MyConstant().domain}/homestay/addcomments.php';
    var res = await http.post(url, body: {
      'comments': commentsController.text,
      'user_email': username,
      'post_id': widget.id,
      'author_post': widget.author_post
    });
    if (res.statusCode == 200) {
      showNotification();
      Fluttertoast.showToast(msg: 'เพิ่มสำเร็จ');
      clearText();
      // Navigator.pop(context);
    }
  }

  List commentsByPosts = List();
  Future commentsByDate() async {
    var url = '${MyConstant().domain}/homestay/commentsbyPost.php';
    var response = await http.post(url, body: {'post_id': widget.id});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        commentsByPosts = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentsByDate();
    getLike();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher'); //logo
    var ios = IOSInitializationSettings();
    var initilize = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initilize,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      debugPrint("Notification : " + payload);
    }
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(
        0,
        'HOMESTAY เพื่อช่วยให้มีชีวิตที่ดีขึ้น',
        commentsController.text,
        platform,
        payload: 'some details value');
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void clearText() {
    commentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title_post),
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
                  widget.image_post,
                  height: 250,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.body_post == null ? "" : widget.body_post,
                style: TextStyle(
                    color: Colors.black, fontSize: 18, fontFamily: 'Muli'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  isLikeOrDislike == "ONE"
                      ? Padding(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: () {
                              addLike().whenComplete(() => getLike());
                            },
                            child: Icon(
                              Icons.thumb_up,
                              color: kPrimaryColor,
                            ),
                            // child: Text(
                            //   'Unlike',
                            //   style: TextStyle(color: Colors.blue),
                            // ),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.black,
                          onPressed: () {
                            addLike().whenComplete(() => getLike());
                          }),
                  Text(
                    widget.total_Like,
                    style: TextStyle(color: Colors.grey),
                  ),
                  IconButton(icon: Icon(Icons.thumb_down), onPressed: () {})
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            Row(
              children: <Widget>[
                // Text('  by'),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(widget.pathImage),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.author_post,
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
                  child: Text('โพสต์เมื่อ : ' + widget.create_date,
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildNamePetsFormField(),
                      // child: TextField(
                      //   controller: commentsController,
                      //   decoration: InputDecoration(labelText: 'Enter Comments'),
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 600,
                        child: MaterialButton(
                          color: kPrimaryColor,
                          child: Text(
                            'ส่งข้อความ',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              if (commentsText == null ||
                                  commentsText.isEmpty) {
                              } else {
                                addComments()
                                    .whenComplete(() => commentsByDate());
                              }
                            }

                            // addComments();
                          },
                        ),
                      ),
                    ),
                    FormError(errors: errors),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ความคิดเห็น ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Muli'),
              ),
            ),
            BuildNewSection(),
          ],
        ),
      ),
    );
  }

  TextFormField buildNamePetsFormField() {
    return TextFormField(
      controller: commentsController,
      onSaved: (newValue) => commentsText = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kcommentsNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: commentsNullError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.left,
      decoration: InputDecoration.collapsed(hintText: "ข้อความ"),
    );
  }

  BuildNewSection() {
    return ListView.builder(
      itemCount: commentsByPosts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Commentsby(
          user_email: commentsByPosts[index]['user_email'],
          comments: commentsByPosts[index]['comments'],
          comments_date: commentsByPosts[index]['comments_date'],
        );
      },
    );
  }
}

class Commentsby extends StatefulWidget {
  final comments;
  final user_email;
  final comments_date;

  const Commentsby(
      {Key key, this.comments, this.user_email, this.comments_date})
      : super(key: key);
  @override
  _CommentsbyState createState() => _CommentsbyState();
}

class _CommentsbyState extends State<Commentsby> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment(-1.0, 0.0),
                  child: Text(
                    " " + widget.user_email,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment(-1.0, 0.0),
                  child: Text(
                    "เมื่อ : " + widget.comments_date,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 1.0, bottom: 20.0),
            child: Align(
              alignment: Alignment(-1.0, 0.0),
              child: Text(
                widget.comments,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
