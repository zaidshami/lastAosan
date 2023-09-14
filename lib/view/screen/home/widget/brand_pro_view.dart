import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../provider/brand_pro_provider.dart';
import '../../../../provider/brand_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BrandProView extends StatelessWidget {
  final bool isHomePage;
  BrandProView({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProProvider>(
      builder: (context, brandProProvider, child) {
        return brandProProvider.brandProList.length != 0 ?
        AppConstants.showBrandPro==true?
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: (1/1.3),
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
          ),
          itemCount: brandProProvider.brandProList.length != 0
              ? isHomePage
              ? brandProProvider.brandProList.length > 8
              ? 8
              : brandProProvider.brandProList.length
              : brandProProvider.brandProList.length
              : 8,
          shrinkWrap: true,
          physics: isHomePage ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {

            return InkWell(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  isBrand: true,
                  id: brandProProvider.brandProList[index].id.toString(),
                  name: brandProProvider.brandProList[index].name,
                  image: brandProProvider.brandProList[index].image,
                )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                      decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 5, spreadRadius: 1)]
                      ),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: Images.placeholder,
                          image: Provider.of<SplashProvider>(context,listen: false).baseUrls.brandImageUrl+'/'+brandProProvider.brandProList[index].image,
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,  fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.width/4) * 0.3,
                    child: Center(child: Text(
                      brandProProvider.brandProList[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                    )),
                  ),
                ],
              ),
            );

          },
        )  :
        ConstrainedBox(
          constraints: brandProProvider.brandProList.length > 0 ? BoxConstraints(maxHeight: 130):BoxConstraints(maxHeight: 0),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandProProvider.brandProList.length,
              itemBuilder: (ctx,index){

                return InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      isBrand: true,
                      id: brandProProvider.brandProList[index].id.toString(),
                      name: brandProProvider.brandProList[index].name,
                      image: brandProProvider.brandProList[index].image,
                    )));
                  },
                  child: Padding(
                    padding:  EdgeInsets.only(right: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: (MediaQuery.of(context).size.width/5.9),
                            height: (MediaQuery.of(context).size.width/5.9),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width/5))),
                              color: Theme.of(context).highlightColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width/5))),
                              child:
                              CachedNetworkImage(
                                errorWidget: (context, url, error) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.cover,
                                ),
                                placeholder: (context, url) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.cover,
                                ),
                                imageUrl:Provider.of<SplashProvider>(context,listen: false).baseUrls.brandImageUrl+'/'+brandProProvider.brandProList[index].image,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.width/4) * 0.3,
                            width: MediaQuery.of(context).size.width/4.2,
                            child: Center(child: Text(
                              brandProProvider.brandProList[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              }),
        ):
        AppConstants.showBrandPro == true ?  BrandShimmer(isHomePage: isHomePage):BrandProListShimmer();



      },
    );
  }
}

class BrandShimmer extends StatelessWidget {
  final bool isHomePage;
  BrandShimmer({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1/1.3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: isHomePage ? 8 : 30,
      shrinkWrap: true,
      physics: isHomePage ? NeverScrollableScrollPhysics() : null,
      itemBuilder: (BuildContext context, int index) {

        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<BrandProProvider>(context).brandProList.length == 0,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(child: Container(decoration: BoxDecoration(color: ColorResources.WHITE, shape: BoxShape.circle))),
            Container(height: 10, color: ColorResources.WHITE, margin: EdgeInsets.only(left: 25, right: 25)),
          ]),
        );

      },
    );
  }
}
class BrandProListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,  // you can change this to fit your needs
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (ctx, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width/5.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width/5.9),
                      height: (MediaQuery.of(context).size.width/5.9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular((MediaQuery.of(context).size.width/5))),
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 2,),
                    SizedBox(
                      height: (MediaQuery.of(context).size.width/4) * 0.2,
                      width: MediaQuery.of(context).size.width/4.2,
                      child: Container(
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


