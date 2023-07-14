import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import '../../../../data/model/response/category.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final SubCategory category;
final double height ;
final double width;
  const CategoryWidget({Key key, @required this.category , this.height=70, this.width= 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1),
          //     borderRadius:BorderRadius.circular(25),
          //     boxShadow: [
          //                      // BoxShadow(color: Colors.black.withOpacity(0.2),
          //                      //     spreadRadius: 1,
          //                      //     blurRadius: 5)
          //                    ],
          // ),
          padding: getPadding(bottom: 3),
          height: height,
          width: width,
          margin: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: ClipRRect(

            borderRadius: BorderRadius.circular(10),
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 10),
              //     borderRadius:BorderRadius.circular(50),
              //     boxShadow: [
              //                      // BoxShadow(color: Colors.black.withOpacity(0.2),
              //                      //     spreadRadius: 1,
              //                      //     blurRadius: 5)
              //                    ],
              // ),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Image.asset(
                  Images.placeholder,
                  fit: BoxFit.fill,
                ),
                placeholder: (context, url) => Image.asset(
                  Images.placeholder,
                  fit: BoxFit.fill,
                ),
                imageUrl:
                '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}'
                    '/${category.icon}',
              ),
            ),
          ),
        ),
        Flexible( // Wrap the Text widget with a Flexible widget
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            // Apply the text scale factor to the font size
            style: titilliumRegular.copyWith(
              fontSize: Dimensions.FONT_SIZE_SMALL ,
              color: ColorResources.getTextTitle(context),
            ),
          ),
        ),
      ],
    );
  }
}
