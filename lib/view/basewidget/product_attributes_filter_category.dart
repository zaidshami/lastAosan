import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/filter_category_1.dart';
import '../../provider/search_provider.dart';

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
                    TextField(
                      controller: Provider.of<SearchProvider>(context, listen: false).searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                              itemCount: provider.attributes.length,
                              itemBuilder: (context, index) {
                                var item=provider.attributes[index];
                                return ListTile(
                                  title: Text(item.name),
                                  onTap: () => provider.selectParent(item.id),
                                  tileColor: provider.selectedParentIndex == item.id ? Colors.blue : null,
                                );
                              },
                            ),
                          ),
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

                                if(parentType==2){
                                  return Column(
                                    children: [
                                      Switch(value: searchProvider.switchStatus, onChanged: (j){
                                        searchProvider.setSearch(j);

                                      }),
                                      TextField(
                                        controller: searchProvider.minPriceController,
                                        decoration: InputDecoration(
                                          labelText: 'الحد الادنى',
                                          enabled: searchProvider.switchStatus
                                        ),
                                      ),
                                      TextField(
                                        controller: searchProvider.maxPriceController,
                                        decoration: InputDecoration(
                                          labelText: 'الحد الاعلى',
                                            enabled: searchProvider.switchStatus

                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return ListView(
                                  children: childList.map((child) {
                                    return CheckboxListTile(
                                      title: Text(child.name),
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
                    ElevatedButton(
                      onPressed: () =>Provider.of<SearchProvider>(context, listen: false).search(context),
                      child: Text('Search'),
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
