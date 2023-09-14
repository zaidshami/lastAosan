import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/app_constants.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/search_widget.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../data/model/response/filter_category_1.dart';
import '../../../provider/attributes_provider.dart';
import '../../../provider/brand_provider.dart';
import '../../../provider/category_provider.dart';

class SearchScreen extends StatefulWidget {
  Attribute searchAttribute;
  SearchScreen({this.searchAttribute});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context,listen: false).clearFilters();

      Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
      Provider.of<SearchProvider>(context, listen: false).initHistoryList();
/*      Provider.of<SearchProvider>(context, listen: false).init_lists(
        Provider.of<CategoryProvider>(context, listen: false)
            .searchcategoryList,
        Provider.of<BrandProvider>(context, listen: false).searchbrandList,
      );*/
    });
  }
  @override
  // void dispose (){
  //   Provider.of<SearchProvider>(context,listen: false).searchController.text = null;
  //   Provider.of<SearchProvider>(context,listen: false).searchText= null ;
  // }

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
                  boxShadow: [

                  ],
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
                        child: Consumer<AttributeProvider>(
                          builder: (context, provider, child) =>
                          SecondSearchWidget(

                            hintText: getTranslated('SEARCH_HINT', context),
                            onTap:  ()  {
                              String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

                              if (seearchText == null || seearchText.isEmpty) {
                                Fluttertoast.showToast(
                                    msg:
                                    'يرجى ادخال نص للبحث ',
                                    toastLength: Toast
                                        .LENGTH_SHORT,
                                    gravity:
                                    ToastGravity
                                        .BOTTOM,
                                    timeInSecForIosWeb:
                                    1,
                                    backgroundColor:
                                    Colors.red,
                                    textColor:
                                    Colors.white,
                                    fontSize: 16.0);
                              }
                              else {
                                provider.attributes.clear();
                                   provider.fetchCategoryFilterListCatNew(seearchText,'177');
                                Provider.of<SearchProvider>(context, listen: false).saveSearchAddress( Provider.of<SearchProvider>(context, listen: false).searchController.text.toString());

                                Provider.of<SearchProvider>(context, listen: false).search(context);

                                // Provider.of<AttributeProvider>(context, listen: false).initialized= false;
                                Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter=false;

                                // await   Provider.of<AttributeProvider>(context, listen: false).initializeData('176');

                                // Provider.of<SearchProvider>(context, listen: false)
                                //     .searchProduct(text, context,reload: true);
                                // Provider.of<SearchProvider>(context, listen: false)
                                //     .saveSearchAddress(text);
                              }





                            },
                            onSubmit: (String text) async {

                              String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

                              if (seearchText == null || seearchText.isEmpty) {
                                Fluttertoast.showToast(
                                    msg:
                                    'يرجى ادخال نص للبحث ',
                                    toastLength: Toast
                                        .LENGTH_SHORT,
                                    gravity:
                                    ToastGravity
                                        .BOTTOM,
                                    timeInSecForIosWeb:
                                    1,
                                    backgroundColor:
                                    Colors.red,
                                    textColor:
                                    Colors.white,
                                    fontSize: 16.0);
                              }
                              else {
                                Provider.of<AttributeProvider>(context, listen: false).attributes.clear();
                                   Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,'177');
                                Provider.of<SearchProvider>(context, listen: false).saveSearchAddress( Provider.of<SearchProvider>(context, listen: false).searchController.text.toString());
                                Provider.of<SearchProvider>(context, listen: false).filterIndex= 1 ;
                                Provider.of<SearchProvider>(context, listen: false).search(context,reload: true);

                                // Provider.of<AttributeProvider>(context, listen: false).initialized= false;
                                Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter=false;

                                // await   Provider.of<AttributeProvider>(context, listen: false).initializeData('176');

                                // Provider.of<SearchProvider>(context, listen: false)
                                //     .searchProduct(text, context,reload: true);
                                // Provider.of<SearchProvider>(context, listen: false)
                                //     .saveSearchAddress(text);
                              }




                            },

                            onClearPressed: () async {
                              Provider.of<SearchProvider>(context, listen: false).clearFilters();
                              await Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
                            },
                          ),
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
              Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  return !searchProvider.isClear
                      ? searchProvider.isLoading&&searchProvider.searchProductList.isEmpty
                      ? Expanded(
                    child: ProductShimmer(
                      isHomePage: false,
                      isEnabled: Provider.of<SearchProvider>(context)
                          .searchProductList ==
                          null,
                    ),
                  )
                      : searchProvider.searchProductList == null? getloading4(context):
                  searchProvider.searchProductList.isEmpty
                      ? Expanded(
                    child: NoInternetOrDataScreen(
                        isNoInternet: false),
                  )
                      : Expanded(
                    child: SearchProductWidget(
                       searchAttribute: widget.searchAttribute,
                      products: searchProvider.searchProductList,
                      isViewScrollable: true,
                    ),
                  )

                      :
                  /*Expanded(
                      flex: 4,
                      child:
                      NewProductAttributeList(widget.searchAttribute))*/
                  ///HISTORY WIDGET
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
                                          onTap: () {
                                            searchProvider.searchController.text = searchProvider.historyList[index];
                                            String seearchText = searchProvider.searchController.text;

                                            if (seearchText == null || seearchText.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  'يرجى ادخال نص للبحث ',
                                                  toastLength: Toast
                                                      .LENGTH_SHORT,
                                                  gravity:
                                                  ToastGravity
                                                      .BOTTOM,
                                                  timeInSecForIosWeb:
                                                  1,
                                                  backgroundColor:
                                                  Colors.red,
                                                  textColor:
                                                  Colors.white,
                                                  fontSize: 16.0);
                                            }
                                            else {

                                              Provider.of<AttributeProvider>(context, listen: false).attributes.clear();
                                              Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,'177');
                                              searchProvider.saveSearchAddress( Provider.of<SearchProvider>(context, listen: false).searchController.text.toString());
                                              searchProvider.filterIndex= 1 ;
                                              searchProvider.search(context,reload: true);

                                              Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter=false;


                                            }


},
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
                                                      .removeSearchHistoryIndex(index),
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
                        )
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
