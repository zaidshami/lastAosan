


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/model/response/category.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../provider/banner_provider.dart';
import '../../../../provider/brand_provider.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/top_seller_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../basewidget/get_loading.dart';
import '../../product/brand_and_category_product_screen.dart';
import '../../product/product_details_screen.dart';
import '../../topSeller/top_seller_product_screen.dart';

class SecondSectionBannersView extends StatelessWidget {
  final int index;

  const SecondSectionBannersView({Key key, this.index}) : super(key: key);

  _clickBannerRedirect(BuildContext context, int id, Product product,  String type){

    final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
    final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);
    final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList.indexWhere((element) => element.id == id);


    if(type == 'category'){
      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name != null){
        Navigator.push(context, CupertinoPageRoute(builder: (_) => BrandAndCategoryProductScreen(
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
          isBrand: false,
          id: id.toString(),
          name: '${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}',
        )));
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
                        name:subCategory.name


                    )
                  ]
              ),
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
                    name: '',


                  )
                ]
            ),
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
                        name:subCategory.name


                    )
                  ]
              ),
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
                      name:''


                  )
                ]
            ),
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
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
        )));
      }

    }else if( type == 'shop'){
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
    return Consumer<BannerProvider>(
      builder: (context, footerBannerProvider, child) {

        return footerBannerProvider.secondSectionBannerList != null ? footerBannerProvider.secondSectionBannerList.length != 0 ?
          InkWell(
          onTap: () {
            _clickBannerRedirect(context,
                footerBannerProvider.secondSectionBannerList[index].resourceId,
                footerBannerProvider.secondSectionBannerList[index].resourceType =='product'?
                footerBannerProvider.secondSectionBannerList[index].product : null,
                footerBannerProvider.secondSectionBannerList[index].resourceType);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ClipRRect(
                //borderRadius: BorderRadius.all(Radius.circular(5)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder_3x1, fit: BoxFit.cover,
                  image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                      '/${footerBannerProvider.secondSectionBannerList[index].photo}',
                  imageErrorBuilder: (c, o, s) => getloading1(context),
                ),
              ),


            ),
          ),
        )    :
            SizedBox()
      /*  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.5,
          child: Shimmer.fromColors(

            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:true,
            child: Container(

                margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
            )),
          ),
        )*/
            :
       Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.5,
          child: Shimmer.fromColors(

            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:true,
            child: Container(

                margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
            )),
          ),
        )
       // Center(child: getloading1(context,))
      ;

      },
    );
  }


}