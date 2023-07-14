import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/product_widget.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../utill/images.dart';
import '../../data/model/response/product_model.dart';
import '../../helper/product_type.dart';
import '../../localization/language_constrants.dart';
import '../../provider/category_provider.dart';
import '../../provider/product_provider.dart';
import '../../utill/dimensions.dart';
import '../screen/home/widget/home_products_view.dart';
import '../screen/product/view_all_product_screen.dart';
import 'get_loading.dart';

class CustomGrid extends StatefulWidget {
  static const routeName = '/CustomGridPage1';

  @override
  _CustomGridPageState createState() => _CustomGridPageState();
}

class _CustomGridPageState extends State<CustomGrid> {
  /// ------------------------------------
  /// List of images for grid items
  /// ------------------------------------

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    int i =  1 ;
    /// ------------------------------------
    /// Build main content with safe area widget
    /// ------------------------------------
    return
    i == 0 ? Column(children: [



      // CartProductView(
      //
      //     isHomePage: true,
      //     productType: ProductType.NEW_ARRIVAL,
      //     scrollController: _scrollController),
      // SizedBox(height: Dimensions.HOME_PAGE_PADDING),
      // // CartProductView(
      //     isHomePage: true,
      //     productType: ProductType.DISCOUNTED_PRODUCT,
      //     scrollController: _scrollController),
      // SizedBox(height: Dimensions.HOME_PAGE_PADDING),
      // CartProductView(
      //     isHomePage: true,
      //     productType: ProductType.BEST_SELLING,
      //     scrollController: _scrollController)
      //
      //
      //
      // ,
      // SizedBox(height: Dimensions.HOME_PAGE_PADDING),
      // CartProductView(
      //     isHomePage: true,
      //     productType: ProductType.TOP_PRODUCT,
      //     scrollController: _scrollController),
      // SizedBox(height: Dimensions.HOME_PAGE_PADDING),
      //


    ],):   Container(

        decoration: BoxDecoration(
          /// ------------------------------------
          /// Decoration Image background
          /// ------------------------------------

        ),

        /// ------------------------------------
        /// Main content StaggeredGridView.count with help of StaggeredGridView library
        /// ------------------------------------
        child: new StaggeredGridView.countBuilder(
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          itemCount:15,
          itemBuilder: (context, index) => imageList[1],
          staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
        ),
      );

  }
}




class CartProductView extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController scrollController;
  final String sellerId;
  CartProductView(
      {@required this.isHomePage,
        @required this.productType,
        this.scrollController,
        this.sellerId});
  ScrollController newcontroller=new ScrollController();
  @override
  Widget build(BuildContext context) {
    int offset = 2;

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
              .categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex].id,
              offset, context);

          // }
        } else {}
      }
    });

    return Consumer<ProductProvider>(
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
            isHomePage?Container(
              height: MediaQuery.of(context).size.height/1.9,
              width:((MediaQuery.of(context).size.width/2 )*productList.length),

              child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: newcontroller,

                  children: [

                    ! prodProvider.get_list_type(productType).filterFirstLoading
                        ? productList.length != 0
                        ? Container(
                      height: MediaQuery.of(context).size.height/1.9,
                      width:((MediaQuery.of(context).size.width / 2)+5)*productList.length,
                      child:ListView.builder(
                        itemCount: productList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(left: 3),
                              width: MediaQuery.of(context).size.width / 2,
                              child: ProductWidget(productModel: productList[index]));
                        },
                      ),

                    )


                        : SizedBox.shrink()
                        : ProductShimmer(
                        isHomePage: isHomePage, isEnabled: prodProvider.firstLoading),
                    getloading(context,prodProvider.get_list_type(productType).filterIsLoading)
                    ,
                  ]),
            ):Container(
              height: MediaQuery.of(context).size.height,

              child: ListView(
                controller: newcontroller,

                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height/1.9)*(productList.length/2),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),

                      itemCount:  productList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(left: 3),
                            width: MediaQuery.of(context).size.width / 2,
                            child: ProductWidget(productModel: productList[index]));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 2.2),
                      ),),
                  ),
                  getloading(context,prodProvider.get_list_type(productType).filterIsLoading)

                ],
              ),
            ),
          ],
        ):SizedBox();
      },
    );
  }

}

/// ------------------------------------
/// _Tile widget for expressing image content grid
/// ------------------------------------
class _Tile extends StatelessWidget {
  _Tile({ this.index,  this.image});

  final int index;
  final String image;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              Card(
                elevation: 8,
                child: Center(
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/banr2.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<_Tile> imageList = [
  new _Tile(
    image:Images.empty_cart,
    index: 1,
  ),
  new _Tile(
    image:Images.empty_cart,
    index: 2,
  ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 3,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 4,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 5,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 6,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 7,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 8,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 9,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 10,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 11,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 12,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 13,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 14,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 15,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 16,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 17,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 18,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 19,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 20,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 21,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 22,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 23,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 24,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 25,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 26,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 27,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 28,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 29,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 30,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 31,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 32,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 33,
  // ),
  // new _Tile(
  //   image:Images.banr2,
  //   index: 34,
  // ),
];
