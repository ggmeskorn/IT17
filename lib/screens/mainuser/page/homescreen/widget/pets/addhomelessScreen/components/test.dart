import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:final_project/components/form_error.dart';
import 'package:final_project/model/Pets.dart';
import 'package:final_project/model/imageuploadmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../../../../constants.dart';
import '../../../../../../../../my_constant.dart';
import '../../../../../../../../size_config.dart';

List<Map> _myjson_vaccine_pets = [
  {"id": '1', "name": 'ไม่ระบุ'},
  {
    "id": '2',
    "name": '6 เดือน',
  },
  {
    "id": '3',
    "name": '8 เดือน',
  },
  {"id": '4', "name": '12 เดือน'},
  {
    "id": '5',
    "name": '18 เดือน',
  },
];

List<Map> _myjson_sterillzation_pets = [
  {"id": '1', "name": 'ไม่ระบุ'},
  {"id": '2', "name": 'ทำหมันแล้ว'},
  {"id": '3', "name": 'ยังไม่ทำ'}
];

List<Map> _myjson_gender = [
  {"id": '1', "name": 'ไม่ระบุ'},
  {"id": '2', "name": 'ผู้'},
  {"id": '3', "name": 'เมีย'}
];
List<Map> _myjson_type_breed = [
  {"id": '1', "name": 'ไม่ระบุ'},
  {"id": '2', "name": 'โกลเด้น รีทรีฟเวอร์'},
  {"id": '3', "name": 'คอลลี่'},
  {"id": '4', "name": 'เคน คอร์โซ่'},
  {"id": '5', "name": 'เครนเทอร์เรีย'},
  {"id": '6', "name": 'ชเนาเซอร์'},
  {"id": '7', "name": 'ชิบะ อินุ'},
  {"id": '8', "name": 'เชดแลนด์ชิพด๊อก'},
  {"id": '9', "name": 'ชิสุ'},
  {"id": '10', "name": 'ชิวาวา'},
];

List<Map> _myjson_bodysize = [
  {"id": '1', "name": 'ไม่ระบุ'},
  {"id": '2', "name": 'เล็ก'},
  {"id": '3', "name": 'กลาง'},
  {"id": '4', "name": 'ใหญ่'},
];

class Upload extends StatefulWidget {
  final index;
  final petsList;
  final id_user;

  const Upload({
    Key key,
    this.index,
    this.petsList,
    this.id_user,
  }) : super(key: key);

  @override
  _UploadState createState() {
    return _UploadState();
  }
}

class _UploadState extends State<Upload> {
  Dio dio = Dio();
  double lat, lng;
  // List<Object> images = List<Object>();
  final _formKey = GlobalKey<FormState>();
  // List<PetsModel> petsModels = List();
  List<DropdownMenuItem<String>> _dropDownTypeBreedStates;
  List<DropdownMenuItem<String>> _dropDownBodySizeStates;
  List<DropdownMenuItem<String>> _dropDownGenderStates;
  List<DropdownMenuItem<String>> _dropDownSterillzationPetsStates;
  List<DropdownMenuItem<String>> _dropDownVaccinePetsStates;
  List<PetsModels> petsModels = List();

  // String namepets, detailpets, agepets, urlimage;
  final List<String> errors = [];
  List<Asset> images = [];
  String _error = 'No Error Dectected';
  String _selected_gender;
  String detailpetsText, namepetsText, urlimage;
  String _selected_type_breed;
  String selected_bodysize;
  String _selected_sterillzation_pets;
  String _selected_vaccine_pets;

  List categoryItem = List();
  String selectedCategorypets;
  TextEditingController namepets = TextEditingController();
  TextEditingController detailspets = TextEditingController();
  TextEditingController id_user = TextEditingController();
  bool editMode = false;
  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  File _image;
  final picker = ImagePicker();
  Future addEditpets() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id_user = preferences.getString('id');
    print('id_user = $id_user');
    var uri = Uri.parse("${MyConstant().domain}/homestay/addpetsll.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields['id_user'] = id_user;
    request.fields['namepets'] = namepets.text;
    request.fields['detailspets'] = detailspets.text;
    request.fields['genderpets'] = _selected_gender;
    request.fields['category_pets'] = selectedCategorypets;
    request.fields['sterillzationpets'] = _selected_sterillzation_pets;
    request.fields['vaccinepets'] = _selected_vaccine_pets;
    request.fields['bodysize'] = selected_bodysize;
    request.fields['typebreed'] = _selected_type_breed;
    request.fields['lat'] = lat.toString();
    request.fields['lone'] = lng.toString();

    var pic = await http.MultipartFile.fromPath('pathimagepets', _image.path,
        filename: _image.path);

    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'เพิ่มโพสต์สำเร็จ');
      Navigator.pop(context);
      print(namepets.text);
    }
  }
  // Future addEditpets() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String id_user = preferences.getString('id');
  //   print('id_user = $id_user');
  //   var uri = Uri.parse("${MyConstant().domain}/homestay/addpetsdata.php");
  //   var request = http.MultipartRequest("POST", uri);
  //   request.fields['id_user'] = id_user;
  //   request.fields['namepets'] = namepets.text;
  //   request.fields['detailspets'] = detailspets.text;
  //   request.fields['genderpets'] = _selected_gender;
  //   request.fields['category_pets'] = selectedCategorypets;
  //   request.fields['sterillzationpets'] = _selected_sterillzation_pets;
  //   request.fields['vaccinepets'] = _selected_vaccine_pets;
  //   request.fields['bodysize'] = selected_bodysize;
  //   request.fields['typebreed'] = _selected_type_breed;
  //   request.fields['lat'] = lat.toString();
  //   request.fields['lone'] = lng.toString();

  //   // request.files(formData.files);
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     // getAllCategory();
  //     _saveimage();
  //     Fluttertoast.showToast(msg: 'เพิ่มสำเร็จ');
  //     Navigator.pop(context);
  //     print(namepets.text);
  //   }

  //   // var pic = await http.MultipartFile.fromPath('image_post', _image.path,
  //   //     filename: _image.path);

  //   // request.files.add(pic);
  // }

  @override
  void initState() {
    _dropDownBodySizeStates = getDropDownBodyState();
    _dropDownTypeBreedStates = getDropDownMenuState();
    _dropDownGenderStates = getDropDownGenderState();
    _dropDownSterillzationPetsStates = getDropDownSterillzationState();
    _dropDownVaccinePetsStates = getDropDownVaccineState();
    // TODO: implement initState
    super.initState();
    findLatLng();
    getAllCategory();
    if (widget.index != null) {
      editMode = true;
      namepets.text = widget.petsList[widget.index]['namepets'];
      detailspets.text = widget.petsList[widget.index]['detailspets'];
      _selected_gender = widget.petsList[widget.index]['genderpets'];
      selectedCategorypets = widget.petsList[widget.index]['category_pets'];
      _selected_sterillzation_pets =
          widget.petsList[widget.index]['sterillzationpets'];
      _selected_vaccine_pets = widget.petsList[widget.index]['vaccinepets'];
      selected_bodysize = widget.petsList[widget.index]['bodysize'];
      _selected_type_breed = widget.petsList[widget.index]['typebreed'];
      _selected_gender = widget.petsList[widget.index]['lat'];
      _selected_gender = widget.petsList[widget.index]['lone'];
    }
  }

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/CategoryallPets.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItem = jsonData;
      });
    }
    print(categoryItem);
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('testgpsproject'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'ที่อยู่ของคุณ',
            snippet: 'ละติจูต $lat, ลองติจูต $lng',
          )),
    ].toSet();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat = $lat lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  _saveimage() async {
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        ByteData byteData = await images[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();

        MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
            filename: images[i].name, contentType: MediaType('image', 'jpeg'));
        FormData fotmData = FormData.fromMap({'pathimage': multipartFile});

        var response = await dio.post(
            "${MyConstant().domain}/homestay/addpetsall.php",
            data: fotmData);
        if (response.statusCode == 200) {
          print(response.data);
        }
      }
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

  void changedDropDownState(String selectedState) {
    setState(() {
      _selected_type_breed = selectedState;
    });
    print(_selected_type_breed);
  }

  void changedDropDownStateBody_size(String selectedState) {
    setState(() {
      selected_bodysize = selectedState;
    });
    print(selected_bodysize);
  }

  void changedSterillzarionDropDownState(String selectedState) {
    setState(() {
      _selected_sterillzation_pets = selectedState;
    });
    print(_selected_sterillzation_pets);
  }

  void changedVaccineDropDownState(String selectedState) {
    setState(() {
      _selected_vaccine_pets = selectedState;
    });
    print(_selected_vaccine_pets);
  }

  void genderdropDownState(String selectedState) {
    setState(() {
      _selected_gender = selectedState;
    });
    print(_selected_gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "หาบ้านให้น้อง",
          style: TextStyle(color: Colors.black87),
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                addEditpets();
                // _saveimage();
                // if (_formKey.currentState.validate()) {
                //   _formKey.currentState.save();
                //   if (images == null ||
                //       namepetsText == null ||
                //       namepetsText.isEmpty ||
                //       detailpetsText == null ||
                //       detailpetsText.isEmpty ||
                //       _selected_gender == null ||
                //       _selected_gender.isEmpty) {
                //   } else {
                //     // uploadImage(context);
                //     // addpets();
                // _savedata();
                // }
                // }
              },
              child: Container(
                padding: EdgeInsets.only(top: 12, right: 25),
                child: Text('save',
                    style: TextStyle(fontSize: 18, color: kPrimaryColor)),
              )),
        ],
        iconTheme: IconThemeData(color: kPrimaryColor),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                lat == null ? showProgress() : showMap(),
                // showMap(),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.photo),
                            SizedBox(width: getProportionateScreenHeight(10)),
                            Text('รูปภาพ'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.image,
                          size: 50,
                        ),
                        onPressed: () {
                          choiceImage();
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      editMode
                          ? Container(
                              child: Image.network(
                                  '${MyConstant().domain}/homestay/Pets/${widget.petsList[widget.index]['pathimagepets']}'),
                              width: 100,
                              height: 100,
                            )
                          : Text(''),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Container(
                        child: _image == null
                            ? Center(child: Text('ไม่มีรูป'))
                            : Image.file(_image),
                        width: 200,
                        height: 200,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Column(
                      //     children: <Widget>[
                      //       images == null
                      //           ? Container(
                      //               height: 300.0,
                      //               width: 400.0,
                      //               child: new Icon(
                      //                 Icons.image,
                      //                 size: 250.0,
                      //                 color: Theme.of(context).primaryColor,
                      //               ),
                      //             )
                      //           : SizedBox(
                      //               height: 200.0,
                      //               width: 500,
                      //               child: new ListView.builder(
                      //                 scrollDirection: Axis.horizontal,
                      //                 itemBuilder: (BuildContext context,
                      //                         int index) =>
                      //                     new Padding(
                      //                         padding:
                      //                             const EdgeInsets.all(5.0),
                      //                         child: Stack(children: <Widget>[
                      //                           Card(
                      //                             child: AssetThumb(
                      //                               asset: images[index],
                      //                               height: 300,
                      //                               width: 300,
                      //                             ),
                      //                           ),
                      //                           Positioned(
                      //                             right: 5,
                      //                             top: 5,
                      //                             child: InkWell(
                      //                               child: Icon(
                      //                                 Icons.remove_circle,
                      //                                 size: 20,
                      //                                 color: Colors.red,
                      //                               ),
                      //                               onTap: () {
                      //                                 setState(() {
                      //                                   images.replaceRange(
                      //                                       index,
                      //                                       index + 1, []);
                      //                                 });
                      //                               },
                      //                             ),
                      //                           ),
                      //                         ])),
                      //                 itemCount: images.length,
                      //               ),
                      //             ),
                      //       RaisedButton.icon(
                      //           onPressed: loadAssets,
                      //           icon: new Icon(Icons.image),
                      //           label: new Text("กรุณาเลือกรูป")),
                      //       // Padding(
                      //       //   padding: const EdgeInsets.all(8.0),
                      //       //   child: new Text('Error Dectected: $_error'),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      // Expanded(child: buildListView()),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'ชื่อสัตว์เลี้ยง',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: (Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      buildNamePetsFormField(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      new Divider(
                        color: Colors.grey[100],
                        height: 20,
                        thickness: 8,
                        indent: 0,
                        endIndent: 4,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'รายละเอียด',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: (Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      buildDetailPetsFormField(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      new Divider(
                        color: Colors.grey[100],
                        height: 20,
                        thickness: 8,
                        indent: 0,
                        endIndent: 4,
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            'อื่นๆ',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: (Colors.black)),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_type_breed(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_gender(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_sterillzation_pets(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_vaccine_pets(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_type_body_size(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Divider(),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      selected_petscategory(),
                      SizedBox(height: getProportionateScreenHeight(10)),

                      new Divider(
                        color: Colors.grey[100],
                        height: 20,
                        thickness: 8,
                        indent: 0,
                        endIndent: 4,
                      ),
                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(30)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selected_vaccine_pets() => Row(
        children: <Widget>[
          Expanded(
              child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              // ignore: missing_required_param
              child: DropdownButton<String>(
                isDense: true,
                hint: new Text("ฉีดวัดซีนแล้วหรือยัง?"),
                value: _selected_vaccine_pets,
                items: _dropDownVaccinePetsStates,
                onChanged: changedVaccineDropDownState,
              ),
            ),
          )),
        ],
      );

  Widget selected_sterillzation_pets() => Row(
        children: <Widget>[
          Expanded(
              child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              // ignore: missing_required_param
              child: DropdownButton(
                isDense: true,
                hint: new Text("ทำหมันแล้วหรือยัง?"),
                value: _selected_sterillzation_pets,
                items: _dropDownSterillzationPetsStates,
                onChanged: changedSterillzarionDropDownState,
              ),
            ),
          )),
        ],
      );

  Widget selected_gender() => Row(
        children: <Widget>[
          Expanded(
              child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              // ignore: missing_required_param
              child: DropdownButton(
                isDense: true,
                hint: new Text("เพศสัตว์เลี้ยง"),
                value: _selected_gender,
                items: _dropDownGenderStates,
                onChanged: genderdropDownState,
              ),
            ),
          )),
        ],
      );

  List<DropdownMenuItem<String>> getDropDownGenderState() {
    List<DropdownMenuItem<String>> state1 = List();
    for (Map statelist in _myjson_gender) {
      state1.add(
        DropdownMenuItem(
          value: statelist["name"].toString(),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  statelist["name"],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return state1;
  }

  List<DropdownMenuItem<String>> getDropDownVaccineState() {
    List<DropdownMenuItem<String>> state1 = List();
    for (Map statelist in _myjson_vaccine_pets) {
      state1.add(
        DropdownMenuItem(
          value: statelist["name"].toString(),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  statelist["name"],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return state1;
  }

  List<DropdownMenuItem<String>> getDropDownMenuState() {
    List<DropdownMenuItem<String>> state1 = List();
    for (Map statelist in _myjson_type_breed) {
      state1.add(
        DropdownMenuItem(
          value: statelist["name"].toString(),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  statelist["name"],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return state1;
  }
  //  List<DropdownMenuItem<String>> getDropDownMenuState() {
  //   List<DropdownMenuItem<String>> state1 = List();
  //   for (Map statelist in _myjson_type_breed) {
  //     state1.add(
  //       DropdownMenuItem(
  //         value: statelist["name"].toString(),
  //         child: Row(
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.only(left: 10),
  //               child: Text(
  //                 statelist["name"],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   return state1;
  // }

  List<DropdownMenuItem<String>> getDropDownSterillzationState() {
    List<DropdownMenuItem<String>> state1 = List();
    for (Map statelist in _myjson_sterillzation_pets) {
      state1.add(
        DropdownMenuItem(
          value: statelist["name"].toString(),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  statelist["name"],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return state1;
  }

  List<DropdownMenuItem<String>> getDropDownBodyState() {
    List<DropdownMenuItem<String>> state1 = List();
    for (Map statelist in _myjson_bodysize) {
      state1.add(
        DropdownMenuItem(
          value: statelist["name"].toString(),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  statelist["name"],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return state1;
  }

  Widget selected_type_breed() => Row(
        children: <Widget>[
          Expanded(
              child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isDense: true,
                hint: new Text("พันธุ์สัตว์เลี้ยง"),
                value: _selected_type_breed,
                items: _dropDownTypeBreedStates,
                onChanged: changedDropDownState,
              ),
            ),
          )),
        ],
      );
  Widget selected_petscategory() => Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  isDense: true,
                  items: categoryItem.map((category) {
                    return DropdownMenuItem(
                        value: category['name_category'],
                        child: Text(category['name_category']));
                  }).toList(),
                  value: selectedCategorypets,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategorypets = newValue;
                    });
                  },
                  hint: Text('หมวดหมู่'),
                  isExpanded: true,
                ),
              ),
            ),
          ),
        ],
      );

  Widget selected_type_body_size() => Row(
        children: <Widget>[
          Expanded(
              child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isDense: true,
                hint: new Text("ขนาดสัตว์เลี้ยง"),
                value: selected_bodysize,
                items: _dropDownBodySizeStates,
                onChanged: changedDropDownStateBody_size,
              ),
            ),
          )),
        ],
      );

  TextFormField buildDetailPetsFormField() {
    return TextFormField(
      controller: detailspets,
      onSaved: (newValue) => detailpetsText = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvaliddetailpetsErrors);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kInvaliddetailpetsErrors);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.left,
      decoration: InputDecoration.collapsed(hintText: "เพิ่มรายละเอียด"),
      maxLines: 10,
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  TextFormField buildNamePetsFormField() {
    return TextFormField(
      controller: namepets,
      onSaved: (newValue) => namepetsText = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidnamepetsError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kInvalidnamepetsError);
          return "";
        }
        return null;
      },
      textAlign: TextAlign.left,
      decoration: InputDecoration.collapsed(hintText: "เพิ่มชื่อสัตว์เลี้ยง"),
    );
  }

  Widget buildListView() {
    return ListView(
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }
}
