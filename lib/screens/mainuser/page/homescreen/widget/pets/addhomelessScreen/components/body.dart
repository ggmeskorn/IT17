// import 'dart:io';
// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:final_project/components/form_error.dart';
// import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../../../constants.dart';
// import '../../../../../../my_constant.dart';
// import '../../../../../../size_config.dart';

// final _formKey = GlobalKey<FormState>();
// String namepets, detailpets, agepets, urlimage;
// bool remember = false;

// String _selected_gender;
// String _selected_type_breed;
// String _selected_sterillzation_pets;
// String _selected_vaccine_pets;

// List<Map> _myjson_vaccine_pets = [
//   {"id": '1', "name": 'ไม่ระบุ'},
//   {
//     "id": '2',
//     "name": '6 เดือน\n[ถ่ายพยาธิและตรวจสุขภาพ]',
//   },
//   {
//     "id": '3',
//     "name": '8 เดือน\n[วัดซีน 5 โรค ]',
//   },
//   {"id": '4', "name": '12 เดือน\n[วัดซีนรวม 5 โรค ]'},
//   {
//     "id": '5',
//     "name": '18 เดือน\n[วัดซีนรวม 5 โรค]',
//   },
// ];

// List<Map> _myjson_sterillzation_pets = [
//   {"id": '1', "name": 'ทำหมันแล้ว'},
//   {"id": '2', "name": 'ยังไม่ทำ'}
// ];

// List<Map> _myjson_gender = [
//   {"id": '1', "name": 'ผู้'},
//   {"id": '2', "name": 'เมีย'}
// ];
// List<Map> _myjson_type_breed = [
//   {"id": '1', "name": 'ไม่ระบุ'},
//   {"id": '2', "name": 'โกลเด้น รีทรีฟเวอร์'},
//   {"id": '3', "name": 'คอลลี่'},
//   {"id": '4', "name": 'เคน คอร์โซ่'},
//   {"id": '5', "name": 'เครนเทอร์เรีย'},
//   {"id": '6', "name": 'ชเนาเซอร์'},
//   {"id": '7', "name": 'ชิบะ อินุ'},
//   {"id": '8', "name": 'เชดแลนด์ชิพด๊อก'},
//   {"id": '9', "name": 'ชิสุ'},
//   {"id": '10', "name": 'ชิวาวา'},
// ];
//  List<Asset> images = <Asset>[];
//   String _error = 'No Error Dectected';

// // List<Object> images = List<Object>();
// // File file;
// // Future<File> file;

// class Body extends StatelessWidget {
//   void _close() {
//     BuildContext context;
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "หาบ้านให้น้อง",
//           style: TextStyle(color: Colors.black87),
//         ),
//         actions: <Widget>[
//           GestureDetector(
//               onTap: () {
//                 if (_formKey.currentState.validate()) {
//                   _formKey.currentState.save();

//                   if (images == null ||
//                       namepets == null ||
//                       namepets.isEmpty ||
//                       detailpets == null ||
//                       detailpets.isEmpty) {
//                   } else {
//                     // uploadImage(context);
//                   }
//                 }
//               },
//               child: Container(
//                 padding: EdgeInsets.only(top: 12, right: 25),
//                 child: Text('save',
//                     style: TextStyle(fontSize: 18, color: kPrimaryColor)),
//               )),
//         ],
//         iconTheme: IconThemeData(color: kPrimaryColor),
//         backgroundColor: Colors.white,
//       ),
//       body: Bodys(),
//     );
//     // return Stack(
//     //   children: <Widget>[Bodys(), addButton()],
//     // );
//   }

//   // Future<Null> uploadImage(BuildContext context) async {
//   //   Random random = Random();
//   //   int i = random.nextInt(100000);
//   //   String namePicImage = 'pets$i.jpg';
//   //   print('namePiceImage = $namePicImage pathImage = ${file.path}');
//   //   String url = '${MyConstant().domain}/homestay/saveShop.php';
//   //   try {
//   //     Map<String, dynamic> map = Map();
//   //     map['file'] =
//   //         await MultipartFile.fromFile(images.path, filename: namePicImage);
//   //     FormData formData = FormData.fromMap(map);
//   //     await Dio().post(url, data: formData).then((value) async {
//   //       print('Response ===>>> $value');
//   //       urlimage = '${MyConstant().domain}/homestay/Pets/$namePicImage';
//   //       print('UrlImage: $urlimage');

//   //       SharedPreferences preferences = await SharedPreferences.getInstance();
//   //       String user_admin_id = preferences.getString('id');

//   //       String urlInsertData =
//   //           '${MyConstant().domain}/homestay/addpets.php?isAdd=true&User_Admin_id=$user_admin_id&Name_Pets=$namepets&Detail_Pets=$detailpets&PathImage=$urlimage';
//   //       await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
//   //     });
//   //   } catch (e) {}
//   // }
// }

// class Bodys extends StatefulWidget {
//   @override
//   _BodysState createState() => _BodysState();
// }

// class _BodysState extends State<Bodys> {
//   final List<String> errors = [];
//   void addError({String error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }

//   void removeError({String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//           child: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(30),
//             child: Column(
//               children: <Widget>[
//                 buildGridView(),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     child: Text(
//                       'ชื่อสัตว์เลี้ยง',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(color: (Colors.black)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 buildNamePetsFormField(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 new Divider(
//                   color: Colors.grey[100],
//                   height: 20,
//                   thickness: 8,
//                   indent: 0,
//                   endIndent: 4,
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(20)),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     child: Text(
//                       'รายละเอียด',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(color: (Colors.black)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 buildDetailPetsFormField(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 new Divider(
//                   color: Colors.grey[100],
//                   height: 20,
//                   thickness: 8,
//                   indent: 0,
//                   endIndent: 4,
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 selected_type_breed(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 Divider(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 selected_gender(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 Divider(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 selected_sterillzation_pets(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 Divider(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 selected_vaccine_pets(),
//                 SizedBox(height: getProportionateScreenHeight(10)),
//                 new Divider(
//                   color: Colors.grey[100],
//                   height: 20,
//                   thickness: 8,
//                   indent: 0,
//                   endIndent: 4,
//                 ),
//                 FormError(errors: errors),
//               ],
//             ),
        
//         ),
//       ),
//     );
//   }

//   Widget selected_gender() => Row(
//         children: <Widget>[
//           Expanded(
//               child: DropdownButtonHideUnderline(
//             child: ButtonTheme(
//               alignedDropdown: true,
//               // ignore: missing_required_param
//               child: DropdownButton<String>(
//                 isDense: true,
//                 hint: new Text("เพศสัตว์เลี้ยง"),
//                 value: _selected_gender,
//                 onChanged: (value) {
//                   setState(() {
//                     _selected_gender = value;
//                   });
//                   print(_selected_gender);
//                 },
//                 items: _myjson_gender.map((Map map) {
//                   return new DropdownMenuItem<String>(
//                     value: map["id"].toString(),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(left: 10),
//                           child: Text(map["name"]),
//                         )
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           )),
//         ],
//       );

//   Widget selected_type_breed() => Row(
//         children: <Widget>[
//           Expanded(
//               child: DropdownButtonHideUnderline(
//             child: ButtonTheme(
//               alignedDropdown: true,
//               // ignore: missing_required_param
//               child: DropdownButton<String>(
//                 isDense: true,
//                 hint: new Text("พันธุ์สัตว์เลี้ยง"),
//                 value: _selected_type_breed,
//                 onChanged: (value) {
//                   setState(() {
//                     _selected_type_breed = value;
//                   });
//                   print(_selected_type_breed);
//                 },
//                 items: _myjson_type_breed.map((Map map) {
//                   return new DropdownMenuItem<String>(
//                     value: map["id"].toString(),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(left: 10),
//                           child: Text(map["name"]),
//                         )
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           )),
//         ],
//       );

//   Widget selected_sterillzation_pets() => Row(
//         children: <Widget>[
//           Expanded(
//               child: DropdownButtonHideUnderline(
//             child: ButtonTheme(
//               alignedDropdown: true,
//               // ignore: missing_required_param
//               child: DropdownButton<String>(
//                 isDense: true,
//                 hint: new Text("ทำหมันแล้วหรือยัง?"),
//                 value: _selected_sterillzation_pets,
//                 onChanged: (value) {
//                   setState(() {
//                     _selected_sterillzation_pets = value;
//                   });
//                   print(_selected_sterillzation_pets);
//                 },
//                 items: _myjson_sterillzation_pets.map((Map map) {
//                   return new DropdownMenuItem<String>(
//                     value: map["id"].toString(),
//                     child: SingleChildScrollView(
//                       child: Row(
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.only(left: 10),
//                             child: Text(map["name"]),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           )),
//         ],
//       );

//   Widget selected_vaccine_pets() => Row(
//         children: <Widget>[
//           Expanded(
//               child: DropdownButtonHideUnderline(
//             child: ButtonTheme(
//               alignedDropdown: true,
//               // ignore: missing_required_param
//               child: DropdownButton<String>(
//                 isDense: true,
//                 hint: new Text("ฉีดวัดซีนแล้วหรือยัง?"),
//                 value: _selected_vaccine_pets,
//                 onChanged: (value) {
//                   setState(() {
//                     _selected_vaccine_pets = value;
//                   });
//                   print(_selected_vaccine_pets);
//                 },
//                 items: _myjson_vaccine_pets.map((Map map) {
//                   return new DropdownMenuItem<String>(
//                     value: map["id"].toString(),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(left: 10),
//                           child: Text(map["name"]),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           )),
//         ],
//       );

//   Future _onAddImageClick() async {
//     try {
//       var object = await ImagePicker()
//           .getImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
//       setState(() {
//         file = File(object.path);
//         print('file: $file');
//       });
//     } catch (e) {}
//   }

//   TextFormField buildDetailPetsFormField() {
//     return TextFormField(
//       onSaved: (newValue) => detailpets = newValue.trim(),
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kInvaliddetailpetsErrors);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value.isEmpty) {
//           addError(error: kInvaliddetailpetsErrors);
//           return "";
//         }
//         return null;
//       },
//       textAlign: TextAlign.left,
//       decoration: InputDecoration.collapsed(hintText: "เพิ่มรายละเอียด"),
//       maxLines: 10,
//     );
//   }

//   TextFormField buildNamePetsFormField() {
//     return TextFormField(
//       onSaved: (newValue) => namepets = newValue.trim(),
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kInvalidnamepetsError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value.isEmpty) {
//           addError(error: kInvalidnamepetsError);
//           return "";
//         }
//         return null;
//       },
//       textAlign: TextAlign.left,
//       decoration: InputDecoration.collapsed(hintText: "เพิ่มชื่อสัตว์เลี้ยง"),
//     );
//   }

//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 1,
//       shrinkWrap: true,
//       primary: false,
//       padding: const EdgeInsets.all(20),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       children: <Widget>[
//         GestureDetector(
//           onTap: _onAddImageClick,
//           child: Container(
//             color: Colors.grey[50],
//             child: file == null ? Icon(LineIcons.plus) : Image.file(file),
//           ),
//         ),
//       ],
//     );
//   }
// }
