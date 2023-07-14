import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/wallet_transaction_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../view/screen/chat/inbox_screen.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/profile_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/animated_custom_dialog.dart';
import '../../../../view/basewidget/guest_dialog.dart';
import '../../../../view/screen/loyaltyPoint/loyalty_point_screen.dart';
import '../../../../view/screen/more/widget/html_view_Screen.dart';
import '../../../../view/screen/more/widget/sign_out_confirmation_dialog.dart';
import '../../../../view/screen/notification/notification_screen.dart';
import '../../../../view/screen/offer/offers_screen.dart';
import '../../../../view/screen/profile/profile_screen.dart';
import '../../../../view/screen/support/support_ticket_screen.dart';
import '../../../../view/screen/wallet/wallet_screen.dart';
import 'package:provider/provider.dart';

import 'faq_screen.dart';

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool isGuestMode;
  String version;
  bool singleVendor = false;
  @override
  void initState() {
    isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(!isGuestMode) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<WishListProvider>(context, listen: false).initWishList(
        context, Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode,
      );
      version = Provider.of<SplashProvider>(context,listen: false).configModel.version != null?
      Provider.of<SplashProvider>(context,listen: false).configModel.version:'version';
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      if(Provider.of<SplashProvider>(context,listen: false).configModel.walletStatus == 1){
        Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1);
      }
      if(Provider.of<SplashProvider>(context,listen: false).configModel.loyaltyPointStatus == 1){
        Provider.of<WalletTransactionProvider>(context, listen: false).getLoyaltyPointList(context,1);
      }


    }
    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel.businessMode == "single";

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(children: [
        Positioned(top: 0, left: 0, right: 0,
          child: Image.asset(Images.more_page_header,
            height: 150, fit: BoxFit.fill,
            color: Provider.of<ThemeProvider>(context).darkTheme ?
            Colors.black : Theme.of(context).primaryColor,
          ),
        ),


        Positioned(top: 40, left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                Padding(padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: Image.asset(Images.logo_with_name_image, height: 35, color: ColorResources.WHITE),
                ),
                Expanded(child: SizedBox.shrink()),
                InkWell(
                  onTap: () {
                    if(isGuestMode) {
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    }else {
                      if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel != null) {
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  child: Row(children: [
                    Text(!isGuestMode ? profile.userInfoModel != null ?
                    '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}' : 'Full Name' : 'Guest',
                        style: titilliumRegular.copyWith(color: ColorResources.WHITE)),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                    isGuestMode ? CircleAvatar(child: Icon(Icons.person, size: 35)) :
                    profile.userInfoModel == null ?
                    CircleAvatar(child: Icon(Icons.person, size: 35)) : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.logo_image, width: 35, height: 35, fit: BoxFit.fill,
                        image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.customerImageUrl}/'
                            '${profile.userInfoModel.image}',
                        imageErrorBuilder: (c, o, s) => CircleAvatar(child: Icon(Icons.person, size: 35)),
                      ),
                    ),
                  ]),
                ),
              ]);
            },
          ),
        ),


        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Provider.of<SplashProvider>(context,listen: false).configModel.walletStatus ==1?
                  TitleButton(image: Images.wallet, title: getTranslated('wallet', context),
                      navigateTo: WalletScreen()):SizedBox(),


                  Provider.of<SplashProvider>(context,listen: false).configModel.loyaltyPointStatus ==1?
                  TitleButton(image: Images.loyalty_point, title: getTranslated('loyalty_point', context),
                    navigateTo: LoyaltyPointScreen()):SizedBox(),

                  TitleButton(image: Images.offers, title: getTranslated('offers', context),
                    navigateTo: OffersScreen()),

                  TitleButton(image: Images.notification_filled, title: getTranslated('notification', context),
                      navigateTo: NotificationScreen()),

                  singleVendor?SizedBox():
                  TitleButton(image: Images.chats, title: getTranslated('chats', context),
                      navigateTo: InboxScreen()),

                  TitleButton(image: Images.preference, title: getTranslated('support_ticket', context),
                      navigateTo: SupportTicketScreen()),

                  TitleButton(image: Images.term_condition, title: getTranslated('terms_condition', context),
                      navigateTo: HtmlViewScreen(title: getTranslated('terms_condition', context),
                        url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,)),

                  TitleButton(image: Images.privacy_policy, title: getTranslated('privacy_policy', context),
                      navigateTo: HtmlViewScreen(title: getTranslated('privacy_policy', context),
                        url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,)),

                  TitleButton(image: Images.help_center, title: getTranslated('faq', context),
                      navigateTo: FaqScreen(title: getTranslated('faq', context),)),

                  TitleButton(image: Images.about_us, title: getTranslated('about_us', context),
                      navigateTo: HtmlViewScreen(title: getTranslated('about_us', context),
                        url: Provider.of<SplashProvider>(context, listen: false).configModel.aboutUs,)),

                  isGuestMode ? SizedBox() : ListTile(
                    leading: Icon(Icons.exit_to_app, color: ColorResources.getPrimary(context), size: 25),
                    title: Text(getTranslated('sign_out', context),
                        style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    onTap: () => showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;


  SquareButton({@required this.image, @required this.title, @required this.navigateTo, @required this.count, @required this.hasCount});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width / 4,
            height: width / 4,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.getPrimary(context),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(image, color: Theme.of(context).highlightColor),
                hasCount?
                Positioned(top: -4, right: -4,
                  child: Consumer<CartProvider>(builder: (context, cart, child) {
                    return CircleAvatar(radius: 7, backgroundColor: ColorResources.RED,
                      child: Text(count.toString(),
                          style: titilliumSemiBold.copyWith(color: Theme.of(context).cardColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          )),
                    );
                  }),
                ):SizedBox(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context, CupertinoPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}

