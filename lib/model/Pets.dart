class PetsModels {
  String id;
  String namepets;
  String detailspets;
  String categoryPets;
  String genderpets;
  String sterillzationpets;
  String vaccinepets;
  String bodysize;
  String statuspets;
  String typebreed;
  String pathimagepets;
  String username;
  String pathImage;
  String createAt;
  String updateAt;
  String lat;
  String lone;

  PetsModels(
      {this.id,
      this.namepets,
      this.detailspets,
      this.categoryPets,
      this.genderpets,
      this.sterillzationpets,
      this.vaccinepets,
      this.bodysize,
      this.statuspets,
      this.typebreed,
      this.pathimagepets,
      this.username,
      this.pathImage,
      this.createAt,
      this.updateAt,
      this.lat,
      this.lone});

  PetsModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namepets = json['namepets'];
    detailspets = json['detailspets'];
    categoryPets = json['category_pets'];
    genderpets = json['genderpets'];
    sterillzationpets = json['sterillzationpets'];
    vaccinepets = json['vaccinepets'];
    bodysize = json['bodysize'];
    statuspets = json['statuspets'];
    typebreed = json['typebreed'];
    pathimagepets = json['pathimagepets'];
    username = json['username'];
    pathImage = json['pathImage'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    lat = json['lat'];
    lone = json['lone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['namepets'] = this.namepets;
    data['detailspets'] = this.detailspets;
    data['category_pets'] = this.categoryPets;
    data['genderpets'] = this.genderpets;
    data['sterillzationpets'] = this.sterillzationpets;
    data['vaccinepets'] = this.vaccinepets;
    data['bodysize'] = this.bodysize;
    data['statuspets'] = this.statuspets;
    data['typebreed'] = this.typebreed;
    data['pathimagepets'] = this.pathimagepets;
    data['username'] = this.username;
    data['pathImage'] = this.pathImage;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    data['lat'] = this.lat;
    data['lone'] = this.lone;
    return data;
  }
}
