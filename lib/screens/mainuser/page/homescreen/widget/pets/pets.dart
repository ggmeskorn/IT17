import 'package:flutter/material.dart';

import 'components/body.dart';

class PetsScreen extends StatefulWidget {
  final lat;
  final lone;

  const PetsScreen({Key key, this.lat, this.lone}) : super(key: key);

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Body(),
    );
  }
}
