import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/category.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../provider/banner_provider.dart';
import '../../../../provider/brand_provider.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/top_seller_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/brand_and_category_product_screen.dart';
import '../../../../view/screen/product/product_details_screen.dart';
import '../../../../view/screen/topSeller/top_seller_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/model/response/product_model.dart';
import 'cust_gesture_card_detector.dart';
class BannersView extends StatelessWidget {

  final bool discount;
 final double width ;
  final double height ;
BannersView({this.width,this.height,this.discount =false});
  _clickBannerRedirect(BuildContext context, int id, Product product,  String type){

    final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
    final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);
    final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList.indexWhere((element) => element.id == id);


    if(type == 'category'){
      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name != null){

        Navigator.push(context, CupertinoPageRoute(builder: (_) =>

            BrandAndCategoryProductScreen(
              attribute:    Attribute(
                  id: int.parse(
                      AppConstants.categoryId),
                  name: "",
                  childes: [

                    Child(
                      id:id.toString(),
                      name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',

                    )
                  ]
              ),
              isDiscounted: discount,
          isBrand: false,
          id: id.toString(),
          name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',
        )

        ));
      }

    }

    else if( type == "Subcategory"){

      SubCategory subCategory;
      Provider.of<CategoryProvider>(context, listen: false).categoryList.forEach((element) {
        element.subCategories.forEach((element2) {
          if(element2.id==id){
            subCategory=element2;
            //tt=element2.subSubCategories;
          }
        });
      });

      subCategory!=null?   Navigator.push(context, CupertinoPageRoute(builder: (_) =>
          BrandAndCategoryProductScreen(
              attribute:    Attribute(
                  id: int.parse(
                      AppConstants.categoryId),
                  name: "",
                  childes: [

                    Child(
                      id:id.toString(),
                      name: subCategory.name,

                    )
                  ]
              ),
            isDiscounted: discount,
              isBrand: false,
              subSubCategory:subCategory.subSubCategories,
              id:id.toString(),
              name:subCategory.name
          ),

      )):Navigator.push(context, CupertinoPageRoute(builder: (_) =>
          BrandAndCategoryProductScreen(
            attribute:    Attribute(
                id: int.parse(
                    AppConstants.categoryId),
                name: "",
                childes: [

                  Child(
                    id:id.toString(),
                    name: ' ',

                  )
                ]
            ),
            isDiscounted:discount,
            isBrand: false,
            id:id.toString(),
            name: '',

          ),

      ));


    }

    else if( type == "SubSubcategory"){

      SubSubCategory subCategory;
      Provider.of<CategoryProvider>(context, listen: false).categoryList.forEach((element) {
        element.subCategories.forEach((element2) {

          element2.subSubCategories.forEach((element3) {
            if(element3.id==id){
              subCategory=element3;
            }

          });
        });
      });

      subCategory!=null?   Navigator.push(context, CupertinoPageRoute(builder: (_) =>
          BrandAndCategoryProductScreen(
              attribute:    Attribute(
                  id: int.parse(
                      AppConstants.categoryId),
                  name: "",
                  childes: [

                    Child(
                      id:id.toString(),
                      name: subCategory.name,

                    )
                  ]
              ),
            isDiscounted:discount,
              isBrand: false,
              id:id.toString(),
              name:subCategory.name
          ),

      )):Navigator.push(context, CupertinoPageRoute(builder: (_) =>
          BrandAndCategoryProductScreen(
            attribute:    Attribute(
                id: int.parse(
                    AppConstants.categoryId),
                name: "",
                childes: [

                  Child(
                    id:id.toString(),
                    name:'',

                  )
                ]
            ),
            isDiscounted:discount,
            isBrand: false,
            id:id.toString(),
            name: '',

          ),

      ));


    }

    else if(type == 'product'){
      Navigator.push(context, CupertinoPageRoute(builder: (_) => ProductDetails(
        product: product,
      )));

    }

    else if(type == 'brand'){
      if(Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name != null){
        Navigator.push(context, CupertinoPageRoute(builder: (_) => BrandAndCategoryProductScreen(
          attribute:    Attribute(
              id: int.parse(
                  AppConstants.categoryId),
              name: "",
              childes: [

                Child(
                  id:id.toString(),
                  name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',


                )
              ]
          ),
          isDiscounted:discount,
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
        )));
      }

    }

    else if( type == 'shop'){
      if(Provider.of<TopSellerProvider>(context, listen: false).topSellerList[tIndex].name != null){
        Navigator.push(context, CupertinoPageRoute(builder: (_) => TopSellerProductScreen(

          topSellerId: id,
          topSeller: Provider.of<TopSellerProvider>(context,listen: false).topSellerList[tIndex],
        )));
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, bannerProvider, child) {

            return Container(
              width: width,
              height:height,
              child: bannerProvider.mainBannerList != null ? bannerProvider.mainBannerList.length != 0 ?
              Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      disableCenter: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  autoPlayInterval: Duration(seconds:5),
                      onPageChanged: (index, reason) {
                        Provider.of<BannerProvider>(context, listen: false).setCurrentIndex(index);
                      },
                    ),
                    itemCount: bannerProvider.mainBannerList.length == 0 ? 1 : bannerProvider.mainBannerList.length,
                    itemBuilder: (context, index, _) {

                      return InkWell(
                        onTap: () {
                          // Provider.of<BannerProvider>(context, listen: false).getProductDetails(context, bannerProvider.mainBannerList[index].resourceId.toString());
                          // _clickBannerRedirect(context, bannerProvider.mainBannerList[index].resourceType =='product'? bannerProvider.mainBannerList[index].product.id : bannerProvider.mainBannerList[index].resourceId, bannerProvider.mainBannerList[index].resourceType =='product'? bannerProvider.mainBannerList[index].product : null, bannerProvider.mainBannerList[index].resourceType);
                          _clickBannerRedirect(context,
                              bannerProvider.mainBannerList[index].resourceId,
                              bannerProvider.mainBannerList[index].resourceType =='product'?
                              bannerProvider.mainBannerList[index].product : null,
                              bannerProvider.mainBannerList[index].resourceType);
                        },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:          CachedNetworkImage(
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.fill,
                              ),
                              placeholder: (context, url) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.fill,
                              ),
                              imageUrl:Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl+'/'+bannerProvider.mainBannerList[index].photo,
                            ),

                            ///the old fadin image
                            // FadeInImage.assetNetwork(
                            //  // placeholder: Images.placeholder_3x1, fit: BoxFit.cover,
                            //   image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                            //       '/${bannerProvider.mainBannerList[index].photo}',
                            //   imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_3x1, fit: BoxFit.cover),
                            // ),
                          ),
                        ),
                      );
                    },
                  ),

                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bannerProvider.mainBannerList.map((banner) {
                        int index = bannerProvider.mainBannerList.indexOf(banner);
                        return TabPageSelectorIndicator(
                          backgroundColor: index == bannerProvider.currentIndex ? Theme.of(context).primaryColor : Colors.grey,
                          borderColor: index == bannerProvider.currentIndex ? Theme.of(context).primaryColor : Colors.grey,
                          size: 10,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
                  : Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))):
              Shimmer.fromColors(

                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: bannerProvider.mainBannerList == null,
                child: Container(

                    margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.WHITE,
                )),
              ),
            );
          },
        ),

        SizedBox(height: 5),
      ],
    );
  }


}

