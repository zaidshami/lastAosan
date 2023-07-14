import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/category.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../product/brand_and_category_product_screen.dart';

class AllCategoryScreen extends StatefulWidget {
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return
    SafeArea(
      child: Scaffold(

        backgroundColor: ColorResources.getIconBg(context),
        // todo: here is the reason of the distance i want to remove in the all category screen the text scale factor

        body: Container(


          child: Column(
            children: [
              ///the tab bar in the top
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),

                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    return DefaultTabController(
                      initialIndex:        categoryProvider.categorySelectedIndex,
                        length: categoryProvider.categoryList.length,
                        child: TabBar(

                          onTap: (value) {
                            // categoryProvider.changeSelectedIndex1(value); mohd
                            categoryProvider.changeSelectedIndex(value);
                            categoryProvider.changeSubSelectedIndex(0);
                          },
                          labelColor: Colors.redAccent,
                          unselectedLabelColor: Colors.black,
                          indicatorColor:  Theme.of(context).primaryColor,
                          indicatorWeight: 2.0,
                          tabs: categoryProvider.categoryList
                              .map((e) => Tab(
                                    text: e.name,
                                  ))
                              .toList(),
                          isScrollable: true,
                          labelStyle: robotoBold.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                              color: ColorResources
                                  .getReviewRattingColor(context)),
                        )
                    );
                  },
                ),
              ),
            /// the categories and the categories pic

              Expanded(child:
              Consumer<CategoryProvider>(
                builder: (context, categoryProvider, child) {
                  // bool colorSelection= false ;
                  return categoryProvider
                              .categoryList[
                                  categoryProvider.categorySelectedIndex]
                              .subCategorieswithoutall
                              .length !=
                          0
                      ? Row(



                      children: [
                        /// the  categories
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),

                          child: Expanded(
                              flex:3,
                              child: Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: categoryProvider
                                            .categoryList[
                                                categoryProvider.categorySelectedIndex]
                                            .subCategorieswithoutall
                                            .length,
                                        itemBuilder: (context, index) {
                                          SubCategory _category = categoryProvider
                                              .categoryList[
                                                  categoryProvider.categorySelectedIndex]
                                              .subCategorieswithoutall[index];
                                          return InkWell(
                                            onTap: () {
                                              // categoryProvider.categorySubSelectedIndex== index? colorSelection= false:colorSelection=true;
                                              Provider.of<CategoryProvider>(
                                                  context,
                                                  listen: false).changeSubSelectedIndex(
                                                  index);
                                              // print(colorSelection.toString());
                                              //
                                              // print(categoryProvider.categorySubSelectedIndex.toString());
                                              // print(index.toString());
                                            },
                                            child: CategoryItem(
                                              title: _category.name,
                                              icon: _category.icon,
                                              isSelected: categoryProvider
                                                      .categorySubSelectedIndex ==
                                                  index,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: ListView.builder(
                                    //     physics: BouncingScrollPhysics(),
                                    //     itemCount: categoryProvider
                                    //         .categoryList[
                                    //             categoryProvider.categorySelectedIndex]
                                    //         .subCategorieswithoutall
                                    //         .length,
                                    //     itemBuilder: (context, index) {
                                    //       SubCategory _category = categoryProvider
                                    //           .categoryList[
                                    //               categoryProvider.categorySelectedIndex]
                                    //           .subCategorieswithoutall[index];
                                    //       return InkWell(
                                    //         onTap: () {
                                    //           // categoryProvider.categorySubSelectedIndex== index? colorSelection= false:colorSelection=true;
                                    //           Provider.of<CategoryProvider>(
                                    //               context,
                                    //               listen: false).changeSubSelectedIndex(
                                    //               index);
                                    //           // print(colorSelection.toString());
                                    //           //
                                    //           // print(categoryProvider.categorySubSelectedIndex.toString());
                                    //           // print(index.toString());
                                    //         },
                                    //         child: CategoryItem(
                                    //           title: _category.name,
                                    //           icon: _category.icon,
                                    //           isSelected: categoryProvider
                                    //                   .categorySubSelectedIndex ==
                                    //               index,
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        /// the pic of the subcategorties
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),

                          child: Expanded(
                              flex:7,
                              child: Padding(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 200,
                                          crossAxisSpacing: 3
                                          ),
                                  itemBuilder: (context, index) {
                                    SubSubCategory _subCategory;

                                    _subCategory = categoryProvider
                                        .categoryList[
                                            categoryProvider.categorySelectedIndex]
                                        .subCategorieswithoutall[categoryProvider
                                            .categorySubSelectedIndex]
                                        .subSubCategories[index];
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  BrandAndCategoryProductScreen(
                                                    isBacButtonExist: true,
                                                    isBrand: false,
                                                    name: categoryProvider
                                                        .categoryList[categoryProvider
                                                            .categorySelectedIndex]
                                                        .subCategorieswithoutall[categoryProvider
                                                            .categorySubSelectedIndex]
                                                        .name,
                                                    id: _subCategory.id.toString(),
                                                    subSubCategory: categoryProvider
                                                        .categoryList[categoryProvider
                                                            .categorySelectedIndex]
                                                        .subCategorieswithoutall[categoryProvider
                                                            .categorySubSelectedIndex]
                                                        .subSubCategories,
                                                  ))),
                                      child: Container(
                                        child: CategoryItem1(
                                            title: _subCategory.name,
                                            icon: _subCategory.icon,
                                            isSelected: false),
                                      ),
                                    );
                                  },
                                  itemCount: categoryProvider
                                      .categoryList[
                                          categoryProvider.categorySelectedIndex]
                                      .subCategorieswithoutall[
                                          categoryProvider.categorySubSelectedIndex]
                                      .subSubCategories
                                      .length,
                                ),
                                padding: EdgeInsets.only(top: 10),
                              ),
                            ),
                        ),
                        ])
                      : Center(
                      child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor)));
                },
              ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  CategoryItem(
      {@required this.title, @required this.icon, @required this.isSelected});

  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),

      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : null,
          border:Border(
            top: BorderSide(width: 0.30, color: Colors.grey),
            bottom: BorderSide(width: 0.30, color: Colors.grey),
            left:  BorderSide(width: 0.30, color: Colors.grey),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titleHeader.copyWith(
                  color: isSelected ? Colors.white : Colors.black.withOpacity(0.7)
                ),),
          ),
        ),
      ),
    );
  }
}

class CategoryItem1 extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  const CategoryItem1({this.title, this.icon, this.isSelected});

  Widget build(BuildContext context) {
    return Container(


      margin: EdgeInsets.only(top: 10,right: 3 ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Container(
              child:CachedNetworkImage(
                errorWidget: (context, url, error) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                placeholder: (context, url) => Image.asset(
        Images
        .placeholder,
        fit: BoxFit
            .contain,

      ),
                fit: BoxFit.cover,
                imageUrl:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/$icon',

              ),
            ),
          ),

          SizedBox(
            height: 6,
          ),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: titilliumSemiBold.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.black,
              )),
        ]),
      ),
    );
  }
}
