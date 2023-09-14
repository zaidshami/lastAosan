import 'package:flutter/material.dart';
import '../../../../provider/category_provider.dart';
import '../../../../utill/color_resources.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../basewidget/get_loading.dart';
/*
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
*/
class CategoryShimmer extends StatelessWidget {
  final double height;
  final double width;

  CategoryShimmer({this.height = 70, this.width = 70});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8), // Added some spacing between the image and the text
        Container(
          height: 10,
          width: width,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}



class CategoryShimmerGrid extends StatelessWidget {
  final int count ;

  const CategoryShimmerGrid({this.count})  ;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.85,
        crossAxisSpacing: 15,
      ),
      itemCount: count,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return CategoryShimmer();
      },
    );
  }
}

class CategoryShimmerList extends StatelessWidget {
  final int count ;

  const CategoryShimmerList({ this.count}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: count,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return CategoryShimmer(height: 80, width: 80);
        },
      ),
    );
  }
}
