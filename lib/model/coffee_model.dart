import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coffee {
  String id;
  String petsName;
  String address;
  String description;
  String thumbNail;
  LatLng locationCoords;

  Coffee(
      {this.id,
      this.petsName,
      this.address,
      this.description,
      this.thumbNail,
      this.locationCoords});
}

final List<Coffee> petsp = [
  Coffee(
      petsName: 'กาก้า',
      address: '',
      description: '',
      locationCoords: LatLng(16.4587249, 102.8027422),
      thumbNail: 'assets/images/pel.jpg'),
  Coffee(
      petsName: 'โบ้',
      address: 'กังสดาง',
      description: 'ชุมชน ',
      locationCoords: LatLng(16.4587249, 102.8027422),
      thumbNail: 'assets/images/newsdog.jpg'),
  Coffee(
      petsName: 'บุญเติม',
      address: 'Oricafe',
      description: 'ร้านกาแฟ ',
      locationCoords: LatLng(16.4591619, 102.8225225),
      thumbNail: 'assets/images/newsdog.jpg'),
  Coffee(
      petsName: 'มิกกี้เม้าส์',
      address: 'NpPack',
      description: 'หอพัก',
      locationCoords: LatLng(16.4587249, 102.8027422),
      thumbNail: 'assets/images/pel.jpg'),
  Coffee(
      petsName: 'น้ำค้าง',
      address: 'NpPack',
      description: 'หอพัก',
      locationCoords: LatLng(16.4513195, 102.8103343),
      thumbNail: 'assets/images/pel.jpg'),
];
