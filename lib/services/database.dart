import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData, userId) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   final QuerySnapshot result = await Firestore.instance
    //       .collection('users')
    //       .where('userId', isEqualTo: prefs.get('userId'))
    //       .getDocuments();
    //   final List<DocumentSnapshot> documents = result.documents;
    //   String myID = userId;
    //   if (documents.length == 0) {
    //     await prefs.setString('userId', userId);
    //     await Firestore.instance
    //         .collection('users')
    //         .document(userId)
    //         .setData(userData);
    //   } else {
    //     myID = documents[0]['userId'];
    //     await prefs.setString('userId', myID);
    //     await Firestore.instance
    //         .collection('users')
    //         .document(myID)
    //         .updateData(userData);
    //   }
    //   return [myID];
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
