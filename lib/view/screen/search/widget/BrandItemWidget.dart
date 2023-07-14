
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/search/widget/search_widgets.dart';

import '../../../../data/model/SearchListModels/BrandSearchListModel.dart';

class BrandItemWidget<T extends BrandSearchListModel> extends ItemWidget<T>{
  BrandItemWidget(String title,List<T> listView ) : super(title,listView );


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
         // Text(this.listView[1].item.brandModel.name),
        super.build(context),
      ],
    );
  }
}