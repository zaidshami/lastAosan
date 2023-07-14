import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/basewidget/get_loading.dart';
import 'package:provider/provider.dart';

import '../../provider/filter_provider.dart';

class AttributeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<FilterCategoryProvider>(context, listen: false).fetchAttributes(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Consumer<FilterCategoryProvider>(
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
                          onTap: () => provider.selectParent(index),  // Use selectParent method
                          tileColor: provider.selectedParentIndex == index ? Colors.blue : null,  // Use selectedParentIndex property
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: ListView(
                      children: provider.children[provider.attributes[provider.selectedParentIndex].id]?.map((child) {
                        return ListTile(
                          title: Text(child.name),
                          // Add more fields as needed
                        );
                      })?.toList() ?? [],
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
}
//
// class AttributeList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Provider.of<FilterCategoryProvider>(context, listen: false).fetchAttributes(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Consumer<FilterCategoryProvider>(
//             builder: (context, provider, child) {
//               return ListView.builder(
//                 itemCount: provider.attributes.length,
//                 itemBuilder: (context, index) {
//                   return ExpansionTile(
//                     title: Text(provider.attributes[index].name),
//                     children: provider.children[provider.attributes[index].id]?.map((child) {
//                       return ListTile(
//                         title: Text(child.name),
//                         // Add more fields as needed
//                       );
//                     })?.toList() ?? [],
//                   );
//                 },
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }/*