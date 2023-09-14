import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/search_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/filter_category_1.dart';
import '../../localization/language_constrants.dart';
import '../../provider/product_provider.dart';
import '../../provider/search_provider.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../../utill/math_utils.dart';

class NewProductAttributeList extends StatefulWidget {

  Attribute searchAttribute;
  bool isCategory ;
  String catId;

   NewProductAttributeList(this.searchAttribute,this.catId,{this.isCategory= false} );
  @override
  _NewProductAttributeListState createState() => _NewProductAttributeListState();
}

class _NewProductAttributeListState extends State<NewProductAttributeList> {
  Future<void> future;

  @override
  void initState() {
    String seearchText = Provider.of<SearchProvider>(context, listen: false).searchController.text.toString();

    super.initState();
   Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter = widget.isCategory;
    Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter?seearchText = '' :null;
    Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter? Provider.of<SearchProvider>(context, listen: false).searchController.text = '' :null;
    future = Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(seearchText,widget.catId);
    Provider.of<AttributeProvider>(context, listen: false).selectParent(1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttributeProvider>(
      builder: (context, value, child) =>
     FutureBuilder(
        key: ValueKey(Provider.of<AttributeProvider>(context, listen: false).isCategoryFilter),
        future: future, // use the future variable here
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
                        try{ selectedAttributes[widget.searchAttribute.id.toString()] =widget.searchAttribute.getChildIds;}catch(e){}

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
                                  onPressed: () async {
                                    String searchText = Provider.of<SearchProvider>(context,listen: false).searchController.text;
                                    provider.selectedCount= 0 ;
                                    print("search is  var: "+ searchText);

                                    print("search is controller before: "+  Provider.of<SearchProvider>(context,listen: false).searchController.text);
                                    Provider.of<SearchProvider>(context,listen: false).clearFilters();
                                    Provider.of<SearchProvider>(context,listen: false).searchController.text = searchText;
                                    await Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterListCatNew(searchText,widget.catId);


                                  }
                                  ,icon: Text(getTranslated('remove_all', context))),
                            ),

                          ],

                         ),

                        ///the name of the search text
                        Provider.of<SearchProvider>(context,listen: false).searchController.text!=null &&Provider.of<SearchProvider>(context,listen: false).searchController.text.isNotEmpty?

                          Center(
                            child:  Text('${Provider.of<SearchProvider>(context,listen: false).searchController.text}',style: robotoBold,)) :SizedBox(),

                        Padding(
                         padding: getPadding(top: 0),
                         child: Wrap(

                            spacing: 8,
                            children: selectedAttributes.entries.map((entry) {
                              var attributeId = entry.key;
                              var selectedChildIds = entry.value;
                              // Use the function in your widget
                              var grouped = groupChildrenByAttribute(selectedChildIds, provider.attributes);
                              List<Widget> children = [];
                              grouped.forEach((attributeName, childNames) {
                                children.add(
                                  Text(
                                    attributeName + ': ' + childNames.join('-'),
                                    style: robotoRegular,
                                  ),
                                );
                              });

                              Wrap(
                                spacing: 4,
                                children: children,
                              );
                              // Check if there are selected child attributes before showing the Card
                              if (selectedChildIds.isNotEmpty) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: children,
                                    ),
                                  ),
                                );
                              } else {
                                // Return an empty Container if there are no selected child attributes
                                return Container();
                              }
                            }).toList(),
                          ),
                       ),
                        Expanded(
                          flex: 9,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                  padding: getPadding(all: 3),
                                  itemCount: provider.attributes.length,
                                  itemBuilder: (context, index) {
                                    var item = provider.attributes[index];
                                    return ListTile(
                                      title: Text(
                                        item.name,
                                        style: robotoBold.copyWith(
                                          color: provider.selectedParentIndex == item.id ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        provider.selectParent(item.id);

                                        provider.fetchCategoryFilterListCatAgain(   Provider.of<SearchProvider>(context, listen: false).searchText, Provider.of<SearchProvider>(context, listen: false).filterEncode());

                                        } ,
                                      tileColor: provider.selectedParentIndex == item.id ? Colors.black : null,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Builder(
                                    builder: (_) {
                                      var searchProvider = Provider.of<SearchProvider>(context, listen: false);

                                      int parentType =
                                          provider.attributes.firstWhere((element) => element.id == provider.selectedParentIndex).type;
                                      var val = searchProvider.selectedAttributes[provider.selectedParentIndex.toString()];
                                      List<Child> childList = [];

                                      if (provider.attributes.where((element) => element.id == provider.selectedParentIndex).isNotEmpty) {
                                        childList = provider.attributes.firstWhere((element) => element.id == provider.selectedParentIndex).childes;
                                      }

                                      return ListView(
                                        children: childList.map((child) {
                                          return buildChildWidgets(child, provider.selectedParentIndex.toString(), val, searchProvider,parentType,provider);
                                        }).toList(),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),

                    /*  provider.isCategoryFilter?*/
                      Padding(
                          padding:getPadding(bottom: 20,left: 16,right: 16),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set background color to black
                              alignment: Alignment.center,

                              minimumSize: MaterialStateProperty.all<Size>(Size(MediaQuery.of(context).size.width, 50)), // Set width to 200 and height to 50
                            ),
                            onPressed: () async {


                              Provider.of<ProductProvider>(context,listen: false).isFiltring = true;
                              Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();

                              await   Provider.of<SearchProvider>(context, listen: false).search(context,reload: true);

                             // Provider.of<ProductProvider>(context,listen: false).selectedSub= null;
                              Provider.of<ProductProvider>(context,listen: false).clearOurList();
                              Navigator.pop(context);

                            },
                            child: Center(
                            child:     Row(
                              children: [
                                Spacer(),
                                Text(
                                  getTranslated('show_results', context),
                                ),
                                provider.selectedCount!=0 &&    provider.selectedCount!= null?
                                Text(
                                  provider.selectedCount.toString(),
                                ):SizedBox(),
Spacer()
                              ],
                            )
                            )
                          ),
                        )


                      ],
                    );
                  },
                );
              }
            },
          ),
    )
   ;
  }



}



Widget buildChildWidgets(
    Child child,
    String parentId,
    List<String> val,
    SearchProvider searchProvider,
    int type,
    AttributeProvider attributeProvider,
    ) {
  return child.childes == null || child.childes.isEmpty
      ?
  CheckboxListTile(
    // enabled: child.count != 0,
    activeColor: Colors.black,

    title: type == 4
        ? Row(
      children: [
        child.name=='متعدد الوان'?
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
          child: ClipOval(
            child: Image.asset(
              Images.multi_color,
              fit: BoxFit.cover,
            ),
          ),
        )

            :
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(int.parse('0xFF${child.code.substring(1)}')),
          ),
        ),
        SizedBox(width: 10,),
        Text(
          child.name,
          style: robotoRegular,
        ),
        Spacer(),
        Text(
          child.count.toString(),
          style: robotoRegular.copyWith(color: Colors.grey),
        ),
        Spacer()
      ],
    )
        : Row(
      children: [
        Text(
          child.name,
          style: robotoRegular,
        ),
        Spacer(),
        Text(
          child.count.toString(),
          style: robotoRegular.copyWith(color: Colors.grey),
        ),
        Spacer()
      ],
    ),
    value: val.where((element) => element == child.id).isNotEmpty,
    onChanged: (bool value) {
      // attributeProvider.fetchCategoryFilterListCatAgain(  searchProvider.searchText,searchProvider.filterEncode());
      if (value) {

        searchProvider.selectAttribute(parentId, child.id);
        print('the parent is :'+ parentId);
        print('the child is :'+ child.id);
        attributeProvider.selectedCountIncrement(child.count);
        print('selected item count is :'+ child.count.toString());

      } else {
        searchProvider.deselectAttribute(parentId, child.id);
        attributeProvider.selectedCountDecrement(child.count);
      }
    },
  )
      : ExpansionTile(
    iconColor: Colors.grey,
    textColor: Colors.grey,
    collapsedIconColor: Colors.black,
    title: Row(
      children: [

        Text(child.name),
        Spacer(),
        Text(
          child.count.toString(),
          style: robotoRegular,
        ),
        Checkbox(
             activeColor: Colors.black,

          value: val.where((element) => element == child.id).isNotEmpty,
          onChanged: (bool value) {
            // attributeProvider.fetchCategoryFilterListCatAgain(  searchProvider.searchText,searchProvider.filterEncode());
            if (value) {
              searchProvider.selectAttribute(parentId, child.id);
              // print('the parent is :' + parentId);
              // print('the child is :' + child.id);
              attributeProvider.selectedCountIncrement(child.count);
              // print('selected item count is :' + child.count.toString());
            } else {
              searchProvider.deselectAttribute(parentId, child.id);
              attributeProvider.selectedCountDecrement(child.count);
            }
          },
        ),
      ],
    ),
    children: child.childes.map((subChild) {
      return buildChildWidgets(subChild, parentId, val, searchProvider, type, attributeProvider);
    }).toList(),
  );
}


String getChildNameById(List<Child> children, String childId) {
  for (var child in children) {
    if (child.id == childId) {
      return child.name;
    }
    if (child.childes.isNotEmpty) {
      String result = getChildNameById(child.childes, childId);
      if (result != null) {
        return result;
      }
    }
  }
  return null;
}

Map<String, List<String>> groupChildrenByAttribute(List<String> selectedChildIds, List<Attribute> attributes) {
  Map<String, List<String>> grouped = {};
  for (var childId in selectedChildIds) {
    for (var attribute in attributes) {
      var childName = getChildNameById(attribute.childes, childId);
      if (childName != null) {
        if (!grouped.containsKey(attribute.name)) {
          grouped[attribute.name] = [childName];
        } else {
          grouped[attribute.name].add(childName);
        }
        break;
      }
    }
  }
  return grouped;
}

