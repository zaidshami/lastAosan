

abstract class MainSearchModel<T extends SearchRequerments>{
  bool is_selected;
  int id;
  String name;
  T item;

  MainSearchModel(this.is_selected, this.item, this.id, this.name);


  bool insert_to_list(List<SearchRequerments> list
      ,List<MainSearchModel> search_list);



 void set_selected(List<MainSearchModel> search_list,int id){
    search_list.forEach((element) {
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



 class SearchRequerments{
   int id;
   String name;

   SearchRequerments(this.id,this.name);
 }







