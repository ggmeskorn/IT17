import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:final_project/model/Pets.dart';
import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../constants.dart';
import '../../../../../my_constant.dart';
import '../../../../../size_config.dart';
import 'package:http/http.dart' as http;

// Body
class Body extends StatefulWidget {
  final username;
  final email;
  Body({this.username = "Guest", this.email = ""});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int list_length;
  double get randHeight => Random().nextInt(100).toDouble();
  List<PetsModels> petsModels = List();
  List<Widget> _randomChildren;
  bool status = true;
  bool loadstatus = true;

  List petsalls = List();

  Future getAllPost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url =
        '${MyConstant().domain}/homestay/getimagewhere.php?isAdd=true&username=$username';
    // var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsalls = jsonData;
      });
      print(petsalls);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPost();
  }

  Widget profileimage(BuildContext context) {
    return Column(
      children: [
        Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/pexels-zen-chung-5745275.jpg',
              height: MediaQuery.of(context).size.height / 3,
              width: 600,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: -40.0,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/profile.jpeg"),
              ),
            ),
            Positioned(
              bottom: -40,
              right: 150,
              child: InkWell(
                onTap: () {
                  // showModalBottomSheet(
                  //     context: context, builder: ((builder) => bottomsheet()));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: kPrimaryColor,
                  size: 22.0,
                ),
              ),
            ),
            Text('data')
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(50)),
        Text(
          widget.username,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontFamily: 'Muli',
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  profileimage(context),
                  // SizedBox(height: getProportionateScreenHeight(50)),
                ]),
              ),
            ];
          },
          // You tab view goes here
          body: Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: getProportionateScreenHeight(50)),
                    TabBar(
                      labelColor: Colors.black,
                      indicatorColor: kPrimaryColor,
                      tabs: [
                        Tab(icon: Icon(Icons.apps_outlined)),
                        Tab(icon: Icon(Icons.chat_outlined)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // loadstatus ? showProgress() : showContent(),
                          ListView.builder(
                            // shrinkWrap: true,
                            // primary: false,
                            itemCount: petsalls.length,
                            itemBuilder: (context, index) {
                              return PetsList(
                                pathimage: petsalls[index]['PathImages'],
                              );
                            },
                          ),
                          showListListViewPets()
                        ],
                      ),
                    ),
                    // addButton()
                  ],
                ),
                addButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> signouting(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    MaterialPageRoute route =
        new MaterialPageRoute(builder: (context) => new SplashScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
    // Navigator.pushReplacementNamed(context,SplashScreen.routeName);
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: <Widget>[
  //       loadstatus ? showProgress() : showContent(),
  //       addButton(),
  //     ],
  //   );
  // }

  Widget showListGridViewPets() => GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        children: Colors.primaries.map((color) {
          return Container(color: color, height: 150.0);
        }).toList(),
      );
  Widget showListListViewPets() => ListView(
        padding: EdgeInsets.zero,
        children: Colors.primaries.map((color) {
          return Container(color: color, height: 150.0);
        }).toList(),
      );

  void routetoAddInfo() {
    // MaterialPageRoute materialPageRoute = MaterialPageRoute(
    //   builder: (context) => AddpetsScreen(),
    // );
    // Navigator.push(context, materialPageRoute).then((value) => readPets());
  }

  Row addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(LineIcons.plus),
                backgroundColor: kPrimaryColor,
                onPressed: () => signouting(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PetsList extends StatefulWidget {
  final pathimage;
  final id_pets;
  final username;

  const PetsList({Key key, this.pathimage, this.id_pets, this.username})
      : super(key: key);

  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // String email = preferences.getString('email');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PostDetails(
          //       pathImage:widget.pathimage,
          //       id_pets:widget.id_pets,
          //       username:widget.username
          //     ),
          //   ),
          // );
        },
        child: Card(
          elevation: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      padding: EdgeInsets.all(5),
                      child: Image.network(
                        widget.pathimage,
                        width: 80,
                        height: 80,
                      ),
                      // width: 100,
                      // height: 150,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0),
                  //   child: Container(
                  //     width: 200,
                  //     child: Text(
                  //       widget.id_pets,
                  //       style: TextStyle(color: Colors.black),
                  //       maxLines: 2,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: const EdgeInsets.all(0.0),
                  //         child: Text(
                  //           'by : ' + widget.author_post,
                  //           style: TextStyle(color: Colors.grey),
                  //         ),
                  //       ),
                  // Padding(
                  //   padding: const EdgeInsets.all(0.0),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: const EdgeInsets.all(0.0),
                  //         child: Text(
                  //           ' โพสต์เมื่อ : ' + widget.create_date,
                  //           style: TextStyle(color: Colors.grey),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}
