import 'dart:convert';

import 'package:final_project/screens/mainuser/page/homescreen/widget/pets/components/page/selectcategorypets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../my_constant.dart';

class CategoryListItem extends StatefulWidget {
  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  List categorsp = List();

  Future getAllCategory() async {
    var url = '${MyConstant().domain}/homestay/CategoryallPets.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categorsp = jsonData;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      // height: 250.0,
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: ListView.builder(
          itemCount: categorsp.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Itempetscategory(
              name_category: categorsp[index]['name_category'],
            );
          }),
    );
  }
}

class Itempetscategory extends StatefulWidget {
  final name_category;

  const Itempetscategory({Key key, this.name_category}) : super(key: key);
  @override
  _ItempetscategoryState createState() => _ItempetscategoryState();
}

class _ItempetscategoryState extends State<Itempetscategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Text(
            widget.name_category,
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectcategoryPets(
                  category_pets: widget.name_category,
                ),
              ),
            );
            debugPrint(widget.name_category);
          },
        ),
      ),
    );
  }
}
