//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../utill/images.dart';
//
// class CustGestureCardDetector extends StatelessWidget {
//  String image;
// CustGestureCardDetector({ this.image = Images.banr2});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         /* Get.toNamed('/detailpage/', arguments: {
//           'title': info[i]['title'].toString(),
//           'text': info[i]['text'].toString(),
//           'name': info[i]['name'].toString(),
//           'img': info[i]['img'].toString(),
//           'time': info[i]['time'].toString(),
//           'prize': info[i]['prize'].toString(),
//         });*/
//       },
//       child: Container(
//         padding: const EdgeInsets.only(left: 20, top: 32),
//         height: 220,
//         width: MediaQuery.of(context).size.width - 20,
//
//
//         decoration: BoxDecoration(
//           image:  DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
//             borderRadius: BorderRadius.circular(5),
//             gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//               Color(0xFF85E6FF),
//                 Color(0xFFEABBFF)
//
//               ],
//             )
//         ),
//
//       ),
//     );
//   }
// }
