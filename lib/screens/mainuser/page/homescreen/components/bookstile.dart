// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:final_project/components/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class BooksTile extends StatelessWidget {
//   final image_post;
//   final author_post;
//   final post_date;
//   final comments_post;
//   final total_Like;
//   final title_post;
//   final category_name;
//   final create_date;
//   final body_post;

//   const BooksTile(
//       {Key key,
//       this.image_post,
//       this.author_post,
//       this.post_date,
//       this.comments_post,
//       this.total_Like,
//       this.title_post,
//       this.category_name,
//       this.create_date,
//       this.body_post})
//       : super(key: key);

//   // final String imgAssetPath, title, description, categorie;
//   // final int rating;
//   // BooksTile(
//   //     {@required this.rating,
//   //     @required this.description,
//   //     @required this.title,
//   //     @required this.categorie,
//   //     @required this.imgAssetPath});

//   // static final uuid = Uuid();
//   // final String imgTag = uuid.v4();
//   // final String titleTag = uuid.v4();
//   // final String authorTag = uuid.v4();
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         height: 150.0,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               elevation: 4,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//                   child: Container(
//                     // height: 180,
//                     // margin: EdgeInsets.only(
//                     //   left: 12,
//                     //   top: 6,
//                     // ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Image.network(wi

//                         height: 150,
//                         width: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   // CachedNetworkImage(
//                   //   imageUrl: '$imgAssetPath',
//                   //   placeholder: (context, url) => Container(
//                   //     height: 150.0,
//                   //     width: 100.0,
//                   //     child: LoadingWidget(
//                   //       isImage: true,
//                   //     ),
//                   //   ),
//                   //   errorWidget: (context, url, error) => Image.asset(
//                   //     'assets/images/place.png',
//                   //     fit: BoxFit.cover,
//                   //     height: 150.0,
//                   //     width: 100.0,
//                   //   ),
//                   //   fit: BoxFit.cover,
//                   //   height: 150.0,
//                   //   width: 100.0,
//                   // ),
//                 ),
//                 //   child: Hero(tag: imgAssetPath, child: Container( height: 180,
//                 // margin: EdgeInsets.only(left: 12,
//                 //   top: 6,),
//                 // child: ClipRRect(
//                 //   borderRadius: BorderRadius.circular(8.0),
//                 //                 child: Image.asset(imgAssetPath, height: 150,width: 100,
//                 //     fit: BoxFit.cover,),
//                 // ),),),
//               ),
//             SizedBox(
//               width: 10.0,
//             ),
//             Flexible(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                                      Material(
//                       type: MaterialType.transparency,
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 17.0,
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).textTheme.headline6.color,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),

//                   // SizedBox(
//                   //   height: 5,
//                   // ),
//                   // SizedBox(height: 10.0),
//                   Text(
//                     description
//                         .replaceAll(r'\n', '\n')
//                         .replaceAll(r'\r', '')
//                         .replaceAll(r'\"', '"'),
//                     style: TextStyle(
//                       fontSize: 13.0,
//                       color: Theme.of(context).textTheme.caption.color,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   //   GestureDetector(
//   //     onTap: (){
//   //       // Navigator.push(context, MaterialPageRoute(
//   //       //   builder: (context) => BookDetails()
//   //       // ));
//   //     },
//   //     child: Container(
//   //       height: 200,
//   //       margin: EdgeInsets.only(right: 16),
//   //       alignment: Alignment.bottomLeft,
//   //       child: Stack(
//   //         children: <Widget>[
//   //           Container(
//   //             height: 180,
//   //             alignment: Alignment.bottomLeft,
//   //             child: Container(
//   //                 width: MediaQuery.of(context).size.width - 80,
//   //                 height: 140,
//   //                 padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
//   //                 decoration: BoxDecoration(
//   //                     color: Colors.white,
//   //                     borderRadius: BorderRadius.circular(12)
//   //                 ),
//   //                 child: Row(
//   //                   children: <Widget>[
//   //                     Container(
//   //                       width: 110,
//   //                     ),
//   //                     Container(
//   //                       width: MediaQuery.of(context).size.width - 220,
//   //                       child: Column(
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: <Widget>[
//   //                           Text(title, style: TextStyle(
//   //                               color: Colors.black87,
//   //                               fontSize: 15,
//   //                               fontWeight: FontWeight.w500
//   //                           ),),
//   //                           SizedBox(height: 8,),
//   //                           Text(description, style: TextStyle(
//   //                               color: Colors.grey,
//   //                               fontSize: 12
//   //                           ),),
//   //                           Spacer(),
//   //                           // Row(
//   //                           //   children: <Widget>[
//   //                           //     StarRating(
//   //                           //       rating: rating,
//   //                           //     ),
//   //                           //     Spacer(),
//   //                           //     Text(categorie,style: TextStyle(
//   //                           //         color: Color(0xff007084)
//   //                           //     ),)
//   //                           //   ],
//   //                           // )
//   //                         ],
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 )
//   //             ),
//   //           ),
//   //           Container(
//   //             height: 180,
//   //             margin: EdgeInsets.only(left: 12,
//   //               top: 6,),
//   //             child: ClipRRect(
//   //               borderRadius: BorderRadius.circular(8.0),
//   //                             child: Image.asset(imgAssetPath, height: 150,width: 100,
//   //                 fit: BoxFit.cover,),
//   //             ),
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
