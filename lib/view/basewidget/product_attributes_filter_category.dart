import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/search_widget.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/filter_category_1.dart';
import '../../localization/language_constrants.dart';
import '../../provider/search_provider.dart';
import '../../utill/dimensions.dart';
import '../../utill/math_utils.dart';

/*class ProductAttributeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return getloading4(context);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Consumer<AttributeProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: provider.attributes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(provider.attributes[index].name),
                          onTap: () => provider.selectParent(index),
                          tileColor: provider.selectedParentIndex == index ? Colors.blue : null,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: ListView(
                      children: provider.attributes[provider.selectedParentIndex].childes.map((child) {
                        return ListTile(
                          title: Text(child.name),
                          // Add more fields as needed
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}*/
class NewProductAttributeList extends StatefulWidget {
  Attribute searchAttribute;
  NewProductAttributeList(this.searchAttribute);
  @override
  _NewProductAttributeListState createState() => _NewProductAttributeListState();
}

class _NewProductAttributeListState extends State<NewProductAttributeList> {

  @override
  Widget build(BuildContext context) {
    return

      FutureBuilder(
        future: Provider.of<AttributeProvider>(context, listen: false).
        fetchCategoryFilterList(Provider.of<SearchProvider>(context).category_search_list),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getloading4(context);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {

            var selectedAttributes=Provider.of<SearchProvider>(context).selectedAttributes;

            return Consumer<AttributeProvider>(
              builder: (context, provider, child) {

                print("selectedAttributes klength ${selectedAttributes.keys.toList().length}");
                print("attributes klength ${provider.attributes.length}");
                //   if(provider.attributes.length>selectedAttributes.keys.toList().length) {
                if(provider.attributes.length>selectedAttributes.keys.toList().length) {
                  // Provider.of<SearchProvider>(context,listen: false).clearFilters();
                  provider.attributes.forEach((element) =>
                  selectedAttributes[element.id.toString()] = []);
                  if(widget.searchAttribute!=Attribute.nonAttribute()){

                    selectedAttributes[widget.searchAttribute.id.toString()] =widget.searchAttribute.getChildIds;
                  }
                }


                return Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: (){Navigator.pop(context);}
                              ,icon: Icon(Icons.close)),
                        ),
                        Expanded(child: Container(),),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: (){
                                Provider.of<SearchProvider>(context,listen: false).clearFilters();
                              }
                              ,icon: Text(getTranslated('remove_all', context))),
                        ),

                      ],
                    ),


                    Expanded(
                      flex: 9,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ListView.builder(

                              padding:getPadding(all:3) ,
                              itemCount: provider.attributes.length,
                              itemBuilder: (context, index) {
                                var item=provider.attributes[index];
                                return ListTile(

                                  // contentPadding: getPadding(all:0),
                                  title: Text(item.name,style: robotoBold.copyWith(color:provider.selectedParentIndex == item.id ? Colors.white:Colors.black ),),
                                  onTap: () => provider.selectParent(item.id),
                                  tileColor: provider.selectedParentIndex == item.id ? Colors.black : null,
                                );
                              },
                            ),
                          ),
                          //todo : here add the list of the selected attributes

                          Expanded(
                            flex: 7,

                            child: Builder(
                                builder: (_) {

                                  var searchProvider=Provider.of<SearchProvider>(context,listen: false);

                                  int parentType=provider.attributes.firstWhere((element) =>
                                  element.id==provider.selectedParentIndex).type;

                                  var val=searchProvider.
                                  selectedAttributes[provider.selectedParentIndex.toString()];

                                  List<Child> childList=[];

                                  if(provider.attributes.where((element) => element.id==provider.selectedParentIndex).isNotEmpty){

                                    childList=provider.attributes.firstWhere((element) =>
                                    element.id==provider.selectedParentIndex).childes;

                                  }

                                  // if(parentType==2){
                                  //   return Column(
                                  //     children: [
                                  //       Switch(value: searchProvider.switchStatus, onChanged: (j){
                                  //         searchProvider.setSearch(j);
                                  //
                                  //       }),
                                  //       TextField(
                                  //         controller: searchProvider.minPriceController,
                                  //         decoration: InputDecoration(
                                  //             labelText: 'الحد الادنى',
                                  //             enabled: searchProvider.switchStatus
                                  //         ),
                                  //       ),
                                  //       TextField(
                                  //         controller: searchProvider.maxPriceController,
                                  //         decoration: InputDecoration(
                                  //             labelText: 'الحد الاعلى',
                                  //             enabled: searchProvider.switchStatus
                                  //
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   );
                                  // }
                                  return ListView(
                                    children: childList.map((child) {
                                      return CheckboxListTile(
                                        activeColor: Colors.black,
                                        title: Text(child.name,style: robotoRegular,),
                                        value:

                                        val.where((element) => element==child.id).isNotEmpty,

                                        onChanged: (bool value) {
                                          if (value) {
                                            searchProvider.
                                            selectAttribute(provider.attributes.firstWhere((element) =>
                                            element.id==provider.selectedParentIndex).id.toString(), child.id);
                                          } else {
                                            searchProvider.
                                            deselectAttribute(provider.attributes.firstWhere((element) =>
                                            element.id==provider.selectedParentIndex).id.toString(), child.id);
                                          }
                                        },
                                      );

                                    }).toList(),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:getPadding(bottom: 20,left: 16,right: 16),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set background color to black
               alignment: Alignment.center,

                          minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width, 50)), // Set width to 200 and height to 50
                        ),
                        onPressed: () {
                          Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();
                          Provider.of<SearchProvider>(context, listen: false).search(context);
                          Navigator.pop(context);
                        },
                        child: Text(

                           getTranslated('show_results', context),
                        ),
                      ),
                    ),


                  ],
                );
              },
            );
          }
        },
      )
    ;
  }




}
