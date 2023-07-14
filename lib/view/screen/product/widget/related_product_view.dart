import 'package:flutter/material.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/product_provider.dart';
import '../../../../view/basewidget/product_shimmer.dart';
import '../../../../view/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../basewidget/product_widget_new.dart';

class RelatedProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, prodProvider, child) {
        return Column(children: [
          prodProvider.relatedProductList != null
              ? prodProvider.relatedProductList.length != 0
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: prodProvider.relatedProductList.length,
                      shrinkWrap: true,
                      crossAxisSpacing: 0,
                      physics: NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductWidgetNew(
                            productModel:
                                prodProvider.relatedProductList[index]);
                      },
                    )
                  : Center(child: Text(getTranslated("no_data_found", context)))
              : ProductShimmer(
                  isHomePage: false,
                  isEnabled: Provider.of<ProductProvider>(context)
                          .relatedProductList ==
                      null),
        ]);
      },
    );
  }
}
