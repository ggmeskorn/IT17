import 'dart:convert';

import 'package:final_project/screens/mainadmin/addEditPost.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_constant.dart';

class PostDetails extends StatefulWidget {
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  List post = List();
  Future getAllPost() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        post = jsonData;
      });
    }
    print(post);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลกระทู้'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              String username = preferences.getString('username');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPost(
                    author_post: username,
                  ),
                ),
              ).whenComplete(() {
                getAllPost();
              });
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: post.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String username = preferences.getString('username');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditPost(
                            postList: post,
                            index: index,
                            author_post: username,
                          ),
                        ),
                      ).whenComplete(() {
                        getAllPost();
                      });
                    },
                  ),
                  title: Text(post[index]['title_post']),
                  subtitle: Text(
                    post[index]['body_post'],
                    maxLines: 2,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                          context: (context),
                          builder: (context) => AlertDialog(
                                title: Text("ข้อความ"),
                                content: Text('ลบหมวดหมู่สำเร็จ'),
                                actions: <Widget>[
                                  FlatButton(
                                      onPressed: () async {
                                        var url =
                                            '${MyConstant().domain}/homestay/deletepost.php';
                                        var res = await http.post(url, body: {
                                          'id': post[index]['id'],
                                        });
                                        if (res.statusCode == 200) {
                                          Fluttertoast.showToast(
                                              msg: 'ลบสำเร็จ');
                                          setState(() {
                                            getAllPost();
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text('ตกลง')),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ยกเลิก'))
                                ],
                              ));
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
