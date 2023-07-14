import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:provider/provider.dart';

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
  @override
  _NewProductAttributeListState createState() => _NewProductAttributeListState();
}

class _NewProductAttributeListState extends State<NewProductAttributeList> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, List<String>> _selectedAttributes = {};

  @override
  Widget build(BuildContext context) {
    return

      FutureBuilder(
        future: Provider.of<AttributeProvider>(context, listen: false).fetchCategoryFilterList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getloading4(context);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Consumer<AttributeProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
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
                                return CheckboxListTile(
                                  title: Text(child.name),
                                  value: Provider.of<SearchProvider>(context).selectedAttributes[provider.attributes[provider.selectedParentIndex].name]?.contains(child.name) ?? false,
                                  onChanged: (bool value) {
                                    if (value) {
                                      Provider.of<SearchProvider>(context, listen: false).selectAttribute(provider.attributes[provider.selectedParentIndex].name, child.name);
                                    } else {
                                      Provider.of<SearchProvider>(context, listen: false).deselectAttribute(provider.attributes[provider.selectedParentIndex].name, child.name);
                                    }
                                  },
                                );

                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _search(context),
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


  void _search(BuildContext context) async {
    print(   "the option is : "+ _selectedAttributes["option"].toString());
    print(   "the category is : "+ _selectedAttributes["category"].toString());
    print(   "the brand is : "+ _selectedAttributes["brand"].toString());
    print(   "the price is : "+ _selectedAttributes["price"].toString());
    print(   "the color is : "+ _selectedAttributes["color"].toString());
    print(   "the discount is : "+ _selectedAttributes["discount"].toString());
    // You might need to adjust this code   based on the structure of your _selectedAttributes map and the requirements of your server.
    Provider.of<SearchProvider>(context, listen: false).newSearchProduct(
      _searchController.text,
      _selectedAttributes["option"],
      _selectedAttributes["category"],
      _selectedAttributes["brand"],
      _selectedAttributes["price"]?.map((e) => double.tryParse(e))?.toList(),
      _selectedAttributes["size"],
      _selectedAttributes["color"],
      _selectedAttributes["discount"]?.map((e) => double.tryParse(e))?.toList(),
      context,
      reload: false
    );
  }

}
