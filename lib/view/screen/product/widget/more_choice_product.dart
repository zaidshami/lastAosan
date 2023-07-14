import 'package:flutter/cupertino.dart';
import 'package:flutter_Aosan_ecommerce/data/model/response/product_model.dart';

import '../../../../utill/custom_themes.dart';

class MoreChoiceProduct extends StatelessWidget {

  final Product productModel;

  const MoreChoiceProduct({@required this.productModel}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("المزيد من الخيارات",style:titilliumSemiBold.copyWith(
            fontSize: 20,
          ),),
          ListView.builder(

              itemBuilder: (context, index) =>
            Container()
            )
        ],
      ),
    );
  }
}
