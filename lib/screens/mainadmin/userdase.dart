import 'dart:convert';

import 'package:final_project/screens/mainadmin/EditUser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../my_constant.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List userall = List();
  Future getAlluser() async {
    var url = '${MyConstant().domain}/homestay/userall.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        userall = jsonData;
      });
    }
    print(userall);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlluser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: ListView.builder(
          itemCount: userall.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUser(
                      userList: userall,
                      index: index,
                    ),
                  ),
                ).whenComplete(() {
                  getAlluser();
                });
              },
              child: Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.network(
                    '${MyConstant().domain}/homestay/Users/${userall[index]['pathImage']}',
                  ),
                  title: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('อีเมล : ' + userall[index]['email'])),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              'ชื่อผู้ใช้ : ' + userall[index]['username'])),
                      Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('รหัสผ่าน : ' + userall[index]['password'])),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('เพศ : ' + userall[index]['gender'])),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('เบอร์ : ' + userall[index]['phone'])),
                    ],
                  ),
                  trailing: IconButton(
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
                                            '${MyConstant().domain}/homestay/deleteUser.php';
                                        var res = await http.post(url, body: {
                                          'id': userall[index]['id'],
                                        });
                                        if (res.statusCode == 200) {
                                          Fluttertoast.showToast(msg: 'ลบ...');
                                          setState(() {
                                            getAlluser();
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
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget cancelButton = FlatButton(onPressed: () {}, child: Text('ยกเลิก'));
  Widget continueButton = FlatButton(onPressed: () {}, child: Text('ตกลง'));
}
