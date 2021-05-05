import 'dart:convert';
import 'package:final_project/model/Product.dart';
import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/petsdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../../constants.dart';
import '../../../../../../../my_constant.dart';
import '../../../../../../../size_config.dart';

class CardPets extends StatefulWidget {
  @override
  _CardPetsState createState() => _CardPetsState();
}

class _CardPetsState extends State<CardPets> {
  List petsdata = List();

  Future showAllpost() async {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllpost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: petsdata.length,
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
              category_pets: petsdata[index]['category_pets'],
              genderpets: petsdata[index]['genderpets'],
              sterillzationpets: petsdata[index]['sterillzationpets'],
              vaccinepets: petsdata[index]['vaccinepets'],
              bodysize: petsdata[index]['bodysize'],
              lat: petsdata[index]['lat'],
              lone: petsdata[index]['lone'],
              status: petsdata[index]['statuspets'],
            );
          },
        ),
      ),
    );
  }
}

class CP extends StatefulWidget {
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
  final create_at;
  final update_at;
  final sterillzationpets;
  final vaccinepets;
  final bodysize;
  final lat;
  final pathimagepets;
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
                phone: phone,
                pathImage: widget.pathImage,
                username: widget.username,
                create_at: widget.create_at,
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
                lone: widget.lone,
                pathimagepets: widget.pathimagepets,
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
