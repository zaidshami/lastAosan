import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/category/widgets/sub_category_list.dart';
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

                Expanded(child: SubCategoryList(showMainCategories: true,))

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



class CategoryItem3 extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final Color color;

  const CategoryItem3({this.color, this.title, this.icon, this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, right: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 14,
              child: Container(
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      Image.asset(Images.placeholder_3x1, fit: BoxFit.cover),
                  placeholder: (context, url) =>
                      Image.asset(Images.placeholder_3x1, fit: BoxFit.cover),
                  fit: BoxFit.cover,
                  imageUrl:
                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/$icon',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center row content horizontally
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: titilliumSemiBold.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    SizedBox(width: 5), // You can adjust the spacing as needed
                    Icon(
                      Icons.arrow_forward,
                      color: color,
                      size: 16, // You can adjust the size as needed
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
