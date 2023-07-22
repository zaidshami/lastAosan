
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_Aosan_ecommerce/provider/brand_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/category_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_widgets.dart';
import '../../../../data/model/SearchListModels/OptionsSearchListModel.dart';
import '../../../../data/model/response/filter_category_1.dart';
import '../../../../di_container.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/button/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/product_attributes_filter_category.dart';
import 'BrandItemWidget.dart';
import 'CategoryItemWidget.dart';
import 'OptionsItemWidget.dart';

class SearchSortByBottomSheet extends StatefulWidget {
  Attribute searchAttribute;
  SearchSortByBottomSheet(this.searchAttribute);
  @override
  _SearchFilterBottomSheetState createState() => _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchSortByBottomSheet> {
  final TextEditingController _firstPriceController = TextEditingController();
  final FocusNode _firstFocus = FocusNode();
  final TextEditingController _lastPriceController = TextEditingController();
  final FocusNode _lastFocus = FocusNode();

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: getPadding(top: 30, bottom:10,left: 10,right: 10),
      child: NewProductAttributeList(widget.searchAttribute),
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final String title;
  final int index;
  MyCheckBox({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
      checkColor: Theme.of(context).primaryColor,
      activeColor: Colors.transparent,
      value: Provider.of<SearchProvider>(context).filterIndex == index,
      onChanged: (isChecked) {
        if(isChecked) {
          Provider.of<SearchProvider>(context, listen: false).setFilterIndex(index);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}



class MiddlePageTransition extends StatelessWidget {
  final Widget child;

  const MiddlePageTransition({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalMiddle(context, child);
      },
      child: Center(child: _ItemWidget("SORT_BY", Icons.sort)),
    );
  }

  void showModalMiddle(BuildContext context, Widget child) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double transitionHeight = screenHeight / 2; // Adjust as needed

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: AnimatedContainer(

                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(top: transitionHeight * (1 - animation.value)),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final String text;
  final IconData iconData;

  const _ItemWidget(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        Icon(iconData),
      ],
    );
  }
}
