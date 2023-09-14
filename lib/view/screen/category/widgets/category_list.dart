
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

class CategoryList extends StatelessWidget {
  final bool showMainCategories ;


  CategoryList({this.showMainCategories= false});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          // bool colorSelection= false ;
          return categoryProvider
              .categoryList
              .length !=
              0
              ?

          ///the third with the choosen
          ListView.builder(
            padding: getPadding(all: 10),
            physics:NeverScrollableScrollPhysics() ,
            itemCount: categoryProvider.getCatSelectedIndices().length,
            itemBuilder: (context, outerIndex) {


              final catIndices = categoryProvider.getCatSelectedIndices();

              final selectedCatIndex = catIndices[outerIndex];
              List<Color> colorList = outerIndex.isEven ? AppConstants.evenColors : AppConstants.oddColors;
              // Calculate the color index based on the length of the color list
              int colorIndex = outerIndex % colorList.length;
              // Selected color from the color list
              Color selectedColor = colorList[colorIndex];

              return Column(
                children: [

                  Padding(
                    padding: getPadding(top: 45),
                    child: InkWell(
             /*         onTap: (){
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => BrandAndCategoryProductScreen(
                                  isBacButtonExist: true,
                                  isBrand: false,
                                  name: categoryProvider.categoryList[selectedCatIndex].name,
                                  id: categoryProvider.categoryList[selectedCatIndex].id.toString(),





                                )));
                      },*/
                      child: Center(
                          child:
                          categoryProvider.categoryList[selectedCatIndex].name2!=null?Text(
                            '${categoryProvider.categoryList[selectedCatIndex].name2}',
                            style: robotoBold.copyWith(fontSize: 18),
                          ):Text(
                            '${categoryProvider.categoryList[selectedCatIndex].name}',
                            style: robotoBold.copyWith(fontSize: 18),
                          )

                      ),
                    ),
                  ),

                  Container(

                    padding: getPadding(top: 10,left: 0,right: 0),
                    height: MediaQuery.of(context).size.height*0.21,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider
                          .categoryList[selectedCatIndex]
                          .subCategorieswithoutall.length,
                      itemBuilder: (context, innerIndex) {
                        final itemWidth =  MediaQuery.of(context).size.width * 0.29;  // The width of each item
                        final itemSpacing = 20.0;  // The spacing between items


                        final totalItems = categoryProvider
                            .categoryList[categoryProvider.getCatSelectedIndex()]
                            .subCategorieswithoutall.length;

                        final totalWidth = (itemWidth + itemSpacing) * totalItems;

                        final listViewWidth = MediaQuery.of(context).size.width;

                        final padding =
                        totalItems <= 2 ? (listViewWidth - totalWidth) / 2 : itemSpacing;

                        final _subCategory = categoryProvider
                            .categoryList[selectedCatIndex]
                            .subCategorieswithoutall[innerIndex];

                        return Padding(
                          padding: EdgeInsets.only(right: itemSpacing, left: padding),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BrandAndCategoryProductScreen(
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
                                  name: _subCategory.name,
                                  id: _subCategory.id.toString(),
                                  subSubCategory: categoryProvider
                                      .categoryList[selectedCatIndex]
                                      .subCategorieswithoutall[innerIndex]
                                      .subSubCategories,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: getPadding(all: 0),
                              width: itemWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:  selectedColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CategoryItem3(
                                  color:    selectedColor == AppConstants.oddColors[0] ||
                                      selectedColor == AppConstants.oddColors[1]


                                ? Colors.black // Set text color to black for oddColors
                                  : Colors.white,
                                  title: _subCategory.name,
                                  icon: _subCategory.icon2,
                                  isSelected: false,
                                ),
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



              : Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}