import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/flash_deal_provider.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/custom_app_bar.dart';
import '../../basewidget/title_row.dart';
import '../home/widget/flash_deals_view.dart';

class FlashDealScreen extends StatefulWidget {
  @override
  State<FlashDealScreen> createState() => _FlashDealScreenState();
}

class _FlashDealScreenState extends State<FlashDealScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        CustomAppBar(title: Provider.of<FlashDealProvider>(context).flashDeal.title),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: TitleRow(


              title: Provider.of<FlashDealProvider>(context).flashDeal.title,
              eventDuration: Provider.of<FlashDealProvider>(context).duration),
        ),
        Expanded(
            child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Provider.of<FlashDealProvider>(context, listen: false)
                .getMegaDealList(
                    Provider.of<CategoryProvider>(context)
                        .categoryList[Provider.of<CategoryProvider>(context)
                            .categorySelectedIndex]
                        .id,
                    true,
                    context,
                    false);
          },
          child: FlashDealsView(isHomeScreen: false),
        )),
      ]),
    );
  }
}
