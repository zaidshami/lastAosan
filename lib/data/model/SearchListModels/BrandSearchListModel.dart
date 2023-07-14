

import 'package:flutter_Aosan_ecommerce/data/model/response/brand_model.dart';

import 'SearchListModel.dart';

class BrandSearch extends SearchRequerments{

  BrandModel  brandModel;
  BrandSearch(this.brandModel) : super(brandModel.id, brandModel.name);

}

class BrandSearchListModel<T extends BrandSearch> extends MainSearchModel<T>{


  BrandSearchListModel({
    bool is_selected, T item, int id, String name})
      : super(is_selected, item, id, name);


  @override
  bool insert_to_list(List<SearchRequerments> list, List<MainSearchModel> search_list) {

    if(search_list.length>0)return false;

    search_list.add( BrandSearchListModel( is_selected: true, id: 0,name: "الكل") );

    list.forEach((element) {
      search_list.add(BrandSearchListModel( is_selected: false
          , item:element,name: element.name,id: element.id) );

    });
    return true;

  }

}
