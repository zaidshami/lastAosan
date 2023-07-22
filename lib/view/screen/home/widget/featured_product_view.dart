import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/product_type.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/math_utils.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import '../../../../view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/get_loading.dart';
import '../../../basewidget/product_widget_new.dart';
import '../../../basewidget/title_row.dart';
import '../../product/view_all_product_screen.dart';

class FeaturedProductView extends StatelessWidget {
  final ScrollController scrollController;
  final bool isHome;

  FeaturedProductView({this.scrollController, @required this.isHome});

  @override
  Widget build(BuildContext context) {
    int offset = 1;

    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .featuredProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false)
              .isFeaturedLoading) {
        int pageSize;

        pageSize = Provider.of<ProductProvider>(context, listen: false)
            .featuredPageSize;

        if (offset < pageSize) {
          offset++;

          print('end of the page ${offset}');
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
        productList = prodProvider.featuredProductList;

        return Column(children: [
          !prodProvider.firstFeaturedLoading
              ? productList.length != 0
                  ?
          isHome?
          Column(
            children: [
              Consumer<ProductProvider>(
                  builder: (context, featured, _) {
                    return featured.featuredProductList != null &&
                        featured.featuredProductList.length > 0
                        ? Padding(
                      padding: const EdgeInsets.only(
                        //  left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          left: 15,
                          right: 25,
                          bottom: Dimensions
                              .PADDING_SIZE_EXTRA_SMALL),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom:
                            Dimensions.PADDING_SIZE_SMALL),
                        child: TitleRow(
                            title: getTranslated(
                                'featured_products', context),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) =>
                                          AllProductScreen(
                                              productType:
                                              ProductType
                                                  .FEATURED_PRODUCT)));
                            }),
                      ),
                    )
                        : SizedBox();
                  }),
              Container(
                          height:   isHome?(
        MediaQuery.of(context).size.width<400 ?
                              MediaQuery.of(context).size.width*0.80 :     MediaQuery.of(context).size.width*0.80):MediaQuery.of(context).size.height,
                          child: isHome
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productList.length,
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 3),
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: ProductWidgetNew(
                                            productModel: productList[index]));
                                  })
                              : StaggeredGridView.countBuilder(
                            scrollDirection: Axis.vertical,
                                  itemCount: productList.length,
                                  crossAxisCount: 2,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.fit(1),
                                  itemBuilder: (BuildContext context, int index) {
                                    return ProductWidgetNew(
                                        productModel: productList[index]);
                                  },
                                ),
                        ),
            ],
          ):
          Column(children: [



            StaggeredGridView.countBuilder(
              itemCount: isHome? productList.length>40?
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
            ) ,

            prodProvider.firstFeaturedLoading ? Center(child: Padding(
              padding: getPadding(bottom: 5),
              child: getloading3(context),
            )) : SizedBox.shrink(),

          ])
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true,
                  isEnabled: prodProvider.firstFeaturedLoading),
          prodProvider.firstFeaturedLoading
          //wa au
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
