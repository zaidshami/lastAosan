
import 'package:flutter/cupertino.dart';

import 'SearchListModel.dart';
import '../response/category.dart';

class CatageorySearch extends SearchRequerments{

  Category category;
  CatageorySearch(this.category) : super(category.id, category.name);

}

class CategorySearchListModel<T extends CatageorySearch> extends MainSearchModel<T>{


  CategorySearchListModel({
     bool is_selected, T item, int id, String name})
      : super(is_selected, item, id, name);


  @override
  bool insert_to_list(List<SearchRequerments> list, List<MainSearchModel> search_list) {

    if(search_list.length>0)return false;

    search_list.add( CategorySearchListModel( is_selected: true, id: 0,name: "الكل") );

    list.forEach((element) {
      search_list.add(CategorySearchListModel( is_selected: false
          , item:element,name: element.name,id: element.id) );

    });
    return true;

  }

}
