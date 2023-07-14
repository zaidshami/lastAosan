import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/product_model.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/images.dart';

class CustomBottomSheet extends StatefulWidget {
final Product product;

  const CustomBottomSheet({Key key, this.product}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  bool isSwipeUp =true ;
  @override
  Widget build(BuildContext context) {

    return Container(
      height:  MediaQuery.of(context).size.height*0.93 ,
      width:   MediaQuery.of(context).size.width,
      decoration:  BoxDecoration(
          image: DecorationImage(
          fit: BoxFit.fill,
          image:  NetworkImage("${widget.product.img_path.toString()}" ,
          )
          // NetworkImage('https://wallpaperaccess.com/full/2440003.jpg')

          ),
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white
          ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Align(alignment: Alignment.topCenter,
        child: (isSwipeUp)
            ? Icon(
          Icons.expand_more_outlined,
          size: 30,
          color: Colors.white,
        )
            : Icon(
          Icons.expand_less_outlined,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}