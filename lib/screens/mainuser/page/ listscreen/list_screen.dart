import 'package:final_project/screens/mainuser/page/%20listscreen/components/body.dart';
import 'package:final_project/size_config.dart';
import 'package:flutter/material.dart';

import 'components/gridViewpets.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'รายการการรับเลี้ยง',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        
      ),
      body: GridViewPetss(),
    );
  }
}
