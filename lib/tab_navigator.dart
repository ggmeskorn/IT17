import 'package:final_project/screens/mainuser/page/%20listscreen/list_screen.dart';
import 'package:final_project/screens/mainuser/page/homescreen/home_screen.dart';
import 'package:final_project/screens/mainuser/page/notificationscreen/notification_screen.dart';
import 'package:final_project/screens/mainuser/page/profilescreen/profile_screen.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Home")
      child = HomeScreen();
    else if (tabItem == "List")
      child = ListScreen();
    else if (tabItem == "Notification")
      child = NotificationScreen();
    else if (tabItem == "Profile") child = ProfileScreen();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
