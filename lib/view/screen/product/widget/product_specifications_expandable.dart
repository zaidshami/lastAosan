import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
// import 'package:getwidget/getwidget.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';

/// this class uses this library getwidget


class SimpleExpandablePage extends StatelessWidget {
  final String productSpecification;
  final String modelNumber;
  final String productSpecification2;

  SimpleExpandablePage({ @required this.productSpecification2,@required this.productSpecification, @required this.modelNumber});
  static const routeName = '/SimpleExpandablePage_';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// ----------------------------------------------------------
          /// First expandable widget
          /// ----------------------------------------------------------
          productSpecification != null||modelNumber!=null ?
          SizedBox():SizedBox()
        //   GFAccordion(
        //     collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.2),
        //     contentBackgroundColor: Colors.transparent,
        // expandedTitleBackgroundColor:Colors.white,
        //     titleChild:Text( getTranslated('specification', context), style: titilliumSemiBold.copyWith(fontSize: 15),),
        //     contentChild:
        //         Column(
        //           children: [
        //             productSpecification !=null ? Html(
        //               data: productSpecification,
        //
        //               style: {
        //                 "html": Style(
        //                     fontFamily: 'Tajawal',
        //                     fontSize: FontSize(13),
        //                     fontWeight: FontWeight.bold,
        //                     color: Colors.grey
        //                 ),
        //                 "table": Style(
        //                   backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
        //                   fontFamily: 'Tajawal',
        //                   fontSize: FontSize(15),
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //                 "tr": Style(
        //                   border: Border(bottom: BorderSide(color: Colors.grey)),
        //                   fontSize: FontSize(15),
        //                   fontWeight: FontWeight.bold,
        //                   fontFamily: 'Tajawal',
        //                 ),
        //                 "th": Style(
        //                   padding: EdgeInsets.all(6),
        //                   backgroundColor: Colors.grey,
        //                   fontFamily: 'Tajawal',
        //                   fontSize: FontSize(15),
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //                 "td": Style(
        //                   padding: EdgeInsets.all(6),
        //                   alignment: Alignment.topLeft,
        //                   fontFamily: 'Tajawal',
        //                   fontSize: FontSize(15),
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               },
        //             ) : SizedBox(),
        //             modelNumber !=null ? Align(
        //               alignment: Alignment.centerRight,
        //               child: Text('رقم الموديل:'+"   "+modelNumber,style: titilliumRegular.copyWith(
        //                   fontSize: Dimensions.FONT_SIZE_DEFAULT,color: Colors.grey,),),
        //             ) : SizedBox(),
        //
        //           ],
        //         ),
        //
        //   ):SizedBox(),
        //   productSpecification2!=null?  GFAccordion(
        //     collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.2),
        //     contentBackgroundColor: Colors.transparent,
        //     expandedTitleBackgroundColor:Colors.white,
        //     titleChild:Text('الوصف', style: titilliumSemiBold.copyWith(fontSize: 15),),
        //     contentChild:
        //     productSpecification2 !=null ?
        //     Html(
        //       data: productSpecification2,
        //
        //       style: {
        //         "html": Style(
        //           fontFamily: 'Tajawal',
        //           fontSize: FontSize(13),
        //           fontWeight: FontWeight.bold,
        //         ),
        //         "table": Style(
        //           backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
        //           fontFamily: 'Tajawal',
        //           fontSize: FontSize(15),
        //           fontWeight: FontWeight.bold,
        //         ),
        //         "tr": Style(
        //           border: Border(bottom: BorderSide(color: Colors.grey)),
        //           fontSize: FontSize(15),
        //           fontWeight: FontWeight.bold,
        //           fontFamily: 'Tajawal',
        //         ),
        //         "th": Style(
        //           padding: EdgeInsets.all(6),
        //           backgroundColor: Colors.grey,
        //           fontFamily: 'Tajawal',
        //           fontSize: FontSize(15),
        //           fontWeight: FontWeight.bold,
        //         ),
        //         "td": Style(
        //           padding: EdgeInsets.all(6),
        //           alignment: Alignment.topLeft,
        //           fontFamily: 'Tajawal',
        //           fontSize: FontSize(15),
        //           fontWeight: FontWeight.bold,
        //         ),
        //       },
        //     )
        //         :
        //   SizedBox(),
        //   ):SizedBox(),

          /// ----------------------------------------------------------
          /// Second expandable widget with icons
          /// ----------------------------------------------------------
          // GFAccordion(
          //     title: 'Flutter Easy Solution',
          //     content: 'Flutter Easy Solution is an Amazing app that offers you multiple interfaces using filters with its source code',
          //     collapsedIcon: Icon(Icons.add),
          //     expandedIcon: Icon(Icons.minimize)),

          /// ----------------------------------------------------------
          /// Third expandable widget with TExt
          /// ----------------------------------------------------------
          // GFAccordion(
          //     title: 'Flutter Easy Solution',
          //     content: 'Flutter Easy Solution is an Amazing app that offers you multiple interfaces using filters with its source code',
          //     collapsedIcon: Icon(Icons.remove_red_eye),
          //     expandedIcon: Text('اخفاء')),
        ],
      ),
    );
  }
}


