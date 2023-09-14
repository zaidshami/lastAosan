
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/SearchListModels/SearchListModel.dart';
import '../../../../provider/search_provider.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';

class ItemWidget<T extends MainSearchModel> extends StatelessWidget{
  List<T> listView;
  String title;
  ItemWidget(this.title,this.listView);
  @override
  Widget build(BuildContext context) {
   return Column(
     children: [
       Align(alignment: Alignment.centerRight,child:
       Text(this.title,style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),),
       SizedBox(height: 5,),
       SizedBox(
         height: 40,
         width: MediaQuery.of(context).size.width ,
         child: ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: listView.length,
           itemBuilder: (context, index) {
             var item =listView[index];

             return InkWell(
               onTap: (){
                 // Provider.of<SearchProvider>(context, listen: false).change_search_list(item);
               },
               child: Container(
                   decoration:BoxDecoration(
                       color: Colors.white,
                       border: Border.all(color: item.is_selected?Colors.blue:Colors.white),
                       borderRadius:BorderRadius.all(Radius.circular(10)) ) ,
                   child: Center(child: Text("  "+item.name+"  ",
                     style: titilliumRegular.copyWith(color: Colors.black,fontSize:  Dimensions.FONT_SIZE_SMALL),))),
             );

           },),),
     ],
   );
  }

}

