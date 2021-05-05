class ImageModel {
  String idImage;
  String pathImages;
  String idPets;
  String username;

  ImageModel({this.idImage, this.pathImages, this.idPets, this.username});

  ImageModel.fromJson(Map<String, dynamic> json) {
    idImage = json['id_Image'];
    pathImages = json['PathImages'];
    idPets = json['Id_Pets'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_Image'] = this.idImage;
    data['PathImages'] = this.pathImages;
    data['Id_Pets'] = this.idPets;
    data['username'] = this.username;
    return data;
  }
}
