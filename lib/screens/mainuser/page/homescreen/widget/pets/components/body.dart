import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:final_project/model/Pets.dart';
import 'package:final_project/model/coffee_model.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/addhomelessScreen/addhomelessScreen.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/addhomelessScreen/components/test.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/CategoryListitem.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/cardpets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/gridViewpets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/petsdetails.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../../constants.dart';
import '../../../../../../../my_constant.dart';

class PetsScreen extends StatefulWidget {
  final id;
  final id_pets;
  final index;
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
  final lone;
  final status;

  const PetsScreen(
      {Key key,
      this.id,
      this.id_pets,
      this.namepets,
      this.typebreed,
      this.detailspets,
      this.pathimage,
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
      this.index})
      : super(key: key);

  // final PetsModel petsModels;

  // const Body({Key key, this.petsModels}) : super(key: key);
  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  double lat1, lng1, lat2, lng2, distance;
  List petsdata = List();
  // int index;
  Location location = Location();
  CameraPosition position;
  List<PetsModels> petsModels = List();

  Future showAllpets() async {
    var url = '${MyConstant().domain}/homestay/getpetsall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata = jsonData;
      });
      print(petsdata);
    }
  }

  // List<PetsModels> petsmodels = List();
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  // LatLng latLng = LatLng(lat., lng);

  PageController _pageController;
  int prevPage;

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
    // showAllpets();
    searchPets();
    showAllpets();
    findLat1Lng1();
    _fabHeight = _initFabHeight;
    petsp.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.petsName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.petsName, snippet: element.description),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse('${petsdata[widget.index]['lat']}');
      print('lat1 = $lat1, lng1 = $lng1 lat1,lat2 = $lat2 ');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  List searchList = [];

  Future searchPets() async {
    var url = '${MyConstant().domain}/homestay/getpetsall.php';
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        searchList.add(jsonData[i]['genderpets']);
        searchList.add(jsonData[i]['category_pets']);
      }
      print(jsonData);
    }
  }

  Set<Marker> myMarker(index) {
    return <Marker>[
      Marker(
          markerId: MarkerId(petsdata[index]['namepets']),
          position: LatLng(petsdata[index]['lat'], petsdata[index]['lone']),
          infoWindow: InfoWindow(
            title: petsdata[index]['namepets'],
            // snippet: 'ละติจูต $lat, ลองติจูต $lng',
          )),
    ].toSet();
  }
  // Future<Null> findLatLng() async {
  //   LocationData locationData = await findLocationData();
  //   setState(() {
  //     lat = locationData.latitude;
  //     lng = locationData.longitude;
  //   });
  //   print('lat = $lat lng = $lng');
  // }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String phone = preferences.getString('phone');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetsDetails(
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
                  category_pets: petsdata[index]['category_pets'],
                  genderpets: petsdata[index]['genderpets'],
                  sterillzationpets: petsdata[index]['sterillzationpets'],
                  vaccinepets: petsdata[index]['vaccinepets'],
                  bodysize: petsdata[index]['bodysize'],
                  lat: petsdata[index]['lat'],
                  phone: phone,
                  lone: petsdata[index]['lone'],
                  status: petsdata[index]['statuspets'],
                ),
              ),
            );
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        '${MyConstant().domain}/homestay/Pets/${petsdata[index]['pathimagepets']}',
                                        // petsdata[index]['pathimage']
                                        // coffeeShops[index].thumbNail
                                      ),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ชื่อ : " + petsdata[index]['namepets'],
                                  // coffeeShops[index].petsName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "สถานะ : " + petsdata[index]['statuspets'],
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    'เพศ : ' + petsdata[index]['genderpets'],
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: petsp[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .89;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),

          // the fab
          // Positioned(
          //   right: 20.0,
          //   bottom: _fabHeight,
          //   child: FloatingActionButton(
          //     child: Icon(
          //       Icons.gps_fixed,
          //       color: Theme.of(context).primaryColor,
          //     ),
          //     onPressed: () {},
          //     backgroundColor: Colors.white,
          //   ),
          // ),

          Positioned(
              bottom: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),

          Positioned(
            top: 75,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(top: 40.0, child: Text('ตำแหน่งของสัตว์เลี้ยง')),
          //the SlidingUpPanel Title
          Positioned(
            top: 52.0,
            child: Container(
              width: 300,
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Container(
                height: 36.0,
                width: double.infinity,
                child: CupertinoTextField(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: SearchPost(list: searchList));
                  },
                  keyboardType: TextInputType.text,
                  placeholder: "ค้นหา",
                  placeholderStyle: TextStyle(
                    color: Color(0xffC4C6CC),
                    fontSize: 14.0,
                    fontFamily: 'Brutal',
                  ),
                ),
              ),
            ),
          ),
          addButton()
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "หาบ้านให้น้อง",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 36.0,
            // ),
            // Divider(),

            CategoryListItem(),

            // Divider(),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[GridViewPets()],
              ),
            ),
            SizedBox(
              height: 36.0,
            ),
          ],
        ));
  }

  Widget _panels(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "สัตว์ต่างๆ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 36.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _button("Popular", Icons.favorite, Colors.blue),
              _button("Food", Icons.restaurant, Colors.red),
              _button("Events", Icons.event, Colors.amber),
              _button("More", Icons.more_horiz, Colors.green),
            ],
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 12.0,
                ),
                GridViewPets()
              ],
            ),
          ),
          // SizedBox(
          //   height: 36.0,
          // ),
          // SizedBox(
          //   height: 24.0,
          // ),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
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
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    String id = preferences.getString('id');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Upload(
                          id_user: id,
                        ),
                      ),
                    );
                    //   .whenComplete(() {
                    //     getAllPost();
                    //   });
                    // },
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(16.4322, 102.8236), zoom: 12.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        Positioned(
          bottom: 70.0,
          child: Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: petsdata.length,
              itemBuilder: (BuildContext context, int index) {
                return _coffeeShopList(index);
              },
            ),
          ),
        )
      ],
    );
  }
}

class SearchPost extends SearchDelegate<String> {
  List<dynamic> list;
  SearchPost({this.list});
  String q;
  List<PetsModels> petsmodels;
  List searchTitle = List();
  Future showAllpost() async {
    var url =
        '${MyConstant().domain}/homestay/searchPets.php?category_pets=หมา&genderpets=ตัวผู้&statuspets=ยังไม่มีผู้รับเลี้ยง';
    var response = await http.post(url, body: {
      "category_pets": query,
      // "genderpets": query,
    });
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
                            '${MyConstant().domain}/homestay/Pets/${list['pathimagepets']}',
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
                              '${list['namepets']}' == null
                                  ? ""
                                  : '${list['namepets']}',
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
                                '${list['username']}',
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
                              child: Text(
                                  'โพสต์เมื่อ : ' + '${list['create_at']}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16)),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '${list['detailspets']}' == null
                                  ? ""
                                  : '${list['detailspets']}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
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
