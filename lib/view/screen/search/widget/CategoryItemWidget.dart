
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_widgets.dart';

import '../../../../data/model/SearchListModels/CategorySeachListModel.dart';

class CategoryItemWidget<T extends CategorySearchListModel> extends ItemWidget<T>{
  CategoryItemWidget(String title,List<T> listView ) : super(title,listView );


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
      //  Text(this.listView[1].item.category.subCategories.asMap().toString()),
        super.build(context),
      ],
    );
  }
}