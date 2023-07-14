

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/provider/product_provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';



class MyQuantityCustomWidget extends StatelessWidget {
  int qty ;
  MyQuantityCustomWidget({@required this.qty});
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 5;

    return AnimationLimiter(
      child: GridView.count(
        physics:
        BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

        crossAxisCount: columnCount,
        children: List.generate(
          qty>=5 ? 5 : qty ,
              (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: 500),
              columnCount: columnCount,
              child: ScaleAnimation(
                duration: Duration(milliseconds: 800),
                curve: Curves.fastLinearToSlowEaseIn,
                scale: 1.5,
                child: FadeInAnimation(
                  child: Consumer<ProductProvider>(
                    builder: (context, value, child) =>
                    InkWell(
                      onTap: (){
                        value.qty = index + 1 ;
                        print('the chosen qty is : ' + value.qty.toString() );
                        Navigator.pop(context);},
                      child: Container(
                        child: Center(child: Text('${index+1}'),),
                        margin: EdgeInsets.only(
                            bottom: _w / 30, left: _w / 60, right: _w / 60),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}