import 'package:final_project/screens/mainuser/components/body.dart';
import 'package:final_project/screens/mainuser/page/%20listscreen/list_screen.dart';
import 'package:final_project/screens/mainuser/page/homescreen/home_screen.dart';
import 'package:final_project/screens/mainuser/page/notificationscreen/notification_screen.dart';
import 'package:final_project/screens/mainuser/page/profilescreen/profile_screen.dart';
import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../../tab_navigator.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // appBar:AppBar(title: Text('Main User'),),
      title: 'Main User',

      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: appBackground),
      home: MainUser(),
    );
  }
}

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String _currentPage = "Home";
  List<String> pageKeys = ["Home", 
  // "List", 
  "Notification",
   "Profile"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "List": GlobalKey<NavigatorState>(),
    "Notification": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;
  String userName;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('Username');
    });
  }

  int selectedIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    ListScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Home") {
            _selectTab("Home", 1);
            // _selectTab("Serach", 2);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFFF7643),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          // currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 27,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    "หน้าหลัก",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined, size: 27),
                title: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    "รายการ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined, size: 27),
                title: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    "ข้อความ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.portrait_rounded, size: 27),
                title: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    "บัญชี",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ))
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget getBody() {
    return pages.elementAt(selectedIndex);
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
