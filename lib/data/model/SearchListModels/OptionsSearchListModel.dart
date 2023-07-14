import '../response/product_model.dart';
import 'SearchListModel.dart';
import 'dart:math';

class OptionsSearch extends SearchRequerments{

  String  choiceOptions;
  List<OptionsSearchListModel> ttlist;

  OptionsSearch(this.ttlist,this.choiceOptions,int id) : super(id, choiceOptions);

}

class OptionsSearchListModel<T extends OptionsSearch> extends MainSearchModel<T>{

  OptionsSearchListModel({
    bool is_selected, T item, int id, String name})
      : super(is_selected, item, id, name);


  @override
  bool insert_to_list(List<SearchRequerments> list, List<MainSearchModel> search_list) {

    if(search_list.length>0)return false;

    search_list.add( OptionsSearchListModel( is_selected: true, id: 0,name: "الكل") );

    list.forEach((element) {
      search_list.add(OptionsSearchListModel( is_selected: false
          , item:element,name: element.name,id: element.id) );

    });
    return true;

  }

  @override
  void set_selected(List<MainSearchModel<SearchRequerments>> search_list, int id) {
    search_list.forEach((element) {
      // print("element.item.id: ${element.id} ----  ----- id :$id");
      if(element.id==id) {
        element.is_selected = true;
        return;
      }else{
        element.is_selected = false;
        return;

      }
    });

  }

}
