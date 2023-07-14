import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/product_type.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import '../../../../view/basewidget/product_widget.dart';
import 'package:provider/provider.dart';

class LatestProductView extends StatelessWidget {
  final ScrollController scrollController;
  LatestProductView({this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 3;

    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .lProductList
                  .length != 0 &&
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
//TODO
        pageSize =21;
        if (offset < pageSize) {
          offset++;
          // print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();
          Provider.of<ProductProvider>(context, listen: false)
              .getLatestProductList(Provider
              .of<CategoryProvider>(context,listen: false)
              .categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex]
              .id,offset, context);
        }
      }
    });
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.lProductList;

        return Column(children: [
          !prodProvider.firstLoading
              ? productList.length != 0
                  ? SingleChildScrollView(

                      child:  StaggeredGridView.countBuilder(
                        // controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: productList.length,
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1),
                        itemBuilder: (BuildContext context, int index) {
                          return  Consumer<WishListProvider>(
                              builder: (context, value, child) =>
                                  ProductWidget(
                                    productModel: productList[index],

                                  ));



                        },
                      ),
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true, isEnabled: prodProvider.firstLoading),
          prodProvider.isLoading
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



class AllProductView extends StatelessWidget {
  final ProductType productType;
  final ScrollController scrollController;
  AllProductView({this.productType,this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 3;

    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
              .lProductList
              .length != 0 &&
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        int pageSize;
//TODO
        pageSize =21;
        if (offset < pageSize) {
          offset++;
          // print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .showBottomLoader();
          Provider.of<ProductProvider>(context, listen: false)
              .getLatestProductList(Provider
              .of<CategoryProvider>(context,listen: false)
              .categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex]
              .id,offset, context);
        }
      }
    });
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        List<Product> productList;
        productList = prodProvider.get_list_type(productType).ProductList;


        return Column(children: [
          !prodProvider.firstLoading
              ? productList.length != 0
              ? SingleChildScrollView(

            child:  StaggeredGridView.countBuilder(
              // controller: scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: productList.length,
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              crossAxisCount: 2,
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) {
                return  Consumer<WishListProvider>(
                    builder: (context, value, child) =>
                        ProductWidget(
                          productModel: productList[index],

                        ));



              },
            ),
          )
              : SizedBox.shrink()
              : ProductShimmer(
              isHomePage: true, isEnabled: prodProvider.firstLoading),
          prodProvider.isLoading
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
