import 'dart:convert';
import 'dart:math';

// import 'package:final_project/model/chat_bubble.dart';
import 'package:final_project/firebaseserver/helper/constants.dart';
import 'package:final_project/model/chatUser.dart';
import 'package:final_project/model/data.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../constants.dart';
import '../../../../../my_constant.dart';

class Conversation extends StatefulWidget {
  final id;
  final unique_id;
  final username;
  final email;
  final status;
  final create_at;
  final pathImage;
  final namepets;
  final pathimage;
  final outgoing_msg_id;
  final statuspets;
  final id_pets;

  const Conversation(
      {Key key,
      this.username,
      this.create_at,
      this.pathImage,
      this.namepets,
      this.pathimage,
      this.id_pets,
      this.id,
      this.unique_id,
      this.email,
      this.statuspets,
      this.status,
      this.outgoing_msg_id})
      : super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  List conversationch = List();
  Future conversationByDate() async {
    var url = '${MyConstant().domain}/homestay/getchat.php';
    var response = await http.post(url,
        body: {'pid': widget.id, 'outgoing_msg_id': widget.unique_id});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        conversationch = jsonData;
      });
      print(jsonData);
    }
  }

  static Random random = Random();
  String name = names[random.nextInt(10)];
  Stream chats;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conversationByDate();
  }

  Future<Widget> chatMessages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String unique_id = preferences.getString('unique_id');
    return ListView.builder(
        itemCount: conversationch.length,
        itemBuilder: (context, index) {
          return MessageTile(
            msg: conversationch[index].data["msg_id"],
            outgoing_msg_id:
                unique_id == conversationch[index].data["outgoing_msg_id"],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int prevUserId;
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(''),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: InkWell(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.pathImage,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.username}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
            ),
            onPressed: () {},
          ),
        ],
      ),
      // body: Column(
      //   children: [

      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade100,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    widget.pathimage,
                                  ),
                                  // coffeeShops[index].thumbNail),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Column(
                            children: [
                              Text(
                                'ชื่อ : ' + '${widget.namepets}',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16),
                                    color: Colors.black),
                              ),
                              Text(
                                'สถานนะ : ' + '${widget.statuspets}',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(13),
                                    color: Colors.black),
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45, vertical: 11),
                                      onPressed: () {},
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'ยอมรับ',
                                            // _buttonText,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(2),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 45, vertical: 11),
                                      onPressed: () {},
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'ปฏิเสธ',
                                            // _buttonText,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                        itemCount: conversationch.length,
                        itemBuilder: (context, index) {
                          return MessageTile(
                            msg: conversationch[index]["msg"],
                            outgoing_msg_id: conversationch[index]
                                    ["outgoing_msg_id"] ==
                                conversationch[index]["outgoing_msg_id"],
                          );
                        })

                    // ListView.builder(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   itemCount: conversationch.length,
                    //   reverse: true,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ChatBubbl(
                    //       msg: conversationch[index]['msg'],
                    //       // pathImage: conversationch[index][''],
                    //       pathImage:
                    //           '${MyConstant().domain}/homestay/Users/${conversationch[index]['pathImage']}',

                    //       username: conversationch[index]['username'],
                    //       namepets: conversationch[index]['namepets'],
                    //     );
                    //   },
                    // ),
                    ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomAppBar(
                    elevation: 10,
                    color: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 100,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                          Flexible(
                            child: TextField(
                              style: TextStyle(
                                fontSize: 15.0,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "ส่งข้อความ",
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                ),
                              ),
                              maxLines: null,
                            ),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 11),
                            elevation: 1.0,
                            onPressed: () async {},
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'ส่ง',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            color: kPrimaryColor,
                          ),
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.mic,
                          //     color: Theme.of(context).accentColor,
                          //   ),
                          //   onPressed: () {},
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //   ],
      // ),
      // bottomNavigationBar: ,
    );
  }
}

class MessageTile extends StatelessWidget {
  final msg;
  // bool incoming_msg_id;
  final outgoing_msg_id;

  const MessageTile({Key key, this.msg, this.outgoing_msg_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: outgoing_msg_id ? 0 : 24,
          right: outgoing_msg_id ? 24 : 0),
      alignment: outgoing_msg_id ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: outgoing_msg_id
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: outgoing_msg_id
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: outgoing_msg_id
                  ? [const Color(0xFFFF7643), const Color(0xFFFF7643)]
                  : [const Color(0xFFBBBBBB), const Color(0xFFBBBBBB)],
            )),
        child: Text(msg,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

// class ChatBubbl extends StatefulWidget {
// // List types = ["text", "image"];
//   final id_msg;
//   final types;
//   final incoming;
//   final outcoming;
//   final msg;
//   final pathimage;
//   final nll;
//   final namepets;
//   final time;
//   final username;
//   final isGroup;
//   final isMe;
//   final isreply;
//   final pathImage;
//   final status_online;

//   const ChatBubbl(
//       {Key key,
//       this.id_msg,
//       this.incoming,
//       this.outcoming,
//       this.msg,
//       this.username,
//       this.pathImage,
//       this.status_online,
//       this.nll,
//       this.types,
//       this.time,
//       this.isMe,
//       this.isreply,
//       this.isGroup,
//       this.pathimage,
//       this.namepets})
//       : super(key: key);

//   @override
//   _ChatBubblState createState() => _ChatBubblState();
// }

// class _ChatBubblState extends State<ChatBubbl> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 0.0, right: 10.0),
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   widget.pathImage,
//                 ),
//               ),
//             ),
//             Container(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.80,
//                 ),
//                 padding: EdgeInsets.all(10),
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   widget.msg,
//                   style: TextStyle(
//                     color: Colors.black45,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Container(
//           child: null,
//         ),
//         Column(
//           children: <Widget>[
//             Container(
//               alignment: Alignment.topRight,
//               child: Container(
//                 constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.80,
//                 ),
//                 padding: EdgeInsets.all(10),
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   '${widget.msg}',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               child: null,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
