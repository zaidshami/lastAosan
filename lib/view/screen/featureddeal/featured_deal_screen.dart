import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/featured_deal_provider.dart';
import '../../../utill/app_constants.dart';
import '../../basewidget/custom_app_bar.dart';
import '../home/widget/featured_deal_view.dart';

class FeaturedDealScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: AppConstants.textScaleFactior),
      child: Scaffold(
        body: Column(children: [
          CustomAppBar(title: getTranslated('featured_deals', context)),
          Expanded(child: RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              await Provider.of<FeaturedDealProvider>(context, listen: false).getFeaturedDealList(
                  Provider.of<CategoryProvider>(context,listen: false).categoryList[Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex].id,true, context,);
            },
            child: FeaturedDealsView(isHomePage: false),
          )),

        ]),
      ),
    );
  }
}
