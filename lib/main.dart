import 'package:final_project/constants.dart';
import 'package:final_project/screens/mainuser/MainUser.dart';
import 'package:final_project/screens/sign_in_screen/sign_in_screen.dart';
import 'package:final_project/screens/sign_up_screen/sign_up_screen.dart';
import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // initialRoute: SplashScreen.routeName,
      // routes: routes,
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => SplashScreen(),
            );
          case '/sign_in':
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return SignInScreen();
                });
          case '/sign_up':
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return SignUpScreen();
            });
          case '/mainuser':
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              return MainUser();
          // case '/home_screen"':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return HomeScreen();
          //   });
          // case '/inbox_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return InboxScreen();
          //   });
          // case '/notifications_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return NotificationsScreen();
          //   });
          // case '/serach_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return SerachScreen();
          //   });
          // case '/profile_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return ProfileScreen();
          //   });
          // case '/homeless_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return HomelessScreen();
          //   });
          // case '/addhomeless_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return AddhomelessScreen();
          //   });
          // case '/news_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return NewsScreen();
          //   });
          // case '/donate_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return DonateScreen();
          //   });
          // case '/question_screen':
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) {
          //     return QuestionScreen();
            }, transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation.drive(
                    Tween(begin: 1.3, end: 1.0).chain(
                      CurveTween(curve: Curves.easeOutCubic),
                    ),
                  ),
                  child: child,
                ),
              );
            });
          default:
            throw UnimplementedError('no route for $settings');
        }
      },
    );
  }
}
