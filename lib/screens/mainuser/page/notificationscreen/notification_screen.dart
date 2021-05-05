import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:final_project/firebaseserver/helper/constants.dart';
import 'package:final_project/firebaseserver/helper/helperfunctions.dart';
import 'package:final_project/firebaseserver/helper/theme.dart';
import 'package:final_project/model/chat_item.dart';
import 'package:final_project/model/com_ments.dart';
import 'package:final_project/model/data.dart';
import 'package:final_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../my_constant.dart';
import 'components/chat.dart';
import 'components/conversation.dart';
import 'components/search.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List<CommentsModel> commentsModels = List();

  bool status = true;
  bool loadstatus = true;

  Future updateNotification(String id) async {
    var url = "${MyConstant().domain}/homestay/updateNofitication.php";
    var res = await http.post(url, body: {"id": id});
    if (res.statusCode == 200) {
      print('od');
    }
  }

  List chatdata = List();

  Future showAllchat() async {
    var url = '${MyConstant().domain}/homestay/getchat.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        chatdata = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    super.initState();
    // totalComments();
    getUserInfogetChats();
    getTotalUnSeenNotification();
    // getunseenNotification();
    //
    readComments();
    showAllchat();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showContent() {
    return status
        ? showListComments()
        : Center(
            child: Text('ยังไม่มีข้อมูล'),
          );
  }

  bool editMode = false;
  var total;
  Future getTotalUnSeenNotification() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url =
        '${MyConstant().domain}/homestay/selectCommentsNotification.php?author_post=$username';
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var jsonData = json.decode(res.body);
      setState(() {
        total = jsonData;
      });
    }
    print(total);
  }

  Future<Null> readComments() async {
    if (commentsModels.length != 0) {
      commentsModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    print('username = $username');

    String url =
        '${MyConstant().domain}/homestay/testing.php?isAdd=true&author_post=$username';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        print('value ==>> $value');
        var result = json.decode(value.data);
        print('result => $result');
        for (var map in result) {
          CommentsModel commentsModel = CommentsModel.fromJson(map);
          setState(() {
            commentsModels.add(commentsModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Stream chatRooms;
  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSeen = true;

    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: TextField(
      //     decoration: InputDecoration.collapsed(
      //       hintText: 'ค้นหา',
      //     ),
      //   ),
      appBar: AppBar(
        title: Text('การแจ้งเตือน', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
              // showSearch(
              //     context: context, delegate: SearchPost(list: searchList));
            },
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).textTheme.caption.color,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "แชต",
            ),
            isSeen
                ? Badge(
                    badgeContent: Text(
                      '$total',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Tab(
                      text: "แจ้งเตือน",
                    ),
                  )
                : Badge(
                    badgeContent: Text(
                      '0',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Tab(
                      text: "แจ้งเตือน",
                    ),
                  ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          chatRoomsList(),
          // ListView.separated(
          //   padding: EdgeInsets.all(10),
          //   separatorBuilder: (BuildContext context, int index) {
          //     return Align(
          //       alignment: Alignment.centerRight,
          //       child: Container(
          //         height: 0.5,
          //         width: MediaQuery.of(context).size.width / 1.3,
          //         child: Divider(),
          //       ),
          //     );
          //   },
          //   itemCount: chatdata.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     Map chat = chatdata[index];
          //     return Container();
          //     // return ChatItems(
          //     //   // // pathimagepets:
          //     //   //     '${MyConstant().domain}/homestay/Pets/${chat['pathimage']}',
          //     //   namepets: chat['namepets'],
          //     //   userimage:
          //     //       '${MyConstant().domain}/homestay/Users/${chat['pathImage']}',

          //     //   msg: chat['msg'],

          //     //   // dp: chat['dp'],
          //     //   // name: chat['name'],
          //     //   // isOnline: chat['isOnline'],
          //     //   // counter: chat['counter'],
          //     //   // msg: chat['msg'],
          //     //   // time: chat['time'],
          //     // );
          //   },
          // ),

          // loadstatus ? showProgress() : showContent(),
          // ListView.builder(
          //     itemCount: allUnSeenNotification.length,
          //     itemBuilder: (context, index) {
          //       var list = allUnSeenNotification[index];
          //       return ListTile(
          //         title: Text(list['comments']),
          //       );
          //     })
          Stack(
            children: [
              // showListComments()
              loadstatus ? showProgress() : showContent(),

              // loadstatus
              //     ? showProgress()
              //     : ListView.separated(
              //         padding: EdgeInsets.all(10),
              //         separatorBuilder: (BuildContext context, int index) {
              //           return Align(
              //             alignment: Alignment.centerRight,
              //             child: Container(
              //               height: 0.5,
              //               width: MediaQuery.of(context).size.width / 1.3,
              //               child: Divider(),
              //             ),
              //           );
              //         },
              //         itemCount: allUnSeenNotification.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           var list = allUnSeenNotification[index];

              //           return Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: ListTile(
              //               leading: CircleAvatar(
              //                 backgroundImage:
              //                     AssetImage('assets/images/pawprints.png'),
              //                 radius: 25,
              //               ),
              //               contentPadding: EdgeInsets.all(0),
              //               title: Text(list['user_email']),
              //               subtitle: Text(list['comments']),
              //               trailing: Text(
              //                 list['comments_date'],
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w300,
              //                   fontSize: 11,
              //                 ),
              //               ),
              //               onTap: () {
              //                 updateNotification(list['id'])
              //                     .whenComplete(() => getunseenNotification());
              //               },
              //             ),
              //           );
              //         },
              //       )
            ],
          ),
        ],
      ),
    );
  }

  Widget showListComments() => ListView.separated(
        padding: EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Divider(),
            ),
          );
        },
        itemCount: commentsModels.length,
        itemBuilder: (BuildContext context, int index) {
          var list = commentsModels[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pawprints.png'),
                radius: 25,
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text('${list.authorpost}'),
              subtitle: Text('${list.comments}'),
              trailing: Text(
                '${list.commentsdate}',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
              onTap: () {
                updateNotification(list.id).whenComplete(() => readComments());
              },
            ),
          );
        },
      );

  @override
  bool get wantKeepAlive => true;
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                      userName: userName,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: CustomTheme.colorAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
