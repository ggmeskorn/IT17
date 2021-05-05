import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:final_project/model/Pets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/postDetails.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/petsdetails.dart';
import 'package:final_project/screens/splash/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../my_constant.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool status = true;
  bool loadstatus = true;
  double get randHeight => Random().nextInt(100).toDouble();
  List<PetsModels> petsModels = List();

  List petsdata2 = List();

  Future showAllpost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    var url = '${MyConstant().domain}/homestay/getpetsid.php?id=$id';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata2 = jsonData;
      });
      print(jsonData);
    }
  }

  List<Widget> _randomChildren;

  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(3, (index) {
      final height = randHeight.clamp(
        50.0,
        MediaQuery.of(context)
            .size
            .width, // simply using MediaQuery to demonstrate usage of context
      );
      return Container(
        color: Colors.primaries[index],
        height: height,
        child: Text('Random Height Child ${index + 1}'),
      );
    });

    return _randomChildren;
  }

  List recentData = List();
  ScrollController controller = ScrollController();
  Future recentPostData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url =
        '${MyConstant().domain}/homestay/postgetid.php?username=$username';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        recentData = jsonData;
      });
      print(jsonData);
    }
  }

  List userData = List();

  Future showuser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    var url = '${MyConstant().domain}/homestay/getuser.php?isAdd=true&id=$id';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        userData = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showuser();
    showAllpost();
    recentPostData();
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userData.length,
                      itemBuilder: (context, index) {
                        return Getuser(
                          pathImage:
                              '${MyConstant().domain}/homestay/Users/${userData[index]['pathImage']}',
                          username: userData[index]['username'],
                          email: userData[index]['email'],
                          // pathImage:
                          //     '${MyConstant().domain}/homestay/Users/${userData[index]['pathImage']}',
                        );
                      }),
                  Center(
                    child: InkWell(
                      onTap: () {
                        signouting(context);
                      },
                      child: Text(
                        'ออกจากระบบ',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w200,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ]),
              ),
            ];
          },
          // You tab view goes here
          body: Stack(
            children: [
              Column(
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.grid_on_outlined, size: 27),
                      ),
                      Tab(
                        icon: Icon(Icons.chat_outlined, size: 27),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 11 / 13,
                            ),
                            itemCount: petsdata2.length,
                            itemBuilder: (context, index) {
                              return GridViewP(
                                id: petsdata2[index]['id'],
                                pathimagepets:
                                    '${MyConstant().domain}/homestay/Pets/${petsdata2[index]['pathimagepets']}',
                                pathImage:
                                    '${MyConstant().domain}/homestay/Users/${petsdata2[index]['pathImage']}',
                                pathimage:
                                    '${MyConstant().domain}/homestay/Pets/${petsdata2[index]['pathimage']}',
                                namepets: petsdata2[index]['namepets'],
                                typebreed: petsdata2[index]['typebreed'],
                                detailspets: petsdata2[index]['detailspets'],
                                username: petsdata2[index]['username'],
                                create_at: petsdata2[index]['create_at'],
                                category_pets: petsdata2[index]
                                    ['category_pets'],
                                genderpets: petsdata2[index]['genderpets'],
                                sterillzationpets: petsdata2[index]
                                    ['sterillzationpets'],
                                vaccinepets: petsdata2[index]['vaccinepets'],
                                bodysize: petsdata2[index]['bodysize'],
                                lat: petsdata2[index]['lat'],
                                lone: petsdata2[index]['lone'],
                                status: petsdata2[index]['statuspets'],
                              );
                            }),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: recentData.length,
                          itemBuilder: (context, index) {
                            return RecentItem(
                              id: recentData[index]['id'],
                              post_id: recentData[index]['post_id'],
                              comments: recentData[index]['comments'],
                              author_post: recentData[index]['author_post'],
                              body_post: recentData[index]['body_post'],
                              category_name: recentData[index]['category_name'],
                              comments_post: recentData[index]['comments_post'],
                              pathImage:
                                  '${MyConstant().domain}/homestay/Users/${recentData[index]['pathImage']}',
                              image_post:
                                  '${MyConstant().domain}/homestay/Post/${recentData[index]['image_post']}',
                              post_date: recentData[index]['post_date'],
                              total_Like: recentData[index]['total_Like'],
                              create_date: recentData[index]['create_date'],
                              title_post: recentData[index]['title_post'],
                              // title_post: recentData[index]['title_post'],
                              // author_post: recentData[index]['author_post'],
                              // create_date: recentData[index]['create_date'],
                              // body_post: recentData[index]['body_post'],
                              // image_post:
                              //     '${MyConstant().domain}/homestay/Post/${recentData[index]['image_post']}',
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // addButton()
            ],
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

class Getuser extends StatefulWidget {
  final username;
  final email;
  final pathImage;

  const Getuser({Key key, this.username, this.email, this.pathImage})
      : super(key: key);
  @override
  _GetuserState createState() => _GetuserState();
}

class _GetuserState extends State<Getuser> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/pexels-zen-chung-5745275.jpg'),
              ),
              Positioned(
                top: 180,
                // bottom: BorderRadius.all(10),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.pathImage),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(90),
          ),
          Text(
            widget.username,
            style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w600),
          ),
          Text(widget.email)
          // SizedBox(het)
        ],
      ),
    );
  }
}

class GridViewP extends StatefulWidget {
  final id;
  final id_pets;
  final namepets;
  final typebreed;
  final detailspets;
  final pathimage;
  final category_pets;
  final genderpets;
  final pathImage;
  final username;
  final pathimagepets;
  final create_at;
  final update_at;
  final sterillzationpets;
  final vaccinepets;
  final index;
  final bodysize;
  final lat;
  final lone;
  final status;

  const GridViewP(
      {Key key,
      this.namepets,
      this.typebreed,
      this.detailspets,
      this.pathimage,
      this.id,
      this.id_pets,
      this.category_pets,
      this.genderpets,
      this.pathImage,
      this.username,
      this.create_at,
      this.update_at,
      this.sterillzationpets,
      this.vaccinepets,
      this.bodysize,
      this.lat,
      this.lone,
      this.status,
      this.pathimagepets,
      this.index})
      : super(key: key);
  @override
  _GridViewPState createState() => _GridViewPState();
}

class _GridViewPState extends State<GridViewP> {
  List petsdata2 = List();

  Future showAllpost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    var url = '${MyConstant().domain}/homestay/getpetsid.php?id=$id';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata2 = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.pathimagepets,
              height: 178.0,
              width: 140.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 7.0),
          Text(
            widget.namepets,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
            // maxLines: 2,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 3.0),
          Text(
            widget.typebreed,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: Colors.blueGrey[300],
            ),
            maxLines: 1,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 3.0),
        ],
      ),
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String phone = preferences.getString('phone');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetsDetails(
              id: widget.id,
              pathImage: widget.pathImage,
              username: widget.username,
              create_at: widget.create_at,
              update_at: widget.update_at,
              pathimage: widget.pathimage,
              namepets: widget.namepets,
              phone: phone,
              pathimagepets: widget.pathimagepets,
              detailspets: widget.detailspets,
              category_pets: widget.category_pets,
              genderpets: widget.genderpets,
              sterillzationpets: widget.sterillzationpets,
              vaccinepets: widget.vaccinepets,
              bodysize: widget.bodysize,
              typebreed: widget.typebreed,
              lat: widget.lat,
              lone: widget.lone,
              status: widget.status,
            ),
          ),
        );
      },
    );
  }
}

class RecentItem extends StatefulWidget {
  final id;
  final post_id;
  final user_email;
  final image_post;
  final author_post;
  final post_date;
  final comments_post;
  final total_Like;
  final comments;
  final title_post;
  final pathImage;
  final category_name;
  final create_date;
  final body_post;

  const RecentItem(
      {Key key,
      this.id,
      this.post_id,
      this.comments,
      this.user_email,
      this.image_post,
      this.author_post,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.pathImage})
      : super(key: key);

  @override
  _RecentItemState createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String username = preferences.getString('username');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(
              id: widget.id,
              // pathImage : widget.pathImage,
              post_id: widget.post_id,
              user_email: username,
              pathImage: widget.pathImage,
              comments: widget.comments,
              title_post: widget.title_post,
              image_post: widget.image_post,
              total_Like: widget.total_Like,
              author_post: widget.author_post,
              body_post: widget.body_post,
              create_date: widget.create_date,
              post_date: widget.post_date,
            ),
          ),
        );
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
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(widget.pathImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 100,
                          child: Column(
                            children: <Widget>[
                              // SizedBox(
                              //   height: getProportionateScreenHeight(2),
                              // ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.author_post,
                                  style: TextStyle(color: Colors.black),
                                  maxLines: 2,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.create_date,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.title_post,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                padding: EdgeInsets.all(5),
                child: Image.network(
                  widget.image_post,
                  width: 80,
                  height: 80,
                ),
                // width: 100,
                // height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
