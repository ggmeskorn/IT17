import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/components/body.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../../constants.dart';
import '../../../../../../my_constant.dart';
import '../../../../../../size_config.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List searchList = [];

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        searchList.add(jsonData[i]['title_post']);
      }
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchPost(list: searchList));
            },
          ),
        ],
      ),
      body: Body(),
    );
  }
}

class SearchPost extends SearchDelegate<String> {
  List<dynamic> list;
  SearchPost({this.list});

  List searchTitle = List();

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/searchPost.php';
    var response = await http.post(url, body: {'title_post': query});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: showAllpost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var list = snapshot.data[index];
                  return ListTile(
                    title: Column(
                      children: [
                        Container(
                          child: Image.network(
                            '${MyConstant().domain}/homestay/Post/${list['image_post']}',
                            height: 250,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              list['body_post'] == null
                                  ? ""
                                  : list['body_post'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // Text('  by'),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            CircleAvatar(
                              radius: 15.0,
                              backgroundImage: NetworkImage(
                                '${MyConstant().domain}/homestay/Users/${list['pathImage']}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                list['author_post'],
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
                              child: Text('โพสต์เมื่อ : ' + list['create_date'],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list
            .where((element) => element.toLowerCase().contains(query))
            .toList();
    return listData.isEmpty
        ? Center(child: Text('ไม่มีข้อมูล'))
        : ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = listData[index];
                  showResults(context);
                },
                title: Text(
                  listData[index],
                ),
              );
            },
          );
  }
}
