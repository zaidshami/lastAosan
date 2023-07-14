import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../data/model/response/order_model.dart';
import '../../../../helper/date_converter.dart';
import '../../../../helper/price_converter.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../view/screen/order/order_details_screen.dart';


class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidget({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => OrderDetailsScreen(orderModel: orderModel,
                orderId: orderModel.id, orderType: orderModel.orderType,
                extraDiscount: orderModel.extraDiscount,
                extraDiscountType: orderModel.extraDiscountType)));},


      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5)),


        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(getTranslated('ORDER_ID', context),
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel.id.toString(), style: titilliumSemiBold),
            ]),


            Row(children: [
              Text(
                  DateConverter.localDateToIsoStringAMPM1(DateTime.parse(orderModel.createdAt)

                  ),
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).hintColor,
              )),
            ]),

          ]),
          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),



          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(getTranslated('total_price', context),
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text(PriceConverter.convertPrice(context, orderModel.orderAmount), style: titilliumSemiBold),
            ]),
          ),


          Container(alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: ColorResources.getLowGreen(context),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(orderModel.orderStatus.toUpperCase(), style: titilliumSemiBold),
          ),

        ]),
      ),
    );
  }
}


class OrderWidgetNew extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidgetNew({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => OrderDetailsScreen(orderModel: orderModel,
                orderId: orderModel.id, orderType: orderModel.orderType,
                extraDiscount: orderModel.extraDiscount,
                extraDiscountType: orderModel.extraDiscountType)));},


      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5)),


        child: Column(

            children: [
              Row(children: [
                Text(getTranslated('ORDER_ID', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              Spacer(),
                Text(orderModel.id.toString(), style: titilliumSemiBold),
                SizedBox(width: 20,)

              ]),
              SizedBox(height: 5,),
              Row(children: [
                Text(getTranslated('Time_of_order', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                Spacer(),
                Text(
                    DateConverter.localDateToIsoStringAMPM1(DateTime.parse(orderModel.createdAt)

                    ),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: Theme.of(context).hintColor,
                    )),
                SizedBox(width: 20,)

              ]),
              SizedBox(height: 5,),
              Row(children: [
                Text(getTranslated('total_price', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                Spacer(),
                Text(PriceConverter.convertPrice(context, orderModel.orderAmount), style: titilliumSemiBold),
                SizedBox(width: 20,)

              ]),
              SizedBox(height: 5,),
              Row(children: [
                Text(getTranslated('Status', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: ColorResources.getLowGreen(context),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                      getTranslated('${orderModel.orderStatus}', context) ,
                     // orderModel.orderStatus,
                      style: titilliumSemiBold),
                ),
                SizedBox(width: 20,)
              ]),
              SizedBox(height: 5,),



          // Expanded(
          //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //     Text(getTranslated('total_price', context),
          //         style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
          //     Text(PriceConverter.convertPrice(context, orderModel.orderAmount), style: titilliumSemiBold),
          //   ]),
          // ),
          //
          //
          // Container(alignment: Alignment.center,
          //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          //   decoration: BoxDecoration(
          //     color: ColorResources.getLowGreen(context),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Text(orderModel.orderStatus.toUpperCase(), style: titilliumSemiBold),
          // ),

        ]),
      ),
    );
  }
}