
import 'package:flutter/material.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../provider/flash_deal_provider.dart';
import '../screen/home/widget/flash_deals_view.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Function icon;
  final Function onTap;
  final Duration eventDuration;
  final bool isDetailsPage;
  final bool isFlash;
  TitleRow({@required this.title,this.icon, this.onTap, this.eventDuration, this.isDetailsPage, this.isFlash = false});

  @override
  Widget build(BuildContext context) {
    int days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration.inDays;
      hours = eventDuration.inHours - days * 24;
      minutes = eventDuration.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }
    return Container(
      decoration: isFlash? BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
       // color: Theme.of(context).primaryColor.withOpacity(.05),
      ):null,
      child: Column(
        children: [
          Row (


              children: [
                isFlash?
                Padding(
                  padding: isFlash?  EdgeInsets.only(left: MediaQuery.of(context).size.width/30):EdgeInsets.all(0),
                //  child: Image.asset(Images.flash_deal, scale: 4,),
                ):SizedBox(),
                isFlash?Text("", style: titleHeader):Text(title, style: titleHeader),
                Spacer(),
                eventDuration == null
                    ? Expanded(child: SizedBox.shrink())
                    : Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(children: [
                        SizedBox(width: 5),
                        TimerBox(time: seconds,day: getTranslated('sec', context)),
                        Text(' : ', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
                        TimerBox(time: minutes, day: getTranslated('min', context)),
                        Text(' : ', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
                        TimerBox(time: hours, day: getTranslated('hour', context)),
                        Text(' : ', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor)),
                        TimerBox(time: days, day: getTranslated('day', context),),

                        Icon(Icons.arrow_forward_ios),

                      ]),
                    ),

                Spacer(),
                icon != null
                    ? InkWell(
                    onTap: icon,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child:  SvgPicture.asset(
                        Images.filter_image,
                        height: Dimensions.ICON_SIZE_DEFAULT,
                        width: Dimensions.ICON_SIZE_DEFAULT,
                        color: ColorResources.getPrimary(context),
                      ),
                    )
                )
                    : SizedBox.shrink(),

                onTap != null && isFlash?
                InkWell(
                  onTap: onTap,
                  child: Stack(
                    children: [
                      Container(

                        width: MediaQuery.of(context).size.width/8,height: MediaQuery.of(context).size.width/6.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                          color: Theme.of(context).primaryColor.withOpacity(.3)
                        ),
                      ),
                      Positioned(left: 12,right: 12,top: 18,bottom: 18,
                        child: Container(
                          width: 20,height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Theme.of(context).primaryColor
                          ),
                            child: Icon(Icons.arrow_forward_outlined, size: 15, color: Theme.of(context).cardColor,)),
                      ),
                    ],
                  ),
                ) :
                onTap != null && !isFlash ?
                InkWell(
                  onTap: onTap,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isDetailsPage == null
                            ? Text(getTranslated('VIEW_ALL', context),
                            style: titilliumRegular.copyWith(
                              color:Colors.red,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            ))
                            : SizedBox.shrink(),
                        Icon(Icons.arrow_forward_outlined,
                          color: isDetailsPage == null ? ColorResources.getArrowButtonColor(context) : Theme.of(context).hintColor,
                          size: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ]),
                ):
                SizedBox.shrink(),
              ]),

        ],
      ),

    );
  }
}

class TimerBox extends StatelessWidget {
  final int time;
  final bool isBorder;
  final String day;

  TimerBox({@required this.time, this.isBorder = false, this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:28,height: 28,
      decoration: BoxDecoration(
        color: isBorder ? null : Colors.black,
        border: isBorder ? Border.all(width: 4, color: ColorResources.getPrimary(context)) : null,
        borderRadius: BorderRadius.circular(1),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            padding: EdgeInsets.only(top: 2),
            child: Text(time < 10 ? '0$time' : time.toString(),
              style: robotoBold.copyWith(
                color: isBorder ? Colors.white : Colors.white,
                fontSize: 10,
              ),
            ),
          ),
          Text(day, style: titilliumBold.copyWith(color: isBorder ?
          ColorResources.getPrimary(context) : Theme.of(context).highlightColor,
            fontSize:5,)),
        ],
      ),
    );
  }
}
