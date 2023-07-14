import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/product_type.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../basewidget/get_loading.dart';
import '../../../basewidget/product_widget.dart';
import '../../../basewidget/product_widget_new.dart';

class ProductView1 extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView1({@required this.isHomePage, @required this.productType, this.scrollController, this.sellerId});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels
          && Provider.of<ProductProvider>(context, listen: false).latestProductList.length != 0
          && !Provider.of<ProductProvider>(context, listen: false).filterIsLoading) {
        int pageSize;
        if(productType == ProductType.BEST_SELLING || productType == ProductType.TOP_PRODUCT || productType == ProductType.NEW_ARRIVAL) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false).latestPageSize/10).ceil();
          offset = Provider.of<ProductProvider>(context, listen: false).lOffset;
        }

        else if(productType == ProductType.SELLER_PRODUCT) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false).sellerPageSize/10).ceil();
          offset = Provider.of<ProductProvider>(context, listen: false).sellerOffset;
        }
        if(offset < pageSize) {
          print('offset =====>$offset and page sige ====>$pageSize');
          offset++;

          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false).showBottomLoader();


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

        }else{

        }
      }

    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList = [];
        if(productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.lProductList;
        }
        else if(productType == ProductType.FEATURED_PRODUCT) {
          productList = prodProvider.featuredProductList;
        }else if(productType == ProductType.TOP_PRODUCT) {
          productList = prodProvider.latestProductList;
        }else if(productType == ProductType.BEST_SELLING) {
          productList = prodProvider.latestProductList;
        }else if(productType == ProductType.NEW_ARRIVAL) {
          productList = prodProvider.latestProductList;
        }

        else if(productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
          print('==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        }else if (productType == ProductType.ALL_PRODUCT) {
          productList =  prodProvider.brandOrCategoryProductList ;
          // print(
          //     '==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        }

        // print('========hello hello===>${productList.length}');

        return Column(children: [


          !prodProvider.filterFirstLoading ? productList.length != 0 ?
          StaggeredGridView.countBuilder(
            itemCount: isHomePage? productList.length>40?
            40:productList.length:productList.length,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            crossAxisCount: 2,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              return    Transform.scale(
                  scale: 1,
                  child: ProductWidgetNew(productModel: productList[index]));
            },
          ) : SizedBox.shrink(): ProductShimmer(isHomePage: isHomePage ,isEnabled: prodProvider.firstLoading),

          prodProvider.filterIsLoading ? Center(child: Padding(
            padding: getPadding(bottom: 5),
            child: getloading3(context),
          )) : SizedBox.shrink(),

        ]);
      },
    );
  }
}

class ProductView2 extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  ProductView2({@required this.isHomePage, @required this.productType, this.scrollController, this.sellerId});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels
          && Provider.of<ProductProvider>(context, listen: false).featuredProductList.length != 0
          && !Provider.of<ProductProvider>(context, listen: false).filterIsLoading) {
        int pageSize;
        if(productType == ProductType.BEST_SELLING || productType == ProductType.TOP_PRODUCT || productType == ProductType.FEATURED_PRODUCT) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false).featuredPageSize/10).ceil();
          offset = Provider.of<ProductProvider>(context, listen: false).lOffset;
        }

        else if(productType == ProductType.SELLER_PRODUCT) {
          pageSize = (Provider.of<ProductProvider>(context, listen: false).sellerPageSize/10).ceil();
          offset = Provider.of<ProductProvider>(context, listen: false).sellerOffset;
        }
        if(offset < pageSize) {
          print('offset =====>$offset and page sige ====>$pageSize');
          offset++;

          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false).showBottomLoader();


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

        }else{

        }
      }

    });

    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList = [];
        if(productType == ProductType.LATEST_PRODUCT) {
          productList = prodProvider.lProductList;
        }
        else if(productType == ProductType.FEATURED_PRODUCT) {
          productList = prodProvider.featuredProductList;
        }else if(productType == ProductType.TOP_PRODUCT) {
          productList = prodProvider.latestProductList;
        }else if(productType == ProductType.BEST_SELLING) {
          productList = prodProvider.latestProductList;
        }else if(productType == ProductType.NEW_ARRIVAL) {
          productList = prodProvider.latestProductList;
        }

        else if(productType == ProductType.SELLER_PRODUCT) {
          productList = prodProvider.sellerProductList;
          print('==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        }else if (productType == ProductType.ALL_PRODUCT) {
          productList =  prodProvider.brandOrCategoryProductList ;
          // print(
          //     '==========>Product List ==${prodProvider.firstLoading}====>${productList.length}');
        }

        // print('========hello hello===>${productList.length}');

        return Column(children: [


          !prodProvider.filterFirstLoading ? productList.length != 0 ?
          StaggeredGridView.countBuilder(
            itemCount: isHomePage? productList.length>40?
            40:productList.length:productList.length,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            crossAxisCount: 2,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              return    Transform.scale(
                  scale: 1,
                  child: ProductWidgetNew(productModel: productList[index]));
            },
          ) : SizedBox.shrink(): ProductShimmer(isHomePage: isHomePage ,isEnabled: prodProvider.firstLoading),

          prodProvider.filterIsLoading ? Center(child: Padding(
            padding: getPadding(bottom: 5),
            child: getloading3(context),
          )) : SizedBox.shrink(),

        ]);
      },
    );
  }
}
