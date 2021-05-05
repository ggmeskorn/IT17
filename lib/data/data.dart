import 'package:final_project/model/book_model.dart';
import 'package:final_project/model/single_book_model.dart';
import 'package:final_project/model/two_book.dart';
import 'package:flutter/material.dart';


List<BookModel> getBooks() {
  List<BookModel> books = new List<BookModel>();
  BookModel bookModel = new BookModel();

  //1
  bookModel.imgAssetPath = "assets/images/newsdog.jpg";
  bookModel.title = "ทารุณสัตว์วางยา-สักลาย";
  bookModel.description = '''สังคมออนไลน์วิพากษ์วิจารณ์ หลังมีผู้เผยแพร่ภาพเจ้าของสุนัขวางยาสลบ เพียงเพื่อต้องการให้สักลายบนลำตัว''';
  bookModel.rating = 5;
  bookModel.categorie = "ทารุณ";

  books.add(bookModel);
  bookModel = new BookModel();

  //1
  bookModel.imgAssetPath = "assets/images/gnews.webp";
  bookModel.title = "เยอรมนีจัดเต็ม ร่างกฎหมาย";
  bookModel.description =
      '''เยอรมนีจัดเต็มร่างกฎหมายคุ้มครองสุนัข บังคับให้เจ้าของสุนัขจะต้องพาสุนัขออกไปเดินเล่นวันละ 2 ครั้ง ครั้งละไม่ต่ำกว่า 1 ชั่วโมง''';
  bookModel.rating = 4;
  bookModel.categorie = "Drama";

  books.add(bookModel);
  bookModel = new BookModel();

  return books;
}

List<SingleBookModel> getSingleBooks() {
  List<SingleBookModel> books = new List<SingleBookModel>();
  SingleBookModel singleBookModel = new SingleBookModel();

  //1
  singleBookModel.imgAssetPath = "assets/pexels-golden-jojo-2067447.jpg";
  singleBookModel.title = "ทองเอก";
  singleBookModel.categorie = "ไม่ระบุ";
  books.add(singleBookModel);

  singleBookModel = new SingleBookModel();

  //2
  singleBookModel.imgAssetPath = "assets/pexels-laura-stanley-2252311.jpg";
  singleBookModel.title = "เอกมัย";
  singleBookModel.categorie = "ไม่ระบุ";
  books.add(singleBookModel);

  singleBookModel = new SingleBookModel();

  //3
  singleBookModel.imgAssetPath = "assets/pexels-maud-slaats-2326936.jpg";
  singleBookModel.title = "ทองแท้";
  singleBookModel.categorie = "ไม่ระบุ";
  books.add(singleBookModel);

  singleBookModel = new SingleBookModel();

  //4
  singleBookModel.imgAssetPath = "assets/pexels-miguel-constantin-montes-2623968.jpg";
  singleBookModel.title = "กี้";
  singleBookModel.categorie = "โกลเด้น";
  books.add(singleBookModel);

  singleBookModel = new SingleBookModel();

  //1
  singleBookModel.imgAssetPath = "assets/pel.jpg";
  singleBookModel.title = "เจสัน";
  singleBookModel.categorie = "ไม่ระบุ";
  books.add(singleBookModel);

  singleBookModel = new SingleBookModel();

  return books;
}

List<TwoBookModel> gettwoBooks() {
  List<TwoBookModel> books = new List<TwoBookModel>();
  TwoBookModel twoBookModel = new TwoBookModel();

  //1
  twoBookModel.imgAssetPath = "assets/images/pexels-zen-chung-5745275.jpg";
  twoBookModel.title = "พาน้องไปเดินเล่นที่บึงสีฐาน";
  twoBookModel.categorie = "วันนี้พาน้องๆไปเดินเล่นที่บึงสีฐาน หน้าตาของเด็กมีความสดใสมากมาย";
  books.add(twoBookModel);

  twoBookModel = new TwoBookModel();

  //2
  twoBookModel.imgAssetPath = "assets/images/pexels-helena-lopes-4453109.jpg";
  twoBookModel.title = "ออกกำลังกายยามเช้ากัน";
  twoBookModel.categorie = "ออกกำลังกายยามเช้าให้น้องหมาสดใสสุขภาพร่างกายแข็งแรง";
  books.add(twoBookModel);

  twoBookModel = new TwoBookModel();

  //3
  twoBookModel.imgAssetPath = "assets/images/pexels-pranidchakan-boonrom-1350591.jpg";
  twoBookModel.title = "อาการป่วยของเจ้าทองดี";
  twoBookModel.categorie = "ตอนนี้เจ้าทองสุขภาพแข็งแรงมากแล้ว จะกลับบ้านได้อีกสามวัน";
  books.add(twoBookModel);

  twoBookModel = new TwoBookModel();

  return books;
}
