import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/featured_product_view.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/products_view_1.dart';
import '../../../../helper/product_type.dart';

import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/product_provider.dart';
import '../home/widget/home_products_view.dart';
import '../home/widget/new_home_products_view.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductType productType;
  AllProductScreen({@required this.productType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ?
        Colors.black : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,
            color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            productType == ProductType.FEATURED_PRODUCT ?
        getTranslated("Featured_Product", context):
        //     getTranslated("Latest_Product", context),
            getTranslated(Provider.of<ProductProvider>(context).get_list_type(productType).title, context),
            style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only( top: Dimensions.PADDING_SIZE_SMALL),
                  child:
                  productType == ProductType.FEATURED_PRODUCT?
                  // FeaturedProductView(isHome: false , scrollController: _scrollController):
               ProductView2(isHomePage: false , productType: productType,scrollController: _scrollController):
                  productType == ProductType.NEW_ARRIVAL?
                  ProductView1(isHomePage: false , productType: productType, scrollController: _scrollController):
                  productType == ProductType.DISCOUNTED_PRODUCT?
                  HomeProductView(
                      isHomePage: false,
                      productType: productType,
                      scrollController: _scrollController):



                  HomeProductView(
                      isHomePage: false,
                      productType: productType,
                      scrollController: _scrollController),
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AllProductScreenNew extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductType productType;
  AllProductScreenNew({@required this.productType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ?
        Colors.black : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,
            color: ColorResources.WHITE),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(productType == ProductType.FEATURED_PRODUCT ?
        'Featured Product':'Latest Product',
            style: titilliumRegular.copyWith(fontSize: 20, color: ColorResources.WHITE)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: CustomScrollView(

            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(

                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: productType == ProductType.NEW_ARRIVAL? ProductView1(isHomePage: false , productType: productType, scrollController: _scrollController):       HomeProductView(
                      isHomePage: false,
                      productType: productType,
                      scrollController: _scrollController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
