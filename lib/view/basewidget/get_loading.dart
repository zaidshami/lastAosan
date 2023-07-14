import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/animations/bouncing_line.dart';

import '../../utill/dimensions.dart';

Widget getloading(BuildContext context,bool item){
  return
    item? Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: Container(
            color: Colors.transparent,
            height: 30,width: 30,
            child:       LoadingBouncingLine.circle(

              borderColor: Colors.grey,
              borderSize: 3.0,
              size: 30,
              backgroundColor: Colors.grey,
              duration: Duration(milliseconds: 500),
            ),
          ),
        ))
        : SizedBox.shrink();
}

Widget getloading1(BuildContext context){
  return
Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: Container(
            color: Colors.transparent,
            height: 30,width: 30,
            child:       LoadingBouncingLine.circle(

              borderColor: Colors.grey,
              borderSize: 3.0,
              size: 30,
              backgroundColor: Colors.grey,
              duration: Duration(milliseconds: 1000)
            ),
          ),
        ));

}

Widget getloading3(BuildContext context){
  return
    Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: Container(
            color: Colors.transparent,
            height: 25,width: 25,
            child:       LoadingBouncingLine.circle(

                borderColor: Colors.white,
                borderSize: 3.0,
                size: 25,
                backgroundColor: Colors.grey,
                duration: Duration(milliseconds: 1000)
            ),
          ),
        ));

}

Widget getloading4(BuildContext context){
  return
    Center(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_EXTRA_SMALL),
          child: LoadingBouncingLine.circle(

              borderColor: Colors.white,
              borderSize: 3.0,
              size: 50,
              backgroundColor: Colors.grey,
              duration: Duration(milliseconds: 1000)
          ),
        ));

}



Widget getloading2(BuildContext context){
  return
    Center(
        child: LoadingBouncingLine.circle(

            borderColor: Colors.grey,
            borderSize: 3.0,
            size: 60,
            backgroundColor: Colors.grey,
            duration: Duration(milliseconds: 1500)
        ));

}