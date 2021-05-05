import 'dart:convert';

import 'package:final_project/screens/mainuser/page/notificationscreen/components/conversation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../my_constant.dart';

class ChatItem extends StatefulWidget {
  final id;
  final pathimagepets;
  final namepets;
  final isOnline;
  final msg;

  ChatItem({
    Key key,
    this.id,
    this.pathimagepets,
    this.namepets,
    this.isOnline,
    this.msg,
  }) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.pathimagepets,
              ),
              radius: 25,
            ),
            Positioned(
              bottom: 0.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 11,
                width: 11,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.isOnline ? Colors.greenAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          widget.namepets,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.msg,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        // trailing: Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: <Widget>[
        //     SizedBox(height: 10),
        //     Text(
        //       "${widget.time}",
        //       style: TextStyle(
        //         fontWeight: FontWeight.w300,
        //         fontSize: 11,
        //       ),
        //     ),
        //     SizedBox(height: 5),
        //     widget.counter == 0
        //         ? SizedBox()
        //         : Container(
        //             padding: EdgeInsets.all(1),
        //             decoration: BoxDecoration(
        //               color: Colors.red,
        //               borderRadius: BorderRadius.circular(6),
        //             ),
        //             constraints: BoxConstraints(
        //               minWidth: 11,
        //               minHeight: 11,
        //             ),
        //             child: Padding(
        //               padding: EdgeInsets.only(top: 1, left: 5, right: 5),
        //               child: Text(
        //                 "${widget.counter}",
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 10,
        //                 ),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //           ),
        //   ],
        // ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Conversation();
              },
            ),
          );
        },
      ),
    );
  }
}
