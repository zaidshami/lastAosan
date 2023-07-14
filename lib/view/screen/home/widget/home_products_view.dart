import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/animations/bouncing_line.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../helper/product_type.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import '../../../../view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/get_loading.dart';
import '../../../basewidget/product_widget_new.dart';
import '../../../basewidget/title_row.dart';
import '../../featureddeal/featured_deal_screen.dart';
import '../../product/view_all_product_screen.dart';

class HomeProductView extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  HomeProductView(
      {@required this.isHomePage,
      @required this.productType,
      this.scrollController,
      this.sellerId});
ScrollController newcontroller=new ScrollController();
  @override
  Widget build(BuildContext context) {
    int offset = 1;

    newcontroller?.addListener(() {
      print("phase 1");
      if (newcontroller.position.maxScrollExtent ==
          newcontroller.position.pixels &&
          Provider.of<ProductProvider>(context, listen: false)
                  .get_list_type(productType).ProductList
                  .length !=
              0 &&
          !Provider.of<ProductProvider>(context, listen: false)
              .get_list_type(productType).filterIsLoading) {
        print("phase 2");

        int pageSize;

          pageSize = (Provider.of<ProductProvider>(context, listen: false)
                      .get_list_type(productType).latestPageSize /
                  10)
              .ceil();
          offset = Provider.of<ProductProvider>(context, listen: false)
              .get_list_type(productType).lOffset;
       // }
        if (offset < pageSize) {
          print("phase 3");

          print('offset =====>$offset and page sige ====>$pageSize');
          offset++;

          print('end of the page');
          Provider.of<ProductProvider>(context, listen: false)
              .HomeshowBottomLoader(productType);

          Provider.of<ProductProvider>(context, listen: false)
              .getHomeProductList(productType, Provider
              .of<CategoryProvider>(context,listen: false)
              .categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex].id, offset, context);

         // }
        } else {}
      }
    });

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor:AppConstants.textScaleFactior),
      child: Consumer<ProductProvider>(
        builder: (context, prodProvider, child) {
          print("length ${ prodProvider.get_list_type(productType).ProductList.length}");
          List<Product> productList = [];
          productList = prodProvider.get_list_type(productType).ProductList;

          return productList.length>0?Column(

            children: [
              isHomePage? Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_SMALL),
                child: TitleRow(
                    title: getTranslated(
                        prodProvider.get_list_type(productType).title, context),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => AllProductScreen(
                                  productType:productType)));
                    }),
              ):SizedBox(),
              isHomePage?
              Container(
                height:   (
                    MediaQuery.of(context).size.width<500 ?
                    MediaQuery.of(context).size.width*0.80 :MediaQuery.of(context).size.width*0.75),
                width:((MediaQuery.of(context).size.width/2 )*productList.length),

                child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: newcontroller,

                    children: [

                      ! prodProvider.get_list_type(productType).filterFirstLoading
                          ? productList.length != 0
                          ? Container(
                        height:   (
                            MediaQuery.of(context).size.width<500 ?
                            MediaQuery.of(context).size.width*0.80 :MediaQuery.of(context).size.width*0.75),
                        width:((MediaQuery.of(context).size.width / 2)+5)*productList.length,
                        child:ListView.builder(

                          itemCount: productList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height:   (
                                    MediaQuery.of(context).size.width<500 ?
                                    MediaQuery.of(context).size.width*0.80 :MediaQuery.of(context).size.width*0.75),
                                margin: EdgeInsets.only(left: 3),
                                width: MediaQuery.of(context).size.width / 2,
                                child: ProductWidgetNew(productModel: productList[index]));
                          },
                        ),

                      )


                          : SizedBox.shrink()
                          : ProductShimmer(
                          isHomePage: isHomePage, isEnabled: prodProvider.firstLoading),
                      getloading(context,prodProvider.get_list_type(productType).filterIsLoading)
                      ,
                    ]),
              ):

              Container(
                height: MediaQuery.of(context).size.height,

                child: ListView(
                  controller: newcontroller,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height/1.7)*(productList.length/2),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),

                        itemCount:  productList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return productType==ProductType.DISCOUNTED_PRODUCT? Container(

                              margin: EdgeInsets.only(left: 3),
                              width: MediaQuery.of(context).size.width / 2,
                              child: ProductWidgetNew(productModel: productList[index])): Container(

                              margin: EdgeInsets.only(left: 3),
                              width: MediaQuery.of(context).size.width / 2,
                              child: ProductWidgetNew(productModel: productList[index]));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:     MediaQuery.of(context).size.width<500 ?(1 / 1.6) :(1 / 1.5) ,
                        ),),
                    ),
                    getloading(context,prodProvider.get_list_type(productType).filterIsLoading)

                  ],
                ),
              ),
            ],
          ):SizedBox();
        },
      ),
    );
  }

}









