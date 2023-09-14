
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/category.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../provider/category_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../product/brand_and_category_product_screen.dart';
import '../all_category_screen.dart';

class SubCategoryList extends StatelessWidget {
  final bool showMainCategories ;


  SubCategoryList({this.showMainCategories= false});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),

      child: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return categoryProvider
              .categoryList[
          categoryProvider.categorySelectedIndex]
              .subCategorieswithoutall
              .length !=
              0
              ? showMainCategories?
          Row(


              children: [
                /// the  categories
                showMainCategories?  MediaQuery(
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

                        ],
                      ),
                    ),
                  ),
                ):SizedBox(),
                /// the pic of the subcategorties
              showMainCategories?
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
                                          attribute:       Attribute(
                                              id: int.parse(
                                                  AppConstants.categoryId),
                                              name: "",
                                              childes: [

                                                Child(
                                                    id:_subCategory.id.toString(),
                                                    name: "")
                                              ]
                                          ),
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
                ):

              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
                child: Column(
                  children: [
                    Expanded(

                      child: SizedBox(

                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            SubSubCategory _subCategory;

                            _subCategory = categoryProvider
                                .categoryList[categoryProvider.categorySelectedIndex]
                                .subCategorieswithoutall[categoryProvider.categorySubSelectedIndex]
                                .subSubCategories[index];

                            return InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => BrandAndCategoryProductScreen(
                                        isBacButtonExist: true,
                                        isBrand: false,
                                        name: categoryProvider
                                            .categoryList[categoryProvider.categorySelectedIndex]
                                            .subCategorieswithoutall[categoryProvider.categorySubSelectedIndex]
                                            .name,
                                        id: _subCategory.id.toString(),
                                        subSubCategory: categoryProvider
                                            .categoryList[categoryProvider.categorySelectedIndex]
                                            .subCategorieswithoutall[categoryProvider.categorySubSelectedIndex]
                                            .subSubCategories,
                                      ))),
                              child: Container(
                                // Add padding or divider if necessary
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                child: CategoryItem1(
                                  title: _subCategory.name,
                                  icon: _subCategory.icon,
                                  isSelected: false,
                                ),
                              ),
                            );
                          },
                          itemCount: categoryProvider
                              .categoryList[categoryProvider.categorySelectedIndex]
                              .subCategorieswithoutall[categoryProvider.categorySubSelectedIndex]
                              .subSubCategories
                              .length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              ]):
      ///the third with the choosen
          ListView.builder(
            padding: getPadding(all: 10),
            physics:NeverScrollableScrollPhysics() ,
            itemCount: categoryProvider.getSubSelectedIndices().length,
            itemBuilder: (context, outerIndex) {


              final subIndices = categoryProvider.getSubSelectedIndices();


              final selectedSubIndex = subIndices[outerIndex];


              List<Color> colorList = outerIndex.isEven ? AppConstants.evenColors : AppConstants.oddColors;
              // Calculate the color index based on the length of the color list
              int colorIndex = outerIndex % colorList.length;
              // Selected color from the color list
              Color selectedColor = colorList[colorIndex];
              return Column(
                children: [

                  Padding(
                    padding:getPadding(top: 45),
                    child: Center(
                      child: InkWell(
                        onTap: () {


                        },
                        child:
              categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[selectedSubIndex].name2!=null?
                        Text(
                          '${categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[selectedSubIndex].name2}',
                          style: robotoBold.copyWith(fontSize: 20,),
                        ):  Text(
                '${categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[selectedSubIndex].name}',
                style: robotoBold.copyWith(fontSize: 20,),
              ),
                      ),
                    ),
                  ),

                  Container(

                    padding: getPadding(top: 10,left: 0,right: 0),
                    height: MediaQuery.of(context).size.height*0.21,
                    // Define height that suits you
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider
                          .categoryList[categoryProvider.categorySelectedIndex]
                          .subCategorieswithoutall[selectedSubIndex]
                          .subSubCategorieswithoutall
                          .length,
                      itemBuilder: (context, innerIndex) {
                        final itemWidth =MediaQuery.of(context).size.width * 0.29;  // The width of each item
                        final itemSpacing = 20.0;  // The spacing between items

                        // The total number of items
                        final totalItems = categoryProvider
                            .categoryList[categoryProvider.categorySelectedIndex]
                            .subCategorieswithoutall[selectedSubIndex]
                            .subSubCategorieswithoutall
                            .length;

                        // The total width consumed by items and spacing
                        final totalWidth = (itemWidth + itemSpacing) * totalItems;

                        // Available width in ListView
                        final listViewWidth = MediaQuery.of(context).size.width;

                        // Padding calculation to center items
                        final padding =
                        totalItems <= 2 ? (listViewWidth - totalWidth) / 2 : itemSpacing;

                        final _subCategory = categoryProvider
                            .categoryList[categoryProvider.categorySelectedIndex]
                            .subCategorieswithoutall[selectedSubIndex]
                            .subSubCategorieswithoutall[innerIndex];

                        return Padding(
                          padding: EdgeInsets.only(right: itemSpacing, left: padding),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BrandAndCategoryProductScreen(
                                  attribute:    Attribute(
                                      id: int.parse(
                                          AppConstants.categoryId),
                                      name: "",
                                      childes: [

                                        Child(
                                            id:_subCategory.id.toString(),
                                            name: "")
                                      ]
                                  ),
                                  isBacButtonExist: true,
                                  isBrand: false,
                                  name: _subCategory.name,
                                  id: _subCategory.id.toString(),
                                  subSubCategory: categoryProvider
                                      .categoryList[categoryProvider.categorySelectedIndex]
                                      .subCategorieswithoutall[selectedSubIndex]
                                      .subSubCategories,

                                ),
                              ),
                            ),
                            child: Container(
                              padding: getPadding(all: 0),
                              width: itemWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:  selectedColor
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:     CategoryItem3(
                                  color:    selectedColor == AppConstants.oddColors[0] ||
                                      selectedColor == AppConstants.oddColors[1]


                                      ? Colors.black // Set text color to black for oddColors
                                      : Colors.white,
                                  title: _subCategory.name,
                                  icon: _subCategory.icon2,
                                  isSelected: false,
                                ),

                              /*  CategoryItem2(
                                  color:    selectedColor == AppConstants.oddColors[0] ||
                                      selectedColor == AppConstants.oddColors[1]


                                      ? Colors.black // Set text color to black for oddColors
                                      : Colors.white,
                                  title: _subCategory.name,
                                  icon: _subCategory.icon2,
                                  isSelected: false,
                                ),*/
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  ),
                ],
              );
            },
          )


          /// the second with the sequence one
        /*  Container(
            height: MediaQuery.of(context).size.width / 4,
            child: ListView.builder(
              itemCount: categoryProvider.getCategoryLength(),
              itemBuilder: (context, outerIndex) {
                return Column(
                  children: [
                    Center(
                      child: Text(
                        '${categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[outerIndex].name}',
                        style: robotoBold,
                      ),
                    ),
                    Container(
                      height: 100, // Define height that suits you
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider
                            .categoryList[categoryProvider.categorySelectedIndex]
                            .subCategorieswithoutall[outerIndex]
                            .subSubCategorieswithoutall
                            .length,
                        itemBuilder: (context, innerIndex) {
                          final _subCategory = categoryProvider
                              .categoryList[categoryProvider.categorySelectedIndex]
                              .subCategorieswithoutall[outerIndex]
                              .subSubCategorieswithoutall[innerIndex];

                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BrandAndCategoryProductScreen(
                                  isBacButtonExist: true,
                                  isBrand: false,
                                  name: _subCategory.name,
                                  id: _subCategory.id.toString(),
                                  subSubCategory: categoryProvider
                                      .categoryList[categoryProvider.categorySelectedIndex]
                                      .subCategorieswithoutall[outerIndex]
                                      .subSubCategorieswithoutall,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                              child: CategoryItem1(
                                title: _subCategory.name,
                                icon: _subCategory.icon,
                                isSelected: false,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        */

        /// the first with only one
          /*   Container(
            height: MediaQuery.of(context).size.width/4,
                child: Column(
                  children: [
                    Center(child: Text(
                      '${categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[categoryProvider.getSubSelectedIndex()].name}',
                      // '${categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategorieswithoutall[categoryProvider.categorySubSelectedIndex].name}'
                      style: robotoBold,)),
                    Expanded(
                      child: ListView.builder(

            scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          SubSubCategory _subCategory;

                          _subCategory = categoryProvider
                              .categoryList[categoryProvider.categorySelectedIndex]
                              .subCategorieswithoutall[categoryProvider.getSubSelectedIndex()]
                              .subSubCategorieswithoutall[index];



                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => BrandAndCategoryProductScreen(
                                      isBacButtonExist: true,
                                      isBrand: false,
                                      name: categoryProvider
                                          .categoryList[categoryProvider.categorySelectedIndex]
                                          .subCategorieswithoutall[categoryProvider.getSubSelectedIndex()]
                                          .name,
                                      id: _subCategory.id.toString(),
                                      subSubCategory: categoryProvider
                                          .categoryList[categoryProvider.categorySelectedIndex]
                                          .subCategorieswithoutall[categoryProvider.getSubSelectedIndex()]
                                          .subSubCategorieswithoutall,
                                    ))),
                            child: Container(
                              // Add padding or divider if necessary
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                              child: CategoryItem1(
                                title: _subCategory.name,
                                icon: _subCategory.icon,
                                isSelected: false,
                              ),
                            ),
                          );
                        },
                        itemCount: categoryProvider
                            .categoryList[categoryProvider.categorySelectedIndex]
                            .subCategorieswithoutall[categoryProvider.getSubSelectedIndex()]
                            .subSubCategorieswithoutall
                            .length,
                      ),
                    ),
                  ],
                ),
              )*/
              : Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}


