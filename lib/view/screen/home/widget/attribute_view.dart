import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_Aosan_ecommerce/provider/attributes_provider.dart';
import 'package:flutter_Aosan_ecommerce/provider/search_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';

import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/attribute_widget.dart';

import 'package:provider/provider.dart';

import '../../../../provider/product_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/images.dart';


class AttributesView extends StatelessWidget {
  final int index;

  AttributesView({this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<AttributeProvider>(
      builder: (context, provider, child) {
        final attribute = index > provider.attributes.length ? provider.attributes[0] : provider.attributes[index];

        if (attribute == null || (attribute.name!='الألوان'&& attribute.name!='المقاسات')) {
          return SizedBox();
        }

        return Column(
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: attribute.name=='الألوان' ?Text(
                  ' إختر لونك المفضل',
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(fontSize: 16),
                )
                :attribute.name=='المقاسات'?
                Text(
                  'تسوق حسب القياس',
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(fontSize: 16),
                ):   Text(
                  'ماهي ${attribute.name} الذي تبحث عنها ؟',
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attribute.childes.length,
                itemBuilder: (context, index) {
                  // Sort the childes list based on count in descending order
                  attribute.childes.sort((a, b) => b.count.compareTo(a.count));

                  final child = attribute.childes[index];
                  return InkWell(
                    onTap: () async {
                      // Provider.of<SearchProvider>(context, listen: false).selectedAttributes!=null||
                      //     Provider.of<SearchProvider>(context, listen: false).selectedAttributes.isNotEmpty?
                      // Provider.of<SearchProvider>(context, listen: false).removeAllAttributes():null;
                      attribute.name=='الألوان'?Provider.of<SearchProvider>(context, listen: false).selectAttribute1 (0.toString(), child.id):
                      attribute.name=='المقاسات'?Provider.of<SearchProvider>(context, listen: false).selectAttribute1 (81.toString(), child.id):null;

                      Provider.of<ProductProvider>(context,listen: false).isFiltring = true;
                      Provider.of<SearchProvider>(context, listen: false).cleanSearchProduct();

                      await   Provider.of<SearchProvider>(context, listen: false).search(context,reload: true);

                      // Provider.of<ProductProvider>(context,listen: false).selectedSub= null;
                      Provider.of<ProductProvider>(context,listen: false).clearOurList();
               /*       print("Clicked: ${child.name}");
                      print("Clicked: ${child.id}");*/
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: attribute.name == "الألوان" ? 0 : 8),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: attribute.name == "الألوان" ? 4 : 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: attribute.name == "الألوان"
                          ? Container(
                        width: 60,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 10,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(int.parse('0xFF${child.code.substring(1)}')),
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              flex: 20,
                              child: Text(
                                child.name,
                                style: robotoRegular.copyWith(fontSize: 10),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                child.count.toString(),
                                style: robotoRegular.copyWith(fontSize: 10, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )
                          : Center(
                        child: Text(
                          child.name ?? '',
                          style: robotoBold.copyWith(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        );
      },
    );
  }
}

