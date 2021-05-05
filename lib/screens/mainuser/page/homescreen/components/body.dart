import 'dart:convert';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:final_project/constants.dart';
import 'package:final_project/data/data.dart';
import 'package:final_project/model/book_model.dart';
import 'package:final_project/model/category.dart';
import 'package:final_project/screens/mainuser/page/homescreen/components/popular_petscat.dart';
import 'package:final_project/screens/mainuser/page/homescreen/components/popular_petsdog.dart';
import 'package:final_project/screens/mainuser/page/homescreen/components/section_title.dart';
import 'package:final_project/screens/mainuser/page/homescreen/components/section_title_box.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/blog.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/blog/page/postDetails.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/news/news.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/body.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/cardpets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/petsdetails.dart';
// import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/pets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../my_constant.dart';
import '../../../../../size_config.dart';

class Body extends StatefulWidget {
  final lat;
  final lone;

  const Body({Key key, this.lat, this.lone}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  double extraPicHeight;
  double extraBtmHeight;
  ScrollPhysics _physics;
  double prevDy;

  bool callNow;

  AnimationController animationController;
  Animation<double> animate;

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    showAllpost();
    showAllpets();
    extraPicHeight = 0.0;
    extraBtmHeight = 0.0;
    prevDy = 0.0;
    callNow = true;
    _physics = AlwaysScrollableScrollPhysics();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animate = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  void updatePicHeight(changed) {
    extraPicHeight = changed / 3;

    setState(() {
      extraPicHeight = extraPicHeight;
    });
  }

  void runAnimate() {
    setState(() {
      animate =
          Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
            ..addListener(() {
              setState(() {
                extraPicHeight = animate.value;
              });
            });
      // prevDy = 0.0;
      extraPicHeight = 0.0;
    });
  }

  // 节流
  void debounce(Function fn) {
    if (callNow) {
      fn();
      callNow = false;
    }
  }

  List petsdata = List();

  Future showAllpets() async {
    var url = '${MyConstant().domain}/homestay/getpetsall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata = jsonData;
      });
      print(jsonData);
    }
  }

  List searchList = [];

  void routetoBlogInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => BlogScreen(),
    );
    Navigator.push(context, materialPageRoute);
  }

  void routetoNewsInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => News(),
    );
    Navigator.push(context, materialPageRoute);
  }

  void routetoPetsInfo() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => PetsScreen(
          // lat:petsdata[index][],
          ),
    );
    Navigator.push(context, materialPageRoute);
  }

  List postdata = List();

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/postall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        postdata = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Listener(
          onPointerMove: (event) {
            var position = event.position.dy;
            var detal = position - prevDy;

            if (detal > 0) {
              debounce(() {
                setState(() {
                  _physics = ClampingScrollPhysics();
                });
              });
              var result = _scrollController.offset;
              if (result <= 0) {
                updatePicHeight(detal);
              }
            } else {}
          },
          onPointerUp: (_) {
            runAnimate();
            animationController.forward(from: 0.0);

            if (_scrollController.offset <= 0) {
              callNow = true;
              setState(() {
                _physics = AlwaysScrollableScrollPhysics();
              });
            }
          },
          onPointerDown: (event) {
            prevDy = event.position.dy;
            callNow = true;
            setState(() {
              _physics = AlwaysScrollableScrollPhysics();
            });
          },
          child: PrimaryScrollController(
            controller: _scrollController,
            child: CupertinoScrollbar(
              controller: _scrollController,
              child: CustomScrollView(
                physics: _physics,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverCustomHeaderDelegate(
                        title: 'HomeStay',
                        collapsedHeight: 40,
                        expandedHeight: 300 + extraPicHeight,
                        paddingTop: MediaQuery.of(context).padding.top,
                        coverImgUrl: 'assets/images/friendly.jpg'),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Center(
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          routetoPetsInfo();
                                        },
                                        child: SizedBox(
                                          width:
                                              getProportionateScreenWidth(55),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/ttt.png',
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(height: 5),
                                              Text("หาบ้านให้น้อง",
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          routetoBlogInfo();
                                        },
                                        child: SizedBox(
                                          width:
                                              getProportionateScreenWidth(55),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/blogp.png',
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(height: 5),
                                              Text("กระทู้",
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          routetoNewsInfo();
                                        },
                                        child: SizedBox(
                                          width:
                                              getProportionateScreenWidth(55),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/newsho.png',
                                                fit: BoxFit.contain,
                                              ),
                                              SizedBox(height: 5),
                                              Text("ข่าวสาร",
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(10)),
                        // SpecialOffers(),
                        // BodyLists(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "กระทู้ยอดนิยม",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: SectionTitleBox(press: () {
                                routetoBlogInfo();
                              }),
                            ),
                            // SectionTitleBox(press: () {}),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenWidth(10)),
                        BuildNewSection(),
                        SizedBox(height: getProportionateScreenWidth(30)),
                        new Divider(
                          color: Colors.grey[100],
                          height: 10,
                          thickness: 5,
                          indent: 0,
                          endIndent: 5,
                        ),
                        SizedBox(height: getProportionateScreenWidth(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "สัตว์เลี้ยงยอดนิยม",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: SectionTitleBox(press: () {
                                routetoPetsInfo();
                              }),
                            ),
                            // SectionTitleBox(press: () {}),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenWidth(10)),
                        Container(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0),
                          height: 250.0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: petsdata.length == 0 ? 0 : 4,
                              itemBuilder: (context, index) {
                                return CP(
                                  id: petsdata[index]['id'],
                                  pathImage:
                                      '${MyConstant().domain}/homestay/Users/${petsdata[index]['pathImage']}',
                                  pathimagepets:
                                      '${MyConstant().domain}/homestay/Pets/${petsdata[index]['pathimagepets']}',
                                  namepets: petsdata[index]['namepets'],
                                  typebreed: petsdata[index]['typebreed'],
                                  detailspets: petsdata[index]['detailspets'],
                                  username: petsdata[index]['username'],
                                  create_at: petsdata[index]['create_at'],
                                  category_pets: petsdata[index]
                                      ['category_pets'],
                                  genderpets: petsdata[index]['genderpets'],
                                  sterillzationpets: petsdata[index]
                                      ['sterillzationpets'],
                                  vaccinepets: petsdata[index]['vaccinepets'],
                                  bodysize: petsdata[index]['bodysize'],
                                  lat: petsdata[index]['lat'],
                                  lone: petsdata[index]['lone'],
                                  status: petsdata[index]['statuspets'],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(40)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BuildNewSection() {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      itemCount: postdata.length == 0 ? 0 : 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: Blog(
            id: postdata[index]['id'],
            pathImage:
                '${MyConstant().domain}/homestay/Users/${postdata[index]['pathImage']}',
            post_id: postdata[index]['post_id'],
            comments: postdata[index]['comments'],
            author_post: postdata[index]['author_post'],
            body_post: postdata[index]['body_post'],
            category_name: postdata[index]['category_name'],
            comments_post: postdata[index]['comments_post'],
            image_post:
                '${MyConstant().domain}/homestay/Post/${postdata[index]['image_post']}',
            post_date: postdata[index]['post_date'],
            total_Like: postdata[index]['total_Like'],
            create_date: postdata[index]['create_date'],
            title_post: postdata[index]['title_post'],
          ),
        );
      },
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final size = 60;

  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    if (shrinkOffset > 5) {
      return Colors.white;
    } else {
      return Colors.transparent;
    }
  }

  Color makeStickyHeaderTextColor(shrinkOffset) {
    if (shrinkOffset > 5) {
      return Color(0xFF000001);
    } else {
      return Colors.transparent;
    }
  }

  // List searchList = [];
  // Future showAllpsts() async {
  //   var url = '${MyConstant().domain}/homestay/getpetsall.php';
  //   var response = await http.get(url, headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     for (var i = 0; i < jsonData.length; i++) {
  //       searchList.add(jsonData[i]['genderpets']);
  //     }
  //     print(jsonData);
  //   }
  // }

  //   @override
  // // ignore: override_on_non_overriding_member
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // showAllpost();
  // }

  // double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
  // Widget buildSerach(double shrinkOffset, context) => Opacity(
  //       opacity: disappear(shrinkOffset),
  //       child: Column(
  //         children: <Widget>[
  //           SizedBox(height: 40.0),
  //           Padding(
  //             padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
  //             child: Container(
  //               height: 36.0,
  //               width: double.infinity,
  //               child: CupertinoTextField(
  //                 keyboardType: TextInputType.text,
  //                 placeholder: "ค้นหาในแอปฯ",
  //                 placeholderStyle: TextStyle(
  //                   color: Color(0xffC4C6CC),
  //                   fontSize: 14.0,
  //                   fontFamily: 'Brutal',
  //                 ),
  //                 prefix: Padding(
  //                   padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
  //                   child: Icon(
  //                     Icons.search,
  //                     color: Color(0xffC4C6CC),
  //                   ),
  //                 ),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   color: Color(0xffF0F1F5),
  //                 ),
  //                 onTap: () {
  //                   showSearch(
  //                       context: context,
  //                       delegate: SearchPost(list: searchList));
  //                 },
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Image.asset(
          'assets/images/friendly.jpg',
          fit: BoxFit.cover,
        ),
        // Positioned(
        //   top: expandedHeight - shrinkOffset - size / 0.90,
        //   left: 20,
        //   right: 20,
        //   child: buildSerach(shrinkOffset, context),
        // ),
        // ClipRect(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //     child: Container(
        //       // height: 200.0,
        //       color: Colors.white.withOpacity(0.3),
        //     ),
        //   ),
        // ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            color: this.makeStickyHeaderBgColor(shrinkOffset),
            child: SafeArea(
              bottom: false,
              child: Container(
                height: this.collapsedHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // InkWell(
                    //   child: Badge(
                    //     badgeContent: Text('3'),
                    //     child: Icon(Icons.notifications),
                    //   ),
                    // ),
                    IconButton(
                      icon: Icon(
                        Icons.autorenew,
                        color: this.makeStickyHeaderBgColor(shrinkOffset),
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      this.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: makeStickyHeaderTextColor(
                          shrinkOffset,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search,
                          color: makeStickyHeaderTextColor(
                            shrinkOffset,
                          )),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Blog extends StatefulWidget {
  final image_post;
  final author_post;
  final id;
  final post_id;
  final user_email;
  final comments;
  final pathImage;
  final post_date;
  final comments_post;
  final total_Like;
  final title_post;
  final category_name;
  final create_date;
  final body_post;

  const Blog(
      {Key key,
      this.image_post,
      this.author_post,
      this.post_date,
      this.comments_post,
      this.total_Like,
      this.title_post,
      this.category_name,
      this.create_date,
      this.body_post,
      this.id,
      this.post_id,
      this.user_email,
      this.comments,
      this.pathImage})
      : super(key: key);
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
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
                          radius: 20.0,
                          backgroundImage: NetworkImage(widget.pathImage),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 100,
                            child: Column(
                              children: <Widget>[
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
        ));
  }
}

class CP extends StatefulWidget {
  final id;
  final id_pets;
  final pathimagepets;
  final namepets;
  final typebreed;
  final detailspets;
  final pathimage;
  final category_pets;
  final genderpets;
  final pathImage;
  final username;
  final create_at;
  final update_at;
  final sterillzationpets;
  final vaccinepets;
  final bodysize;
  final lat;
  final lat1;
  final lng2;
  final lone;
  final status;

  const CP(
      {Key key,
      this.namepets,
      this.detailspets,
      this.pathimage,
      this.typebreed,
      this.id,
      this.id_pets,
      this.category_pets,
      this.genderpets,
      this.sterillzationpets,
      this.vaccinepets,
      this.bodysize,
      this.lat,
      this.lone,
      this.status,
      this.pathImage,
      this.username,
      this.create_at,
      this.update_at,
      this.lat1,
      this.lng2,
      this.pathimagepets})
      : super(key: key);

  @override
  _CPState createState() => _CPState();
}

class _CPState extends State<CP> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        child: Container(
          height: 250.0,
          width: 140.0,
          child: Column(
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
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.namepets,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.typebreed,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.blueGrey[300],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String phone = preferences.getString('phone');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetsDetails(
                id: widget.id,
                // lat1: widget.lat1,
                pathImage: widget.pathImage,
                username: widget.username,
                create_at: widget.create_at,
                pathimagepets: widget.pathimagepets,
                update_at: widget.update_at,
                pathimage: widget.pathimage,
                namepets: widget.namepets,
                detailspets: widget.detailspets,
                category_pets: widget.category_pets,
                genderpets: widget.genderpets,
                sterillzationpets: widget.sterillzationpets,
                vaccinepets: widget.vaccinepets,
                bodysize: widget.bodysize,
                typebreed: widget.typebreed,
                lat: widget.lat,
                phone: phone,
                lone: widget.lone,
                status: widget.status,
              ),
            ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return Details();
          //     },
          //   ),
          // );
        },
      ),
    );
  }
}

class SearchPost extends SearchDelegate<String> {
  List<dynamic> list;
  SearchPost({this.list});

  List searchTitle = List();

  Future showAllpost() async {
    var url = '${MyConstant().domain}/homestay/searchPets.php';
    var response = await http.post(url, body: {'genderpets': query});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: showAllpost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var list = snapshot.data[index];
                  return ListTile(
                    title: Column(
                      children: [
                        Container(
                          child: Image.network(
                            '${MyConstant().domain}/homestay/Post/${list['image_post']}',
                            height: 250,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              list['body_post'] == null
                                  ? ""
                                  : list['body_post'],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            // Text('  by'),
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            CircleAvatar(
                              radius: 15.0,
                              backgroundImage: NetworkImage(
                                '${MyConstant().domain}/homestay/Users/${list['pathImage']}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                list['author_post'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('โพสต์เมื่อ : ' + list['create_date'],
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                });
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list
            .where((element) => element.toLowerCase().contains(query))
            .toList();
    return listData.isEmpty
        ? Center(child: Text('ไม่มีข้อมูล'))
        : ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = listData[index];
                  showResults(context);
                },
                title: Text(
                  listData[index],
                ),
              );
            },
          );
  }
}
