import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/petsdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../../my_constant.dart';

class SelectcategoryPets extends StatefulWidget {
  final category_pets;

  const SelectcategoryPets({Key key, this.category_pets}) : super(key: key);
  @override
  _SelectcategoryPetsState createState() => _SelectcategoryPetsState();
}

class _SelectcategoryPetsState extends State<SelectcategoryPets> {
  List petsdata2 = List();
  Future categoryByDate() async {
    var url = '${MyConstant().domain}/homestay/Categorybypets.php';
    var response =
        await http.post(url, body: {"name_category": widget.category_pets});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        petsdata2 = jsonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category_pets),
      ),
      body: Container(
        child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 11 / 15,
            ),
            itemCount: petsdata2.length,
            itemBuilder: (context, index) {
              return GridViewP(
                id: petsdata2[index]['id'],
                pathImage:
                    '${MyConstant().domain}/homestay/Users/${petsdata2[index]['pathImage']}',
                pathimagepets:
                    '${MyConstant().domain}/homestay/Pets/${petsdata2[index]['pathimagepets']}',
                namepets: petsdata2[index]['namepets'],
                typebreed: petsdata2[index]['typebreed'],
                detailspets: petsdata2[index]['detailspets'],
                username: petsdata2[index]['username'],
                create_at: petsdata2[index]['create_at'],
                category_pets: petsdata2[index]['category_pets'],
                genderpets: petsdata2[index]['genderpets'],
                sterillzationpets: petsdata2[index]['sterillzationpets'],
                vaccinepets: petsdata2[index]['vaccinepets'],
                bodysize: petsdata2[index]['bodysize'],
                phone: petsdata2[index]['phone'],
                lat: petsdata2[index]['lat'],
                lone: petsdata2[index]['lone'],
                status: petsdata2[index]['statuspets'],
              );
            }),
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
  final pathimagepets;
  final pathimage;
  final category_pets;
  final genderpets;
  final pathImage;
  final username;
  final create_at;
  final update_at;
  final phone;
  final sterillzationpets;
  final vaccinepets;
  final bodysize;
  final lat;
  final lone;
  final status;

  const GridViewP(
      {Key key,
      this.namepets,
      this.typebreed,
      this.detailspets,
      this.pathimagepets,
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
      this.pathimage,
      this.phone})
      : super(key: key);
  @override
  _GridViewPState createState() => _GridViewPState();
}

class _GridViewPState extends State<GridViewP> {
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
              pathimagepets: widget.pathimagepets,
              pathImage: widget.pathImage,
              username: widget.username,
              create_at: widget.create_at,
              update_at: widget.update_at,
              pathimage: widget.pathimage,
              namepets: widget.namepets,
              detailspets: widget.detailspets,
              category_pets: widget.category_pets,
              phone: phone,
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
