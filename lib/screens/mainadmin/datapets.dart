import 'dart:convert';

import 'package:final_project/screens/mainadmin/AddPets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../my_constant.dart';

class DataPets extends StatefulWidget {
  @override
  _DataPetsState createState() => _DataPetsState();
}

class _DataPetsState extends State<DataPets> {
  List pets = List();
  Future getAllPost() async {
    var url = '${MyConstant().domain}/homestay/getpetsall.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        pets = jsonData;
      });
    }
    print(pets);
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
        title: Text('สัตว์เลี้ยง'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // String id = preferences.getString('id');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AddPets(
              //       // admin_id: id,
              //     ),
              //   ),
              // ).whenComplete(() {
              //   getAllPost();
              // });
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    '${MyConstant().domain}/homestay/Pets/${pets[index]['pathimagepets']}',
                    height: 150,
                    width: 100,
                  ),
                  title: Text("ชื่อ : " + pets[index]['namepets']),
                  subtitle: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("เพศ : " + pets[index]['genderpets'],
                            maxLines: 7),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("สถานะ : " + pets[index]['statuspets'],
                            maxLines: 7),
                      ),
                    ],
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
                                            '${MyConstant().domain}/homestay/datapetsdelete.php';
                                        var res = await http.post(url, body: {
                                          'id': pets[index]['id'],
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
