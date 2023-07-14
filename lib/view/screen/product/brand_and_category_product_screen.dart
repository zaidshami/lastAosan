import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_overlay_pro/animations/bouncing_line.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/category.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/notification_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/get_loading.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/product_shimmer.dart';
import '../../basewidget/product_widget.dart';
import '../../basewidget/product_widget_new.dart';
import '../home/widget/home_products_view.dart';
import '../notification/notification_screen.dart';
import '../search/search_screen.dart';
import '../search/widget/search_filter_bottom_sheet.dart';
import '../search/widget/search_sortby_bottom_sheet.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  String id;
  final String name;
  final String image;
  final List<SubSubCategory> subSubCategory;
  final bool isBacButtonExist;
  final bool isDiscounted;

  BrandAndCategoryProductScreen(
      {@required this.isBrand,
      @required this.id,
      @required this.name,
      this.image,
      this.subSubCategory,
        this.isBacButtonExist = true,
      this.isDiscounted=false});

  @override
  State<BrandAndCategoryProductScreen> createState() =>
      _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState
    extends State<BrandAndCategoryProductScreen> {
  final ScrollController _scrollController = ScrollController();
  int offset = 1;

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false)
        .initBrandOrCategoryProductList(
            widget.isBrand, widget.id, context, offset,
            reload: true);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController?.addListener(() {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          // offset = Provider.of<ProductProvider>(context, listen: false).cOffset;
          offset++;
          Provider.of<ProductProvider>(context, listen: false).setcatsloading();
          Provider.of<ProductProvider>(context, listen: false)
              .initBrandOrCategoryProductList(
                  widget.isBrand, widget.id, context, offset,
                  reload: false);
          print('the ppp is ' + widget.id);
          //  print('the ppppp is ' +  Provider.of<ProductProvider>(context, listen: false).brandOrCategoryProductList.length.toString());
          print('the sssss is ' +
              Provider.of<ProductProvider>(context, listen: false)
                  .hasData
                  .toString());
        }
      });
    });


  }


  @override
  // void dispose() {
  //   Provider.of<ProductProvider>(context,listen: false).selectedSub = null ;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var ourList;

    Provider.of<ProductProvider>(context, listen: false).selectedSub = null;
    widget.isDiscounted? ourList = Provider.of<ProductProvider>(context, listen: false).brandOrCategoryProductListWith50Disc :
    ourList = Provider.of<ProductProvider>(context).brandOrCategoryProductList;

    return  MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Scaffold(
        appBar:     defaultTargetPlatform == TargetPlatform.android?
        PreferredSize(
            // CustomAppBarIos
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.055),
          child:SizedBox(height: 40,)
        ):
        PreferredSize(
          // CustomAppBarIos
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.055),
            child:Container(height: MediaQuery.of(context).size.height*0.055/1.1 ))
     ,
       /* bottomNavigationBar: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              return Provider.of<ProductProvider>(context, listen: false)
                  .iscOLoading
                  ? Container(
                  width: 40,
                  height: 20,
                  color: Colors.transparent,
                  child: Center(
                      child:
                      getloading(context, productProvider.iscOLoading)))
                  : SizedBox();
            }),*/
        backgroundColor: ColorResources.getIconBg(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                return Column(
                   children: [

                     defaultTargetPlatform == TargetPlatform.android?
                     CustomAppBar(title: widget.name,isBackButtonExist: true )
                     :CustomAppBarIos(title: widget.name,isBackButtonExist: true,),

                     SizedBox(height: 3,),
                  widget.isBrand?SizedBox(): Consumer<ProductProvider>(
                    builder: (context, productProvider, child) =>
                        Column(
                          children: [
                            Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 20,
                      child: widget.subSubCategory != null
                              ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.subSubCategory.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    widget.id = widget
                                        .subSubCategory[index].id
                                        .toString();
                                    productProvider.selectedSub =
                                        index;
                                    offset = 1;
                                    Provider.of<ProductProvider>(
                                        context,
                                        listen: false)
                                        .initBrandOrCategoryProductList(
                                        widget.isBrand,
                                        widget
                                            .subSubCategory[
                                        index]
                                            .id
                                            .toString(),
                                        context,
                                        offset,
                                        reload: true);
                                    print(widget
                                        .subSubCategory[index]
                                        .name);
                                    print(widget.name);
                                    print(widget
                                        .subSubCategory[index].id);
                                    print(widget.id);
                                    print(productProvider
                                        .selectedSub);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        3,
                                    margin: EdgeInsets.only(
                                        right: Dimensions
                                            .PADDING_SIZE_SMALL,
                                        left: Dimensions
                                            .PADDING_SIZE_SMALL),
                                    decoration: BoxDecoration(
                                        color: productProvider
                                            .selectedSub ==
                                            index
                                            ? Colors.black
                                            : Colors.white,
                                        border: Border.all(
                                            color: Colors.grey)),
                                    child: Text(
                                        widget.subSubCategory[index]
                                            .name,
                                        style:
                                        robotoRegular.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: productProvider
                                              .selectedSub ==
                                              index
                                              ? Colors.white
                                              : Colors.black,
                                        )),
                                  ));
                            },
                      )
                              : SizedBox(),
                    ),
                            SizedBox(height: 3,),
                            Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 20,
                      child: widget.subSubCategory != null
                              ?    Expanded(child: InkWell(
                          onTap: (){
                            showModalBottomSheet(context: context,
                                isScrollControlled: true, backgroundColor: Colors.transparent,
                                builder: (c) => SearchFilterBottomSheet());
                          },
                          child: Center(child: _ItemWidget(getTranslated("sort_and_filters",context),Icons.filter_alt))))
                              : SizedBox(),
                    ),
                          ],
                        ),

                  ),


                ]
                );
              },
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    return Column(children: [


                      SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL/2),
                      // Products

                   ourList.length > 0
                          ? Expanded(
                        flex: 15,
                        child:
                        Container(
                          height: MediaQuery.of(context).size.height *0.8,
                          child: StaggeredGridView.countBuilder(
                             // padding: EdgeInsets.symmetric(
                             //     horizontal: 2),

                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount:ourList
                                .length,
                            controller: _scrollController,
                            shrinkWrap: true,
                            staggeredTileBuilder:
                                (int index) =>
                                StaggeredTile.fit(1),
                            itemBuilder:
                                (BuildContext context,
                                int index) {
                              return ProductWidgetNew(
                                  productModel:ourList[
                                  index]);
                            },
                            crossAxisSpacing: 0,
                          ),
                        ),
                      )
                          : Center(
                        child: productProvider.hasData
                            ? ProductShimmer(
                            isHomePage: false,
                            isEnabled: ourList
                                .length ==
                                0)
                            : NoInternetOrDataScreen(
                            isNoInternet: false),
                      ),

                      Provider.of<ProductProvider>(context, listen: false).iscOLoading?
                      Expanded(
                        flex: 1 ,
                        child: Consumer<ProductProvider>(
                            builder: (context, productProvider, child) {
                              return
                                getloading(context,productProvider.iscOLoading);
                            }
                        ),
                      ) : SizedBox(),

                      // Expanded(flex: 1, child: Container())
                    ]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ) ;


  }
}

Widget _ItemWidget(String title, IconData iconData) {
  return Container(
    width: 150,
    child: Row(
      children: [
        Text(
          '${title}',
          style: robotoBold,
        ),
        Icon(iconData)
      ],
    ),
  );
}

