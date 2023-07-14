import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../view/basewidget/custom_app_bar.dart';


class SpecificationScreen extends StatelessWidget {
  final String specification;
  SpecificationScreen({@required this.specification});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();


    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: getTranslated('specification', context)),

        Expanded(child: SingleChildScrollView(child: Html(data: specification,


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

          },),)),

      ]),
    );
  }
}
