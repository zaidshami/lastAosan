import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/math_utils.dart';
import '../../../../view/basewidget/product_widget.dart';
import '../../../../view/screen/search/widget/search_filter_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../basewidget/get_loading.dart';
import '../../../basewidget/product_widget_new.dart';
import 'search_sortby_bottom_sheet.dart';

class SearchProductWidget extends StatefulWidget {
  final bool isViewScrollable;
  final List<Product> products;
  Attribute searchAttribute;

  SearchProductWidget({this.isViewScrollable, this.products,this.searchAttribute});

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();


}
ScrollController _scrollController = ScrollController();

class _SearchProductWidgetState extends State<SearchProductWidget> {
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMore();
      }
    });
  }
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

    return Column(
      children: [
        Container(
          padding: getPadding(),
          decoration: BoxDecoration(
            color:Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
         width: MediaQuery.of(context).size.width*0.5,


          // width: 170,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(child: Text('${getTranslated('products', context)}',style: robotoBold,)),
              ///التصفية
                Expanded(child: InkWell(
                    onTap: (){
                      showModalBottomSheet(context: context,
                              isScrollControlled: true,
                          backgroundColor: Colors.white,
                              useSafeArea:  false,
                              builder: (c) => SearchSortByBottomSheet(widget.searchAttribute));

                    },
                    child: Center(child: _ItemWidget(getTranslated("sort_and_filters",context),Icons.sort)))),
                 // MiddlePageTransition(child: SearchSortByBottomSheet(widget.searchAttribute),),


               VerticalDivider(thickness: 5,color: Colors.white,),
                Expanded(child: InkWell(
                    onTap: (){
                      showModalBottomSheet(context: context,
                          isScrollControlled: true, backgroundColor: Colors.transparent,
                          builder: (c) => SearchFilterBottomSheet());
                    },
                    child: Center(child: _ItemWidget(getTranslated("sort_by",context),Icons.filter_alt)))),

                // InkWell(onTap: () => showModalBottomSheet(context: context,
                //     isScrollControlled: true, backgroundColor: Colors.transparent,
                //     builder: (c) => SearchFilterBottomSheet()),
                //     child: Container(
                //       padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                //           horizontal: Dimensions.PADDING_SIZE_SMALL),
                //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
                //       child: Image.asset(Images.dropdown, scale: 3),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Text.rich(TextSpan(
            children: [
              TextSpan(text: '${getTranslated('searched_item', context)}',
                  style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.getReviewRattingColor(context))),

              TextSpan(text: '(${getTranslated('item_found', context)} '
                  + '${Provider.of<SearchProvider>(context, listen: false).foundSize.toString()})'),
            ],
          //
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



        Expanded(child: StaggeredGridView.countBuilder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          itemCount: widget.products.length,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          itemBuilder: (BuildContext context, int index) {
            return ProductWidgetNew(productModel: widget.products[index]);},
          ),

        ),
        Provider.of<SearchProvider>(context, listen: false).isLoading?getloading3(context):SizedBox()
      ],
    );
  }

  Widget _ItemWidget(String title,IconData iconData){
    return Row(children: [
      Spacer(),
      Text('${title}',style: robotoBold.copyWith(fontSize: 11,color: Colors.white),),
  Spacer(),
      Icon(iconData,size: 25,color: Colors.white),
      Spacer(),

    ],);



  }
}



///the search when it wass whole always give me the
/*
class SearchProductWidget extends StatefulWidget {
  final bool isViewScrollable;
  final List<Product> products;
  final ScrollController scrollController ;
  SearchProductWidget({this.isViewScrollable, this.products,this.scrollController});

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  final ScrollController _scrollController = ScrollController();
  int offset = 1;
  @override
  void initState() {
    // Provider.of<ProductProvider>(context, listen: false)
    //     .initBrandOrCategoryProductList(
    //     widget.isBrand, widget.id, context, offset,
    //     reload: true);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController?.addListener(() {
        if (     widget.scrollController.position.maxScrollExtent ==
            widget.scrollController.position.pixels) {
          // offset = Provider.of<ProductProvider>(context, listen: false).cOffset;
          offset++;
          print("the current searchtext is :"+Provider.of<SearchProvider>(context, listen: false).searchText);
          Provider.of<SearchProvider>(context, listen: false)
              .searchProduct(Provider.of<SearchProvider>(context, listen: false).searchText, context,offset:offset);
          print("the offset is:"+offset.toString());


        }
      });
    });


  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(child: Text('${getTranslated('products', context)}',style: robotoBold,)),
            Expanded(child: InkWell(
                onTap: (){
                  showModalBottomSheet(context: context,
                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) => SearchSortByBottomSheet());

                },
                child: Center(child: _ItemWidget(getTranslated("SORT_BY",context),Icons.sort)))),



            Expanded(child: InkWell(
                onTap: (){
                  showModalBottomSheet(context: context,
                      isScrollControlled: true, backgroundColor: Colors.transparent,
                      builder: (c) => SearchFilterBottomSheet());
                },
                child: Center(child: _ItemWidget(getTranslated("sort_and_filters",context),Icons.filter_alt)))),

            // InkWell(onTap: () => showModalBottomSheet(context: context,
            //     isScrollControlled: true, backgroundColor: Colors.transparent,
            //     builder: (c) => SearchFilterBottomSheet()),
            //     child: Container(
            //       padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            //           horizontal: Dimensions.PADDING_SIZE_SMALL),
            //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),),
            //       child: Image.asset(Images.dropdown, scale: 3),
            //     ),
            //   ),
          ],
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Text.rich(TextSpan(
          children: [
            TextSpan(text: '${getTranslated('searched_item', context)}',
                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                    color: ColorResources.getReviewRattingColor(context))),

            TextSpan(text: '(${widget.products.length} ' + '${getTranslated('item_found', context)})'),
          ],
        ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



        Expanded(child: StaggeredGridView.countBuilder(
          controller: widget.scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          itemCount: widget.products.length,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          itemBuilder: (BuildContext context, int index) {
            return ProductWidgetNew(productModel: widget.products[index]);},
        ),
        ),
      ],
    );
  }

  Widget _ItemWidget(String title,IconData iconData){
    return Container(
      width: 150,
      child: Row(children: [
        Text('${title}',style: robotoBold,),
        Icon(iconData)


      ],),
    );



  }
}


*/
