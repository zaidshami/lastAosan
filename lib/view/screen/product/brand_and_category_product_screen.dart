import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/category.dart';
import '../../../data/model/response/filter_category_1.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/search_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/math_utils.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/get_loading.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/product_shimmer.dart';
import '../../basewidget/product_widget_new.dart';
import '../search/widget/search_filter_bottom_sheet.dart';
import '../search/widget/search_sortby_bottom_sheet.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  String id;
  final String name ;
  final String image ;
  final List<SubSubCategory> subSubCategory ;
  final bool isBacButtonExist ;
  final bool isDiscounted ;
  final Attribute attribute ;
  final bool isFiltering ;

  BrandAndCategoryProductScreen(
      {@required this.isBrand,
        @required this.id,
        @required this.name,
        this.image,
        this.subSubCategory,
        this.isBacButtonExist = true,
        this.isDiscounted=false,
        this.attribute,
       this.isFiltering=false});

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
    String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();
    Provider.of<ProductProvider>(context, listen: false).isFiltring= false;
    Provider.of<ProductProvider>(context,listen: false).selectedSub = null ;
    Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(widget.isBrand, widget.id, context, offset, reload: true);
    Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,widget.id);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController?.addListener(() {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          // offset = Provider.of<ProductProvider>(context, listen: false).cOffset;


          offset++;
          Provider.of<ProductProvider>(context, listen: false).setcatsloading();
          Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter= true;
          Provider.of<ProductProvider>(context, listen: false).isFiltring?   fetchMore():  Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(widget.isBrand, widget.id, context, offset,   reload: false);
          Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(widget.isBrand, widget.id, context, offset,   reload: false);
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
  void fetchMore() {
    Provider.of<SearchProvider>(context, listen: false).fetchMore(context,onNoMoreProducts: showNoMoreProductsSnackbar);
  }
  void showNoMoreProductsSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No more products")),
    );
  }
  @override
  Widget build(BuildContext context) {
    var ourList=Provider.of<ProductProvider>(context).ourList;


    widget.isDiscounted? ourList = Provider.of<ProductProvider>(context, listen: false).brandOrCategoryProductListWith50Disc :
    ourList = Provider.of<ProductProvider>(context).isFiltring? Provider.of<SearchProvider>(context).searchProductList:Provider.of<ProductProvider>(context).brandOrCategoryProductList;

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
                      widget.isBrand?SizedBox():


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
                                return Consumer<ProductProvider>(
                                  builder: (context, productProvider, child) =>
                                      InkWell(
                                          onTap: () {
                                            String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

                                            productProvider.selectedSub =
                                                index;
                                            widget.id = widget
                                                .subSubCategory[index].id
                                                .toString();

                                            offset = 1;

                                            productProvider.isFiltring= false;
                                            productProvider.initBrandOrCategoryProductList(widget.isBrand, widget
                                                .subSubCategory[index].id.toString(), context, offset, reload: true);
                                            // Provider.of<SearchProvider>(context,listen: false).selectAttribute1(widget.id,widget.subSubCategory[index].id.toString());
                                            Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,widget
                                                .subSubCategory[index].id
                                                .toString());
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
                                          )),
                                );
                              },
                            )
                                : SizedBox(),
                          ),
                          SizedBox(height: 3,),

                        ],
                      ),

//
                    ]
                );
              },
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL / 2,
                      ),
                      // Products
                      ourList.length > 0
                          ? Consumer<ProductProvider>(
                        builder: (context, value, child) => Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: StaggeredGridView.countBuilder(
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            itemCount: ourList.length,
                            controller: _scrollController,
                            shrinkWrap: true,
                            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductWidgetNew(productModel: ourList[index]);
                            },
                            crossAxisSpacing: 0,
                          ),
                        ),
                      )
                          : Center(
                        child: productProvider.hasData
                            ? ProductShimmer(
                            isHomePage: false,
                            isEnabled: ourList.length == null)
                            : NoInternetOrDataScreen(isNoInternet: false),
                      ),

                      // Other widgets here

                      Provider.of<ProductProvider>(context, listen: false).iscOLoading
                          ? Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            return getloading(context, productProvider.iscOLoading);
                          },
                        ),
                      )
                          : SizedBox(),

                      Positioned(
                        right: 100,
                        bottom:30,
                        child:
                               Container(
                          padding: getPadding(right: 6,left: 6,top: 7,bottom: 7),
                          decoration: BoxDecoration(
                            color:Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width*0.5,


                          // width: 170,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: InkWell(
                                    onTap: (){

                                      showModalBottomSheet(context: context,
                                          isScrollControlled: true, backgroundColor: Colors.transparent,
                                          builder: (c) => SearchFilterBottomSheet(id: widget.id,isSearch: false,));
                                    },
                                    child: Center(child: _ItemWidget(getTranslated("sort_by",context),Icons.filter_alt)))),

                                // MiddlePageTransition(child: SearchSortByBottomSheet(widget.searchAttribute),),


                                VerticalDivider(thickness: 5,color: Colors.white,),

                                Expanded(

                                    child: InkWell(
                                        onTap: (){


                                          if(                                                Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter)
                                          {
                                            Provider.of<SearchProvider>(context, listen: false).clearFilters();
                                          Provider.of<SearchProvider>(context, listen: false).searchText='';
                                          Provider.of<SearchProvider>(context, listen: false).searchController.text='';}

                                          showModalBottomSheet(context: context,

                                              isScrollControlled: true,

                                              backgroundColor: Colors.white,



                                              builder: (c) => SearchSortByBottomSheet(widget.attribute,widget.id,true));

                                        },
                                        child: Center(child: _ItemWidget(getTranslated("sort_and_filters",context),Icons.sort)))),

                              ],
                            ),
                          ),
                        )

                      ),
                    ],
                  );

                },
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
        Spacer(),
        Text(


          '${title}',
          style: robotoBold.copyWith(color: Colors.white),
        ),
        Spacer(),
        Icon(iconData,color: Colors.white,size: 15,),
        Spacer()
      ],
    ),
  );
}
