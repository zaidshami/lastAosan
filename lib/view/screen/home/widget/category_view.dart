import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/helper/product_type.dart';
import 'package:flutter_Aosan_ecommerce/utill/app_constants.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/products_view_1.dart';
import '../../../../provider/category_provider.dart';
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



    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {

        return categoryProvider.categoryList.length != 0 ?
            AppConstants.categoryType==true?
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
                Navigator.push(context, CupertinoPageRoute(builder: (_) =>


                    BrandAndCategoryProductScreen(
                      isBacButtonExist: true,
                      isBrand: false,
                      subSubCategory: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].subSubCategories,
                      id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].id.toString(),
                      name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index].name,
                    ),
                ),);
              },
              child: CategoryWidget(
                category: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories[index],),
            );
          },
        ):   Container(
              height: MediaQuery.of(context).size.height*0.15,
              padding:getPadding(top: 10,bottom: 10),

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

            : CategoryShimmer();
      },
    );
  }
}



