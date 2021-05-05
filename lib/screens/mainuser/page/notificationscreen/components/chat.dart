import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebaseserver/helper/constants.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/widget/widget.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String userName;

  Chat({this.chatRoomId, this.userName});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
  String messageType = 'text';

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].data["message"],
                    sendByMe: Constants.myName ==
                        snapshot.data.documents[index].data["sendBy"],
                  );
                })
            : Container();
      },
    );
  }

  void showAlertDialog(context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(msg),
          );
        });
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: Text(widget.userName),
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey.shade100,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Flexible(
                    child: chatMessages(),
                    // chatMessages()
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
                            Flexible(
                              child: TextField(
                                controller: messageEditingController,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
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
                              onPressed: () async {
                                addMessage();
                              },
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
    // child: Row(
    //   children: [
    //     Expanded(
    //         child: TextField(
    //       controller: messageEditingController,
    //       style: simpleTextStyle(),
    //       decoration: InputDecoration(
    //           hintText: "Message ...",
    //           hintStyle: TextStyle(
    //             color: Colors.black,
    //             fontSize: 16,
    //           ),
    //           border: InputBorder.none),
    //     )),
    //     SizedBox(
    //       width: 16,
    //     ),
    //     GestureDetector(
    //       onTap: () {
    //         addMessage();
    //       },
    //       child: Container(
    //           height: 40,
    //           width: 40,
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   colors: [
    //                     const Color(0x36FFFFFF),
    //                     const Color(0x0FFFFFFF)
    //                   ],
    //                   begin: FractionalOffset.topLeft,
    //                   end: FractionalOffset.bottomRight),
    //               borderRadius: BorderRadius.circular(40)),
    //           padding: EdgeInsets.all(12),
    //           child: Image.asset(
    //             "assets/images/send.png",
    //             height: 25,
    //             width: 25,
    //           )),
    //     ),
    //   ],
    // ),
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xFFFF7643), const Color(0xFFFF7643)]
                  : [const Color(0xFFBBBBBB), const Color(0xFFBBBBBB)],
            )),
        child: Text(message,
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
