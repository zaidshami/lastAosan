import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/app_constants.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/search_widget.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_product_widget.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/BrandItemWidget.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/CategoryItemWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../data/model/SearchListModels/SearchListModel.dart';
import '../../../provider/brand_provider.dart';
import '../../../provider/category_provider.dart';
import '../../basewidget/attributes_filter_category.dart';
import '../../basewidget/product_attributes_filter_category.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
      Provider.of<SearchProvider>(context, listen: false).initHistoryList();
      Provider.of<SearchProvider>(context, listen: false).init_lists(
        Provider.of<CategoryProvider>(context, listen: false)
            .searchcategoryList,
        Provider.of<BrandProvider>(context, listen: false).searchbrandList,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      resizeToAvoidBottomInset: true,
      body: Builder(
        builder: (context) {
          Widget body = Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  boxShadow: [],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: SearchWidget(
                          hintText: getTranslated('SEARCH_HINT', context),
                          onSubmit: (String text) {
                            Provider.of<SearchProvider>(context, listen: false)
                                .searchProduct(text, context,reload: true);
                            Provider.of<SearchProvider>(context, listen: false)
                                .saveSearchAddress(text);
                          },
                          onClearPressed: () async =>
                              await Provider.of<SearchProvider>(context,
                                      listen: false)
                                  .cleanSearchProduct(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              // CategoryItemWidget("الاقسام",
              //     context.watch<SearchProvider>().category_search_list),
              // SizedBox(height: 10,),
              // BrandItemWidget("الماركات", context.watch<SearchProvider>().brand_search_list),
              // SizedBox(height: 10,),
  /*            Expanded(

                  child: AttributeList()),*/


              Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  return !searchProvider.isClear
                      ? searchProvider.searchProductList == null
                          ? Expanded(
                              child: ProductShimmer(
                                isHomePage: false,
                                isEnabled: Provider.of<SearchProvider>(context)
                                        .searchProductList ==
                                    null,
                              ),
                            )
                          : searchProvider.searchProductList.isEmpty
                              ? Expanded(
                                  child: NoInternetOrDataScreen(
                                      isNoInternet: false),
                                )
                              : Expanded(
                                  child: SearchProductWidget(
                                    products: searchProvider.searchProductList,
                                    isViewScrollable: true,
                                  ),
                                )

                      :
                  Expanded(
flex: 4,
                      child:
                      NewProductAttributeList())
                  ///HISTORY WIDGET
/*
                  Expanded(
                          flex: 4,
                          child: Container(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getTranslated(
                                                'SEARCH_HISTORY', context),
                                            style: robotoBold,
                                          ),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () => searchProvider
                                                .clearSearchAddress(),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_DEFAULT,
                                                vertical: Dimensions
                                                    .PADDING_SIZE_LARGE,
                                              ),
                                              child: Text(
                                                getTranslated(
                                                    'REMOVE_All', context),
                                                style:
                                                    titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: StaggeredGridView.countBuilder(
                                        crossAxisCount: 2,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemCount:
                                            searchProvider.historyList.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () =>
                                              Provider.of<SearchProvider>(
                                                      context,
                                                      listen: false)
                                                  .searchProduct(
                                                      searchProvider
                                                          .historyList[index],
                                                      context),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color:
                                                        ColorResources.getGrey(
                                                            context),
                                                  ),
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: Text(
                                                      Provider.of<SearchProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .historyList[index] ??
                                                          "",
                                                      style: titilliumItalic
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: InkWell(
                                                  onTap: () => Provider.of<
                                                              SearchProvider>(
                                                          context,
                                                          listen: false)
                                                      .deleteFromHistory(index),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: ColorResources
                                                          .getGrey(context),
                                                    ),
                                                    child: Icon(Icons.close),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        staggeredTileBuilder: (int index) =>
                                            new StaggeredTile.fit(1),
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )*/
                  ;
                },
              )
            ],
          );

          // Conditionally add SafeArea based on platform (iOS or Android)
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            return Padding(
              padding: getPadding(top: 50, right: 20),
              child: body,
            );
          } else {
            return SafeArea(
              child: Padding(
                padding: getPadding(right: 15),
                child: body,
              ),
            );
          }
        },
      ),
    );
  }
}
