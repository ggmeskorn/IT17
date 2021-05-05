import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/addhomelessScreen/components/test.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AddpetsScreen extends StatefulWidget {
  static String routeName = "/addhomeless_screen";

  @override
  _AddpetsScreenState createState() => _AddpetsScreenState();
}

class _AddpetsScreenState extends State<AddpetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "หาบ้านให้น้อง",
      //     style: TextStyle(color: Colors.black87),
      //   ),
      //   iconTheme: IconThemeData(color: kPrimaryColor),
      //   backgroundColor: Colors.white,
      // ),
      body: Upload (),
    );
  }
}
