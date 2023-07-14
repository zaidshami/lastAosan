import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../utill/color_resources.dart';
import '../../utill/images.dart';

class TabShimmer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return   Shimmer.fromColors(

      baseColor: Colors.black,
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Container(
        //padding: getPadding(right: ),
        height: 45,

          margin: EdgeInsets.symmetric(horizontal: 0), decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: ColorResources.WHITE,
      )),
    );

    //   Container(
    //   height: 45,
    //
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       color: Colors.black ,
    //       boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)],
    //     ),
    //     // child: FadeInImage.assetNetwork(
    //     //   placeholder: Images.placeholder,
    //     //   fit: BoxFit.cover,
    //     //   image: Images.placeholder,
    //     //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
    //     // )
    //
    //   /// old shimmer
    //   /* Shimmer.fromColors(
    //         baseColor: Colors.grey[300],
    //         highlightColor: Colors.grey[100],
    //         enabled: isEnabled,
    //         child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch, children: [
    //           // Product Image
    //           Expanded(
    //             flex: 6,
    //             child: FadeInImage.assetNetwork(
    //               placeholder: Images.placeholder, fit: BoxFit.cover,
    //               image: Images.placeholder,
    //               imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
    //             ),
    //           ),
    //
    //           // Product Details
    //           Expanded(
    //             flex: 4,
    //             child: Padding(
    //               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(height: 20, color: Colors.white),
    //                   SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
    //                   Row(children: [
    //                     Expanded(
    //                       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //                         Container(height: 20, width: 50, color: Colors.white),
    //                       ]),
    //                     ),
    //                     Container(height: 10, width: 50, color: Colors.white),
    //                     Icon(Icons.star, color: Colors.orange, size: 15),
    //                   ]),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ]),
    //       ),*/
    // );
  }
}