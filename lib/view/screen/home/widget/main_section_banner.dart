import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
class MainSectionBannersView extends StatelessWidget {
  final int index;
  const MainSectionBannersView({Key key, this.index}) : super(key: key);

  _clickBannerRedirect(BuildContext context, int id, Product product,  String type){

    final cIndex =  Provider.of<CategoryProvider>(context, listen: false).categoryList.indexWhere((element) => element.id == id);
    final bIndex =  Provider.of<BrandProvider>(context, listen: false).brandList.indexWhere((element) => element.id == id);
    final tIndex =  Provider.of<TopSellerProvider>(context, listen: false).topSellerList.indexWhere((element) => element.id == id);


    if(type == 'category')

    {
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
      if(Provider.of<CategoryProvider>(context, listen: false).categoryList[Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex].subCategories[index].name != null){
        Navigator.push(context, CupertinoPageRoute(builder: (_) =>
            BrandAndCategoryProductScreen(
              attribute:    Attribute(
                  id: int.parse(
                      AppConstants.categoryId),
                  name: "",
                  childes: [

                    Child(
                      id:  Provider.of<BannerProvider>(context, listen: false).footerBannerList[index].resourceId.toString(),

                      name: Provider.of<CategoryProvider>(context, listen: false).categoryList[ Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex].subCategories[index].name,


                    )
                  ]
              ),
              isBrand: false,
              subSubCategory:Provider.of<CategoryProvider>(context, listen: false).categoryList[Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex].subCategories[index].subSubCategories,
              id:  Provider.of<BannerProvider>(context, listen: false).footerBannerList[index].resourceId.toString(),
              name:
              Provider.of<CategoryProvider>(context, listen: false).categoryList[ Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex].subCategories[index].name,
            ),

        ));
      }

    }
    else if(type == 'product'){
      Navigator.push(context, CupertinoPageRoute(builder: (_) => ProductDetails(
        product: product,
      )));

    }else if(type == 'brand'){
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
    return Column(
      children: [
        Consumer<BannerProvider>(
          builder: (context, footerBannerProvider, child) {

            return InkWell(
              onTap: () {
                _clickBannerRedirect(context,
                    footerBannerProvider.mainSectionBannerList[index].resourceId,
                    footerBannerProvider.mainSectionBannerList[index].resourceType =='product'?
                    footerBannerProvider.mainSectionBannerList[index].product : null,
                    footerBannerProvider.mainSectionBannerList[index].resourceType);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/4.1,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
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
                          '/${footerBannerProvider.mainSectionBannerList[index].photo}'                    ),


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




