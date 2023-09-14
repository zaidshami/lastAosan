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

class AttributeWidget extends StatelessWidget {
  final Child attribute;
  final double height ;
  final double width;
  const AttributeWidget({Key key, @required this.attribute , this.height=70, this.width= 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(

          padding: getPadding(bottom: 3),
          height: height,
          width: width,
          margin: const EdgeInsets.only(right: 10.0, left: 10.0),
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
                imageUrl:''
                // '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${attribute.icon}',
              ),
            ),
          ),
        ),
        Flexible( // Wrap the Text widget with a Flexible widget
          child: Text(
            attribute.name,
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
        Flexible( // Wrap the Text widget with a Flexible widget
          child: Text(
         "   attribute.icon,",
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