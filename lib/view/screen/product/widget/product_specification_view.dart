import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/product/widget/product_specifications_expandable.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
// import 'package:getwidget/components/accordion/gf_accordion.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/basewidget/title_row.dart';
import '../../../../view/screen/product/specification_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({ this.productSpecification });

  @override
  Widget build(BuildContext context) {


    // if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Column(
      children: [
        // GFAccordion(
        //   title: 'Flutter Easy Solution',
        //   content: 'Flutter Easy Solution is an Amazing app that offers you multiple interfaces using filters with its source code',
        // ),

        TitleRow(title: getTranslated('specification', context), isDetailsPage: true,),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


        productSpecification.isNotEmpty ?
        Expanded(child: Html(data: productSpecification,

          style: {
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: EdgeInsets.all(6),
              alignment: Alignment.topLeft,
            ),

          },),
        ) :
        Center(child: Text('No specification')),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        InkWell(
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => SpecificationScreen(specification: productSpecification))),
            child: Text(getTranslated('view_full_detail', context),
              style: titleRegular.copyWith(color: Theme.of(context).primaryColor),))

      ],
    );
  }
}

