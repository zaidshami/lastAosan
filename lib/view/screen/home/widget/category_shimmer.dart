import 'package:flutter/material.dart';
import '../../../../provider/category_provider.dart';
import '../../../../utill/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../basewidget/get_loading.dart';
class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: MediaQuery.of(context).size.width,
       width: MediaQuery.of(context).size.width,

     // color: Colors.deepOrange,
      //height:MediaQuery.of(context).size.height/7,
      child:GridView.builder(

          itemCount: 8,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
childAspectRatio: 1,

      ), itemBuilder: (BuildContext context, int index){
        return Container(



          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

            Expanded(
              flex: 5,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.withOpacity(0.8),
              //    child: getloading3(context)
              ),
            ),

            Expanded(flex: 3, child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorResources.getTextBg(context),
                borderRadius:  BorderRadius.circular(50),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: Provider.of<CategoryProvider>(context).categoryList.length == 0,
                child: getloading1(context),
              ),
            )),

          ]),
        );
      })


    );
  }
}
