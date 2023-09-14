import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/attributes_provider.dart';
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
import '../../home/widget/attribute_view.dart';
import 'search_sortby_bottom_sheet.dart';

class SearchProductWidget extends StatefulWidget {
  final bool isViewScrollable;
  final List<Product> products;
  Attribute searchAttribute;
  bool isCategory;

  SearchProductWidget({this.isViewScrollable, this.products,this.searchAttribute,this.isCategory= false});

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();


}
ScrollController _scrollController = ScrollController();

class _SearchProductWidgetState extends State<SearchProductWidget> {
  @override
  void initState() {

    String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

    super.initState();


    Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,'176');

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
        widget.isCategory?
     SizedBox():
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
                // Expanded(child: Text('${getTranslated('products', context)}',style: robotoBold,)),

                Expanded(child: InkWell(
                    onTap: (){
                      Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter=false;
                      bool isCategoryFilter =      Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter;
                      showModalBottomSheet(context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          //   useSafeArea:  false,
                          builder: (c) => SearchSortByBottomSheet(widget.searchAttribute,'176k',isCategoryFilter));

                    },
                    child: Center(child: _ItemWidget(getTranslated("sort_and_filters",context),Icons.sort)))),
                // MiddlePageTransition(child: SearchSortByBottomSheet(widget.searchAttribute),),


                VerticalDivider(thickness: 5,color: Colors.white,),
                Expanded(child: InkWell(
                    onTap: (){
                      showModalBottomSheet(context: context,
                          isScrollControlled: true, backgroundColor: Colors.transparent,
                          builder: (c) => SearchFilterBottomSheet(isSearch: true,));
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
        ),),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        // Expanded(flex:2,child: AttributesView()),

        Expanded(flex:18,child:

        StaggeredGridView.countBuilder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          crossAxisCount: 2,
          // Adding extra rows for each attribute after every 10 products
          itemCount: widget.products.length + (widget.products.length ~/ 10),
          staggeredTileBuilder: (int index) {
            // If this is an attribute row, make it span 2 columns
            if ((index + 1) % 11 == 0) {
              return StaggeredTile.fit(2);
            }
            // Otherwise, fit only one column for a product
            return StaggeredTile.fit(1);
          },
          itemBuilder: (BuildContext context, int index) {
            // Determine if this index is for an attribute or a product
            if ((index + 1) % 11 == 0) {
              // Calculate the attribute index (every 11th index will show an attribute)
              int attributeIndex = index ~/ 11;

              // Option 1: Start over after reaching the end
              attributeIndex = attributeIndex % Provider.of<AttributeProvider>(context, listen: false).attributes.length;

              // Option 2: Stop showing anything after reaching the end
              // if (attributeIndex >= Provider.of<AttributeProvider>(context, listen: false).attributes.length) {
              //   return SizedBox.shrink(); // or return a Divider, Spacer, etc.
              // }

              return SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width, // Full width
                child: AttributesView(index: attributeIndex),
              );
            } else {
              // Calculate the product index
              int productIndex = index - (index ~/ 11);
              return ProductWidgetNew(productModel: widget.products[productIndex]);
            }
          },

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
      Icon(iconData,size: 15,color: Colors.white),
      Spacer(),

    ],);



  }
}


