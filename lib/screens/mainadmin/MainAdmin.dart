import 'package:final_project/constants.dart';
import 'package:final_project/screens/mainadmin/CategoryDetails.dart';
import 'package:final_project/screens/mainadmin/categorynews.dart';
import 'package:final_project/screens/mainadmin/newsdata.dart';
import 'package:final_project/screens/mainadmin/postDetails.dart';
import 'package:final_project/screens/mainadmin/userdase.dart';
import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categorypets.dart';
import 'datapets.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Widget menuDrawer() {
      return Drawer(
        child: ListView(
          children: <Widget>[
            // UserAccountsDrawerHeader(
            //   decoration: BoxDecoration(color: kPrimaryColor),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: Icon(
            //       Icons.person,
            //     ),
            //   ),
            //   // accountName: Text('Username'),
            //   // accountEmail: Text('Email'),
            // ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
                debugPrint("หน้าหลัก");
              },
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
              title: Text(
                'หน้าหลัก',
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(),
                  ),
                );
                debugPrint("ติดต่อ");
              },
              leading: Icon(
                Icons.contacts,
                color: Colors.green,
              ),
              title: Text(
                'ข้อมูลผู้ใช้งาน',
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryDetails(),
                  ),
                );
                debugPrint("เกี่ยวกับ");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'เพิ่มหมวดหมู่ของกระทู้',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryNews(),
                  ),
                );
                debugPrint("เกี่ยวกับ");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'เพิ่มหมวดหมู่ของข่าว',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryPets(),
                  ),
                );
                debugPrint("เกี่ยวกับ");
              },
              leading: Icon(
                Icons.label,
                color: Colors.grey,
              ),
              title: Text(
                'เพิ่มหมวดหมู่ของสัตว์',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetails(),
                  ),
                );
                debugPrint("ติดต่อ");
              },
              leading: Icon(
                Icons.article_outlined,
                color: Colors.blue,
              ),
              title: Text(
                'ข้อมูลกระทู้',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsData(),
                  ),
                );
                debugPrint("ติดต่อ");
              },
              leading: Icon(
                Icons.article_outlined,
                color: Colors.blue,
              ),
              title: Text(
                'ข้อมูลข่าว',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataPets(),
                  ),
                );
                debugPrint("ติดต่อ");
              },
              leading: Icon(
                Icons.article_outlined,
                color: Colors.blue,
              ),
              title: Text(
                'ข้อมูลสัตว์เลี้ยง',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            ListTile(
              onTap: () {
                signouting(context);
                debugPrint("logout");
              },
              leading: Icon(
                Icons.lock_open,
                color: Colors.red,
              ),
              title: Text(
                'ออกจากระบบ',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('แผงควบคุม'),
      ),
      body: ListView(
        children: <Widget>[
          // myGridView(),
        ],
      ),
      drawer: menuDrawer(),
    );
  }

  // Widget myGridView() {
  //   return SingleChildScrollView(
  //     child: Container(
  //       height: 250,
  //       child: GridView.count(
  //         crossAxisSpacing: 5,
  //         crossAxisCount: 2,
  //         mainAxisSpacing: 5,
  //         padding: EdgeInsets.all(5),
  //         children: <Widget>[
  //           Container(
  //             color: Colors.green,
  //             child: Center(
  //               child: Text(
  //                 'Total Post 10',
  //                 style: TextStyle(
  //                     fontSize: 20, fontFamily: 'Muli', color: Colors.white),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             color: Colors.amber,
  //             child: Center(
  //               child: Text(
  //                 'Total Category 10',
  //                 style: TextStyle(
  //                     fontSize: 20, fontFamily: 'Muli', color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<Null> signouting(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    MaterialPageRoute route =
        new MaterialPageRoute(builder: (context) => new SplashScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
    // Navigator.pushReplacementNamed(context,SplashScreen.routeName);
  }
}
