import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import '../../../../data/model/response/category.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import 'package:provider/provider.dart';

class MainCategoryWidget extends StatelessWidget {
  final Category category;
  final double height ;
  final double width;
  final int index;
  const MainCategoryWidget({Key key,this.index=1, @required this.category , this.height=70, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return index ==1? Column(
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
          margin: const EdgeInsets.only(right: 0.0, left: 10.0),
          child: ClipRRect(

            borderRadius: BorderRadius.circular(10),
            child: Container(

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
    ):SizedBox();
  }
}