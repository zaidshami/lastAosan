import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/category_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../basewidget/get_loading.dart';
import 'category_shimmer.dart';
import 'category_widget.dart';

class MainCategoryView extends StatelessWidget {
  final int excludeId;
  final bool isHomePage;
  int length ;
  final Function onTap;

  final ScrollController scrollController ;
  final TabController tabController ;

  MainCategoryView({this.onTap,this.excludeId,this.tabController,this.scrollController,@required this.isHomePage, this.length = 8});
  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    if (categoryProvider.categoryList == null
        || categoryProvider.categoryList.isEmpty ||
        categoryProvider.categorySelectedIndex >= categoryProvider.categoryList.length) {
      return getloading3(context);

    }
    var filteredCategoryList = categoryProvider.categoryList
        .where((category) => category.id != excludeId)
        .toList();

    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {

        return categoryProvider.categoryList.length != 0 ?
        Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            return categoryProvider.categoryList.length != 0
                ?
            // Container(
            //   height: 100,
            //   child: Wrap(
            //     direction: Axis.vertical,
            //
            //     children: categoryProvider.categoryList.map((e) => MainCategoryWidget(
            //     width: MediaQuery.of(context).size.width ,
            //     category:  e,
            //   )).toList(),),
            // )
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5, // Adjust this value as needed
              ),
              itemCount:  categoryProvider.categoryList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,

              itemBuilder: (BuildContext context, int index) {
                return index!=excludeId?InkWell(
                 onTap: () => onTap(index),
                  child: MainCategoryWidget(
                    width: MediaQuery.of(context).size.width ,
                    category:  categoryProvider.categoryList[index],
                  ),
                ):SizedBox();
              },
            )
                : AppConstants.categoryType == false
                ? getloading4(context)
                : getloading4(context);
          },
        )

            : AppConstants.categoryType==false? getloading4(context):getloading4(context);
      },
    );
  }
}