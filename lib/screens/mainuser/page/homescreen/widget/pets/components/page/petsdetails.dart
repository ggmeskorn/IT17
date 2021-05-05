import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/components/form_error.dart';
import 'package:final_project/constants.dart';
import 'package:final_project/firebaseserver/helper/constants.dart';
import 'package:final_project/firebaseserver/helper/helperfunctions.dart';
import 'package:final_project/firebaseserver/helper/theme.dart';
import 'package:final_project/model/Pets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/cardpets.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/requestscreen.dart';
import 'package:final_project/screens/mainuser/page/notificationscreen/components/chat.dart';
import 'package:final_project/screens/mainuser/page/notificationscreen/components/conversation.dart';
import 'package:final_project/screens/mainuser/page/notificationscreen/notification_screen.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/size_config.dart';
import 'package:final_project/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../../constants.dart';
import '../../../../../../../../my_constant.dart';

String commentsText;
final _formKey = GlobalKey<FormState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
TextEditingController commentsController = TextEditingController();

class PetsDetails extends StatefulWidget {
  final id;
  final id_pets;
  final email;
  final pathimage;
  final namepets;
  final pathimagepets;
  final detailspets;
  final category_pets;
  final pathImage;
  final username;
  final create_at;
  final phone;
  final update_at;
  final genderpets;
  final sterillzationpets;
  final vaccinepets;
  final bodysize;
  final typebreed;
  final lat;
  final lone;
  final status;

  const PetsDetails(
      {Key key,
      this.id,
      this.pathimage,
      this.namepets,
      this.detailspets,
      this.category_pets,
      this.genderpets,
      this.sterillzationpets,
      this.vaccinepets,
      this.bodysize,
      this.typebreed,
      this.lat,
      this.lone,
      this.status,
      this.pathImage,
      this.username,
      this.create_at,
      this.update_at,
      this.id_pets,
      this.phone,
      this.email,
      this.pathimagepets})
      : super(key: key);

  @override
  _PetsDetailsState createState() => _PetsDetailsState();
}

class _PetsDetailsState extends State<PetsDetails> {
  double lat1, lng1, lat2, lng2, distance;
  Location location = Location();
  CameraPosition position;

  List getimagepets = List();
  final List<String> errors = [];
  Future getDateImage() async {
    var url = '${MyConstant().domain}/homestay/selectimagepets.php';
    var response = await http.post(url, body: {'id_pets': widget.id});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        getimagepets = jsonData;
      });
      print(jsonData);
    }
  }

  // Future addComments() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String username = preferences.getString('username');
  //   var url = '${MyConstant().domain}/homestay/addcomments.php';
  //   var res = await http.post(url, body: {
  //     'comments': commentsController.text,
  //     'user_email': username,
  //     'post_id': widget.id,
  //     'author_post': widget.author_post
  //   });
  //   if (res.statusCode == 200) {
  //     showNotification();
  //     Fluttertoast.showToast(msg: 'เพิ่มสำเร็จ');
  //     clearText();
  //     // Navigator.pop(context);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDateImage();
    getUserInfogetChats();
    // commentsByDate();
    findLat1Lng1();
  }

  Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse('${widget.lat}');
      lng2 = double.parse('${widget.lone}');
      print('lat1 = $lat1, lng1 = $lng1,lat2 = $lat2, lng2 = $lng2');
      distance = calculateDistance(lat1, lng1, lat2, lng2);
      print('distance = $distance');
    });
  }

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void clearText() {
    commentsController.clear();
  }

  Future updateNotification(String id) async {
    var url = "${MyConstant().domain}/homestay/statuspets.php";
    var res = await http.post(url, body: {"id": id});
    if (res.statusCode == 200) {
      print('od');
    }
    updatestatus(widget.id);
  }

  Future updatestatus(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String ids = preferences.getString('id');
    var url = "${MyConstant().domain}/homestay/statususer.php?id_adopt=$ids";
    var res = await http.post(url, body: {"id": id});
    if (res.statusCode == 200) {
      print('od');
    }
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  Stream chatRooms;

  @override
  Widget build(BuildContext context) {
    bool statuspets = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.namepets}'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          buildSlider()
        ],
      ),
      bottomNavigationBar:
          //  StreamBuilder(
          //   stream: chatRooms,
          //   builder: (context, snapshot) {
          //     return snapshot.hasData
          //         ? ListView.builder(
          //             itemCount: snapshot.data.documents.length,
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               return BottomBar(
          //                 userName: snapshot
          //                     .data.documents[index].data['chatRoomId']
          //                     .toString()
          //                     .replaceAll("_", "")
          //                     .replaceAll(Constants.myName, ""),
          //                 chatRoomId:
          //                     snapshot.data.documents[index].data["chatRoomId"],
          //               );
          //             })
          //         : Container();
          //   },
          // ),
          BottomBar(
        username: '${widget.username}',
        email: '${widget.email}',
        create_at: '${widget.create_at}',
        pathImage: '${widget.pathImage}',
        pathimage: '${widget.pathimage}',
        namepets: '${widget.namepets}',
        id_pets: '${widget.id_pets}',
        id: '${widget.id}',
        status: '${widget.status}',
      ),
    );
  }

  buildSlider() {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 20),
                height: 250.0,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.pathimagepets,
                      height: 150.0,
                      width: MediaQuery.of(context).size.width - 40.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                // ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   primary: false,
                //   itemCount: getimagepets == null ? 0 : getimagepets.length,
                //   // itemCount: places == null ? 0 : places.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return PetsImage(
                //       pathimage:
                //           '${MyConstant().domain}/homestay/Pets/${getimagepets[index]['pathimage']}',
                //     );
                //   },
                // ),
                ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Divider(),
            Stack(
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeaturesTileImage(
                          image: Image.asset(
                            'assets/images/pet.png',
                            height: 30,
                            width: 30,
                          ),
                          label: widget.typebreed,
                        ),
                        FeaturesTileImage(
                          image: Image.asset(
                            'assets/images/man.png',
                            height: 30,
                            width: 30,
                          ),
                          label: widget.genderpets,
                        ),
                        InkWell(
                          onTap: () {
                            updateNotification(widget.id);
                          },
                          child: FeaturesTileImage(
                            image: Image.asset(
                              'assets/images/pets.png',
                              height: 30,
                              width: 30,
                            ),
                            label: widget.status,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeaturesTileImage(
                          image: Image.asset(
                            'assets/images/meter.png',
                            height: 30,
                            width: 30,
                          ),
                          label: widget.bodysize,
                        ),
                        FeaturesTileImage(
                          image: Image.asset(
                            'assets/images/syringe.png',
                            height: 30,
                            width: 30,
                          ),
                          label: widget.vaccinepets,
                        ),
                        FeaturesTileImage(
                          image: Image.asset(
                            'assets/images/sterilization.png',
                            height: 30,
                            width: 30,
                          ),
                          label: widget.sterillzationpets,
                        ),
                      ],
                    ),
                    Divider(),
                    TabBarContainer(
                      widget: widget,
                    ),
                    Divider(),
                    showMap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeaturesTile(
                          icon:
                              Icon(Icons.my_location, color: Color(0xff5A6C64)),
                          label: 'ดูเส้นทาง',
                        ),
                        FeaturesTile(
                          icon: Icon(Icons.phone, color: Color(0xff5A6C64)),
                          label: "โทร",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    ListTile(
                      leading: Text('เบอร์   ' + widget.phone),
                      trailing: Icon(Icons.phone),
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'สัตว์เลี้ยงตัวอื่น',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: getProportionateScreenWidth(18)),
                        ),
                      ),
                    ),
                    CardPets()
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng2);
      position = CameraPosition(
        target: latLng1,
        zoom: 16.0,
      );
    }
    Marker userMarker() {
      return Marker(
          markerId: MarkerId('userMarker'),
          position: LatLng(lat1, lng1),
          icon: BitmapDescriptor.defaultMarkerWithHue(60.00),
          infoWindow: InfoWindow(title: 'ตำแหน่งของฉัน'));
    }

    Marker petsMarker() {
      return Marker(
        markerId: MarkerId('userMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.00),
        infoWindow: InfoWindow(title: widget.namepets),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), petsMarker()].toSet();
    }

    return Container(
      height: 200.0,
      // width: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: lat1 == null
            ? showProgress()
            : GoogleMap(
                initialCameraPosition: position,
                mapType: MapType.normal,
                onMapCreated: (controller) {},
                markers: mySet(),
              ),
      ),
    );
  }
}

class PetsImage extends StatefulWidget {
  final id;
  final pathimage;

  const PetsImage({Key key, this.id, this.pathimage}) : super(key: key);

  @override
  _PetsImageState createState() => _PetsImageState();
}

class _PetsImageState extends State<PetsImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          widget.pathimage,
          height: 150.0,
          width: MediaQuery.of(context).size.width - 40.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FeaturesTile extends StatelessWidget {
  final Icon icon;
  final String label;
  FeaturesTile({this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff5A6C64).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(40)),
              child: icon,
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                width: 70,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A6C64)),
                ))
          ],
        ),
      ),
    );
  }
}

class FeaturesTileImage extends StatelessWidget {
  final Image image;
  final String label;

  const FeaturesTileImage({Key key, this.image, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff5A6C64).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(40)),
              child: image,
            ),
            SizedBox(
              height: 9,
            ),
            Container(
                width: 70,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A6C64)),
                ))
          ],
        ),
      ),
    );
  }
}

class TabBarContainer extends StatefulWidget {
  final PetsDetails widget;

  const TabBarContainer({Key key, this.widget}) : super(key: key);
  @override
  _TabBarContainerState createState() => _TabBarContainerState();
}

class _TabBarContainerState extends State<TabBarContainer> {
  TextEditingController commentsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final fieldText = TextEditingController();

  String commentsText;

  TextFormField buildNamePetsFormField() {
    return TextFormField(
      controller: commentsController,
      onSaved: (newValue) => commentsText = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kcommentsNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: commentsNullError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.left,
      decoration: InputDecoration.collapsed(hintText: "ข้อความ"),
    );
  }

  Future addComments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    var url = '${MyConstant().domain}/homestay/addcompets.php';
    var res = await http.post(url, body: {
      'comments': commentsController.text,
      'user_email': username,
      'pets_id': widget.widget.id,
      'author_pets': widget.widget.username
    });
    if (res.statusCode == 200) {
      showNotification();
      Fluttertoast.showToast(msg: 'เพิ่มสำเร็จ');
      clearText();
      // Navigator.pop(context);
    }
  }

  List commentsByPosts = List();
  Future commentsByDate() async {
    var url = '${MyConstant().domain}/homestay/commentspets.php';
    var response = await http.post(url, body: {'pets_id': widget.widget.id});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        commentsByPosts = jsonData;
      });
      print(jsonData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentsByDate();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher'); //logo
    var ios = IOSInitializationSettings();
    var initilize = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initilize,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      debugPrint("Notification : " + payload);
    }
  }

  Future showNotification() async {
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(
        0,
        'HOMESTAY เพื่อช่วยให้มีชีวิตที่ดีขึ้น',
        commentsController.text,
        platform,
        payload: 'some details value');
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void clearText() {
    commentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    TabBar(
                      labelPadding: EdgeInsets.all(10),
                      indicatorColor: Colors.yellow.shade700,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.black38,
                      tabs: <Widget>[
                        Text("รายละเอียด"),
                        Text("ความคิดเห็น"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        child: Text(
                          widget.widget.detailspets,
                          // widget.bookObject.summary,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildNamePetsFormField(),
                              // child: TextField(
                              //   controller: commentsController,
                              //   decoration: InputDecoration(labelText: 'Enter Comments'),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 600,
                                child: MaterialButton(
                                  color: kPrimaryColor,
                                  child: Text(
                                    'ส่งข้อความ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      if (commentsText == null ||
                                          commentsText.isEmpty) {
                                      } else {
                                        addComments().whenComplete(
                                            () => commentsByDate());
                                      }
                                    }

                                    // addComments();
                                  },
                                ),
                              ),
                            ),
                            FormError(errors: errors),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ความคิดเห็น ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Muli'),
                      ),
                    ),
                    BuildNewSection()
                  ],
                ),

                // child: Text("NO REVIEWS",
                //     style: TextStyle(
                //         fontWeight: FontWeight.w700,
                //         fontSize: 25,
                //         color: Colors.black54)),
              )
            ],
          ),
        ),
      ),
    );
  }

  BuildNewSection() {
    return ListView.builder(
      itemCount: commentsByPosts.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Commentsby(
          user_email: commentsByPosts[index]['user_email'],
          comments: commentsByPosts[index]['comments'],
          comments_date: commentsByPosts[index]['comments_date'],
        );
      },
    );
  }
}

// class TabBarContainer extends StatelessWidget {

// const TabBarContainer({
//   @required this.widget,
// });

class BottomBar extends StatefulWidget {
  final username;
  final create_at;
  final id;
  final email;
  final String chatRoomId;

  final pathImage;
  final namepets;
  final status;
  final pathimage;
  final id_pets;

  const BottomBar(
      {Key key,
      this.username,
      this.create_at,
      this.pathImage,
      this.namepets,
      this.pathimage,
      this.id_pets,
      this.id,
      this.email,
      this.status,
      this.chatRoomId})
      : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Stream chatRooms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
              color: Colors.black12,
              width: 2,
            ))),
        child: Row(
          children: <Widget>[
            Container(
              height: 60,
              child: Padding(
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
                                widget.username,
                                style: TextStyle(color: Colors.black),
                                maxLines: 2,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${widget.create_at}',
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
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
            ),
            AddButton(
              status: widget.status,
              pathimage: widget.pathimage,
              namepets: widget.namepets,
              id_pets: widget.id_pets,
              id: widget.id,
              email: widget.email,
              pathImage: widget.pathImage,
              username: widget.username,
            )
          ],
        ),
      ),
    );
  }
}

// class AddButton extends StatefulWidget {
//   // final pathimage;
//   // final pathImage;
//   // final email;
//   // final status;
//   // final String userName;
//   // final String userEmail;

//   // final create_at;
//   // final id_pets;
//   // final statuspets;
//   // final namepets;
//   // final id;
//   // final username;
//   // const AddButton(
//   //     {Key key,
//   //     this.pathimage,
//   //     this.create_at,
//   //     this.namepets,
//   //     this.id_pets,
//   //     this.id,
//   //     this.username,
//   //     this.pathImage,
//   //     this.email,
//   //     this.statuspets,
//   //     this.status,
//   //     this.userName,
//   //     this.userEmail})
//   //     : super(key: key);
//   @override
//   _AddButtonState createState() => _AddButtonState();
// }

// class _AddButtonState extends State<AddButton> {
//   TextEditingController searchEditingController = new TextEditingController();
//   bool isLoading = false;
//   DatabaseMethods databaseMethods = new DatabaseMethods();

//   initiateSearch() async {
//     if (searchEditingController.text.isNotEmpty) {
//       setState(() {
//         isLoading = true;
//       });
//       await databaseMethods
//           .searchByName(searchEditingController.text)
//           .then((snapshot) {
//         searchResultSnapshot = snapshot;
//         print("$searchResultSnapshot");
//         setState(() {
//           isLoading = false;
//           haveUserSearched = true;
//         });
//       });
//     }
//   }

//   QuerySnapshot searchResultSnapshot;
//   bool haveUserSearched = false;

//   sendMessage(String userName) {
//     // DatabaseMethods databaseMethods = new DatabaseMethods();

//     List<String> users = [Constants.myName, userName];

//     String chatRoomId = getChatRoomId(Constants.myName, userName);

//     Map<String, dynamic> chatRoom = {
//       "users": users,
//       "chatRoomId": chatRoomId,
//     };

//     databaseMethods.addChatRoom(chatRoom, chatRoomId);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => Chat(
//                   chatRoomId: chatRoomId,
//                 )));
//   }

//   getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }

//   Widget userList() {
//     return haveUserSearched
//         ? ListView.builder(
//             shrinkWrap: true,
//             itemCount: searchResultSnapshot.documents.length,
//             itemBuilder: (context, index) {
//               return userTile(
//                 searchResultSnapshot.documents[index].data["userName"],
//                 searchResultSnapshot.documents[index].data["userEmail"],
//               );
//             })
//         : Container();
//   }

//   Widget userTile(String userName, String userEmail) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName,
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               Text(
//                 userEmail,
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               )
//             ],
//           ),
//           Spacer(),
//           GestureDetector(
//             onTap: () {
//               sendMessage(userName);
//             },
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                   color: Colors.blue, borderRadius: BorderRadius.circular(24)),
//               child: Text(
//                 "",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   String _buttonText = "สนใจติดต่อ";
//   String userName;
//   String userEmail;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 10),
//       child: RaisedButton(
//         padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
//         elevation: 1.0,
//         onPressed: () async {
//           // sendMessage(userName);
//         },
//         child: Row(
//           children: <Widget>[
//             Icon(Icons.chat_outlined, color: Colors.white, size: 20),
//             SizedBox(
//               width: 5,
//             ),
//             Text(
//               _buttonText,
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//         color: kPrimaryColor,
//       ),
//     );
//   }
// }

class AddButton extends StatefulWidget {
  final pathimage;
  final pathImage;
  final email;
  final status;
  final String userName;
  final String userEmail;
  final create_at;
  final id_pets;
  final statuspets;
  final namepets;
  final id;
  final username;
  const AddButton(
      {Key key,
      this.pathimage,
      this.create_at,
      this.namepets,
      this.id_pets,
      this.id,
      this.username,
      this.pathImage,
      this.email,
      this.statuspets,
      this.status,
      this.userName,
      this.userEmail})
      : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  String _buttonText = "สนใจติดต่อ";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
        elevation: 1.0,
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NotificationScreen()));

          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // String email = preferences.getString('email');
          // // SharedPreferences preference = await SharedPreferences.getInstance();
          // // String unique_id = preference.getString('unique_id');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Conversation(
          //       statuspets: widget.status,
          //       pathimage: widget.pathimage,
          //       namepets: widget.namepets,
          //       id_pets: widget.id_pets,
          //       // outgoing_msg_id: unique_id,
          //       id: widget.id,
          //       email: email,
          //       pathImage: widget.pathImage,
          //       username: widget.username,
          //     ),
          //   ),
          // );
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.chat_outlined, color: Colors.white, size: 20),
            SizedBox(
              width: 5,
            ),
            Text(
              _buttonText,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        color: kPrimaryColor,
      ),
    );
  }
}

class Commentsby extends StatefulWidget {
  final comments;
  final user_email;
  final comments_date;

  const Commentsby(
      {Key key, this.comments, this.user_email, this.comments_date})
      : super(key: key);
  @override
  _CommentsbyState createState() => _CommentsbyState();
}

class _CommentsbyState extends State<Commentsby> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment(-1.0, 0.0),
                  child: Text(
                    " " + widget.user_email,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment(-1.0, 0.0),
                  child: Text(
                    "เมื่อ : " + widget.comments_date,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 1.0, bottom: 20.0),
            child: Align(
              alignment: Alignment(-1.0, 0.0),
              child: Text(
                widget.comments,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
