import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/category.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../provider/banner_provider.dart';
import '../../../../provider/brand_provider.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/top_seller_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/images.dart';
import '../../../../view/screen/product/brand_and_category_product_screen.dart';
import '../../../../view/screen/product/product_details_screen.dart';
import '../../../../view/screen/topSeller/top_seller_product_screen.dart';
import 'package:provider/provider.dart';
class FooterBannersView extends StatelessWidget {
  final int index;

  const FooterBannersView({Key key, this.index}) : super(key: key);

  _clickBannerRedirect(BuildContext context, int id, Product product,  String type){

    final cIndex = Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
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
                         name: "${Provider.of<CategoryProvider>(context, listen: false).categoryList[cIndex].name}",
        )
                  ]
              ),
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
                        name: "${subCategory.name}",
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
                      name: " ",
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
                        name: "${subCategory.name}",
                      )
                    ]
                ),
              isBrand: false,
              id:id.toString(),
              name:subCategory.name
            ),

        )):Navigator.push(context, CupertinoPageRoute(builder: (_) =>
            BrandAndCategoryProductScreen(
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
          isBrand: true,
          id: id.toString(),
          name: '${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}',
          attribute:    Attribute(
              id: int.parse(
                  AppConstants.categoryId),
              name: "",
              childes: [

                Child(
                  id:id.toString(),
                  name: "${Provider.of<BrandProvider>(context, listen: false).brandList[bIndex].name}",
                )
              ]
          ),
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
    builder: (context, footerBannerProvider, child) {

      return InkWell(
        onTap: () {

          _clickBannerRedirect(context,
              footerBannerProvider.footerBannerList[index].resourceId,
              footerBannerProvider.footerBannerList[index].resourceType =='product'? footerBannerProvider.footerBannerList[index].product : null,
              footerBannerProvider.footerBannerList[index].resourceType);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2.2,
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              //borderRadius: BorderRadius.all(Radius.circular(5)),
              child:  CachedNetworkImage(
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Image.asset(
                    Images.placeholder_3x1,
                    fit: BoxFit.cover,
                  ),
                  placeholder: (context, url) => Image.asset(
                    Images.placeholder_3x1,
                    fit: BoxFit.cover,
                  ),
                  imageUrl:
                  '${Provider.of<SplashProvider>(context,listen: false).baseUrls.bannerImageUrl}'
                      '/${footerBannerProvider.footerBannerList[index].photo}'                ),


            ),


          ),
        ),
      );

    },
    ),
      ],
    );
  }


}




