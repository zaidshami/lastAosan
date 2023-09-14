import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_Aosan_ecommerce/provider/brand_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/category_provider.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../data/model/SearchListModels/OptionsSearchListModel.dart';
import '../../../../di_container.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/button/custom_button.dart';
import 'package:provider/provider.dart';

import 'BrandItemWidget.dart';
import 'CategoryItemWidget.dart';
import 'OptionsItemWidget.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  final bool isSearch;
  final String id;

  const SearchFilterBottomSheet({this.id, this.isSearch = false});

  @override
  _SearchFilterBottomSheetState createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            Consumer<SearchProvider>(
              builder: (context, search, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildOptionsList(context),
                  buildMyCheckBox(
                      context, 'latest_products', 1, handleCheckboxClick),
                  const Divider(),
                  buildMyCheckBox(
                      context, 'recommended', 5, handleCheckboxClick),
                  const Divider(),
                  buildMyCheckBox(
                      context, 'low_to_high_price', 2, handleCheckboxClick),
                  const Divider(),
                  buildMyCheckBox(
                      context, 'high_to_low_price', 3, handleCheckboxClick),
                  const Divider(),
                  buildMyCheckBox(
                      context, 'alphabetically_az', 4, handleCheckboxClick),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionsList(BuildContext context) {
    final optionsList =
        Provider.of<SearchProvider>(context, listen: false).OptionsList;
    return Container(
      height: optionsList.length * 75.0,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: optionsList.length,
        itemBuilder: (context, index) {
          var option = optionsList[index];
          return Column(
            children: [
              OptionsItemWidget(option.id, option.name, option.item.ttlist),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  Widget buildMyCheckBox(BuildContext context, String title, int index,
      Function(bool, int) onTab) {
    return MyCheckBox(
      title: getTranslated(title, context),
      index: index,
      onTab: onTab,
    );
  }

  Future<void> handleCheckboxClick(bool isChecked, int index) async {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    if (isChecked) {
      searchProvider.setFilterIndex(index);
    }

    productProvider.isFiltring = true;
    searchProvider.cleanSearchProduct();
    await searchProvider.search(context, reload: true);
    productProvider.clearOurList();
    Navigator.pop(context);
  }
}

class MyCheckBox extends StatelessWidget {
  final String title;
  final int index;
  final Function(bool, int) onTab;

  const MyCheckBox({
    @required this.title,
    @required this.index,
    @required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        title,
        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
      ),
      checkColor: Theme.of(context).primaryColor,
      activeColor: Colors.transparent,
      value: Provider.of<SearchProvider>(context).filterIndex == index,
      onChanged: (isChecked) {
        if (isChecked != null) {
          onTab(isChecked, index);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
