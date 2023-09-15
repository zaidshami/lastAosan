import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/helper/product_type.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/app_constants.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/products_view_1.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../provider/category_provider.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/search_provider.dart';
import '../../../../view/screen/home/widget/category_widget.dart';
import '../../../../view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import 'category_shimmer.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  int length ;


   CategoryView({@required this.isHomePage, this.length = 8});
  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    if (categoryProvider.categoryList == null
        || categoryProvider.categoryList.isEmpty ||
        categoryProvider.categorySelectedIndex >= categoryProvider.categoryList.length) {
      return CategoryShimmerList(count: 8);

    }


    int i =  Provider.of<CategoryProvider>(context,
        listen: false).categoryList[ Provider.of<CategoryProvider>(context,
        listen: false).categorySelectedIndex].subCategories.length;
    int x =  Provider.of<CategoryProvider>(context,
        listen: false).categoryList[ Provider.of<CategoryProvider>(context,
        listen: false).categorySelectedIndex].subCategories.length>4?4 :Provider.of<CategoryProvider>(context,
        listen: false).categoryList[ Provider.of<CategoryProvider>(context,
        listen: false).categorySelectedIndex].subCategories.length;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Consumer<CategoryProvider>(


        builder: (context, categoryProvider, child) {

          return categoryProvider.categoryList.length != 0 ?
              AppConstants.categoryType?
              GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing : 15,
            ),
            itemCount:
            // isHomePage ?
            categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length,
                // > length ?length
                // : categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length
                // : categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

                  Provider.of<AttributeProvider>(context, listen: false).initialized= false;
                  Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter=true;
                  Navigator.push(context, CupertinoPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                        isBacButtonExist: true,
                        isBrand: false,
                        subSubCategory: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].subSubCategories,
                        id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString(),
                        name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].name,
                    attribute:       Attribute(
                        id:
                        // categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id ,
                        int.parse(AppConstants.categoryId),
                        name: "",
                        childes: [

                          Child(
                                id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString(),
                              name:categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].name
                          )
                        ]
                    ),
                      ),),);

                  Provider.of<AttributeProvider>(context, listen: false).initializeData(seearchText,categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString());
                },
                child: CategoryWidget(
                category:categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index]),
              );

            },
          ):
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                padding:getPadding(top: 10,bottom: 0),

                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount:
                       categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length ,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (_) =>


                             BrandAndCategoryProductScreen(
                               attribute:       Attribute(
                                   id: int.parse(
                                       AppConstants.categoryId),
                                   name: "",
                                   childes: [

                                     Child(

                                         id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString(),
                                         name:categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].name

                                     )
                                   ]
                               ),
                              isBacButtonExist: true,
                              isBrand: false,
                              subSubCategory: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].subSubCategories,
                              id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString(),
                              name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].name,
                            ),
                        ),);
                      },
                      child: CategoryWidget(
                        category: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index],height: 90,width: 90,),
                    );
                  },
                ),
              )
              : AppConstants.categoryType==false? CategoryShimmerGrid(count: i,):CategoryShimmerList(count: x);
        },
      ),
    );
  }
}







