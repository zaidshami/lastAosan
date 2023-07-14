import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/product_widget_new.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/product_type.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import '../../../../view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView({@required this.isHomePage,@required this.productType,this.scrollController,this.sellerId});

  @override
  Widget build(BuildContext context) {
    int offset = 1;

    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .latestProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false)
              .filterIsLoading) {
        int pageSize;
        if (productType == ProductType.BEST_SELLING ||
            productType == ProductType.TOP_PRODUCT ||
            productType == ProductType.NEW_ARRIVAL ||
            productType == ProductType.DISCOUNTED_PRODUCT||
        productType == ProductType.ALL_PRODUCT
        ) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false)
                      .latestPageSize /
                  10)
              .ceil();
          offset = Provider.of<ProductProvider>(context, listen: false).lOffset;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false)
                      .sellerPageSize /
                  10)
              .ceil();

          offset =
              Provider.of<ProductProvider>(context, listen: false).sellerOffset;
        }
        if (offset < pageSize) {
          // print('offset =====>$offset and page sige ====>$pageSize');
          offset++;

          // print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();

          if (productType == ProductType.SELLER_PRODUCT) {
            Provider.of<ProductProvider>(context, listen: false)
                .initSellerProductList(sellerId, offset, context);
          } else {
            Provider.of<ProductProvider>(context, listen: false)
                .getLatestProductList(Provider
                .of<CategoryProvider>(context,listen: false)
                .categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex]
                .id,offset, context);
          }
        } else {}
      }
    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList = [];
        if (productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.lProductList;
        } else if (productType == ProductType.FEATURED_PRODUCT) {
          productList = prodProvider.featuredProductList;
        } else if (productType == ProductType.TOP_PRODUCT) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.BEST_SELLING) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.NEW_ARRIVAL) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
          // print(
          //     '==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        }


        // print('========hello hello===>${productList.length}');


        return Column(children: [


          !prodProvider.filterFirstLoading
              ? productList.length != 0
                  ? Container(
            height: MediaQuery.of(context).size.width/1.44,


                    child:ListView.builder(

                        itemCount:
                        // isHomePage
                        //     ? productList.length > 4
                        //         ? 4
                        //         : productList.length
                        //     :
                        productList.length,
                       // crossAxisCount: 1,
                       //    crossAxisSpacing: 0.4,
                       //   mainAxisSpacing: 0.4,
                        //padding: EdgeInsets.only(right:10,left: 10 ),

                       // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      //  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(left: 3),
                              width: MediaQuery.of(context).size.width / 2,
                              child: ProductWidgetNew(productModel: productList[index]));
                        },
                      ),
                  )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: isHomePage, isEnabled: prodProvider.firstLoading),
          prodProvider.filterIsLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}








