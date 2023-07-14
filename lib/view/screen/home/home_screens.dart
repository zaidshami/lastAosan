
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/data/model/response/filter_category_1.dart';
import 'package:flutter_Aosan_ecommerce/provider/notification_provider.dart';
import 'package:flutter_Aosan_ecommerce/utill/math_utils.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/brand_view.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/home_category_product_view.dart';

import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/home_products_view.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/main_section_banner.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/products_view.dart';

import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/products_view_1.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/recomended_product_view_fixed.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/second_section_banner.dart';
import 'package:flutter_Aosan_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../../helper/product_type.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/banner_provider.dart';
import '../../../provider/brand_provider.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/featured_deal_provider.dart';
import '../../../provider/flash_deal_provider.dart';

import '../../../provider/product_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../provider/top_seller_provider.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/category_shimmer.dart';
import '../../basewidget/title_row.dart';

import '../brand/all_brand_screen.dart';
import '../featureddeal/featured_deal_screen.dart';
import '../notification/notification_screen.dart';
import '../product/product_details_screen.dart';
import '../product/view_all_product_screen.dart';
import '../search/search_screen.dart';
import '../topSeller/all_top_seller_screen.dart';
import 'widget/announcement.dart';
import 'widget/banners_view.dart';
import 'widget/category_view.dart';
import 'widget/featured_deal_view.dart';
import 'widget/featured_product_view.dart';
import 'widget/flash_deals_view.dart';
import 'widget/footer_banner.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController2;


  Future<void> _loadData(BuildContext context, bool reload) async {
    // Provider.of<HomeCategoryProductProvider>(context, listen: false).getHomeCategoryProductList(reload, context);
    // Provider.of<HomeCategoryProductProvider>(context, listen: false).getHomeCategoryProductList(reload, context);
    // Provider.of<TopSellerProvider>(context, listen: false).getTopSellerList(reload, context);
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(reload, context);
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(reload, context);
    // Provider.of<CategoryProvider>(context, listen: false).getCategoryList(reload, context);
    Provider.of<TopSellerProvider>(context, listen: false)
        .getTopSellerList(reload, context);
    var isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      // Provider.of<WishListProvider>(context, listen: false).initWishList(
      //   context,
      //   Provider.of<LocalizationProvider>(context, listen: false).locale.countryCode,);
      Provider.of<ProfileProvider>(context, listen: false)
          .initAddressList(context);
      Provider.of<ProfileProvider>(context, listen: false)
          .initAddressTypeList(context);
    }
    Provider.of<ProductProvider>(context, listen: false)
        .getRecommendedProduct(context);

    ///new
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    // _checkPermission(context);
    singleVendor = Provider.of<SplashProvider>(context, listen: false)
            .configModel
            .businessMode ==
        "single";
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotificationList(context);
    _loadData(context, false);
    // _remoteConfigFetchFuture = _fetchRemoteConfig();
  }

  Future<void> clearLists(BuildContext context,
      CategoryProvider categoryProvider, int value) async {
    Provider.of<FlashDealProvider>(context, listen: false)
        .flashDealList
        .clear();
    Provider.of<BannerProvider>(context, listen: false)
        .footerBannerList
        .clear();
    Provider.of<BannerProvider>(context, listen: false)
        .footerBannerList
        .clear();
    Provider.of<BannerProvider>(context, listen: false).mainBannerList.clear();
    Provider.of<BannerProvider>(context, listen: false)
        .secondSectionBannerList
        .clear();
    Provider.of<BrandProvider>(context, listen: false).brandList.clear();
    try {
      Provider.of<CategoryProvider>(context, listen: false)
          .categoryList[categoryProvider.categoryList[value].id]
          .subCategories
          .clear();
    } catch (v) {}
    Provider.of<FeaturedDealProvider>(context, listen: false).featuredDealProductList.clear();
    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.TOP_PRODUCT)
        .ProductList
        .clear();

    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.BEST_SELLING)
        .ProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.DISCOUNTED_PRODUCT)
        .ProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.LATEST_PRODUCT)
        .ProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.NEW_ARRIVAL)
        .ProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .get_list_type(ProductType.FEATURED_PRODUCT)
        .ProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .latestProductList
        .clear();
    Provider.of<ProductProvider>(context, listen: false)
        .featuredProductList
        .clear();
    Provider.of<FeaturedDealProvider>(context, listen: false)
        .getFeaturedDealList(
            categoryProvider.categoryList[value].id, true, context);
    Provider.of<FeaturedDealProvider>(context, listen: false)
        .getFeaturedDealList(
            categoryProvider.categoryList[value].id, true, context);
    Provider.of<BannerProvider>(context, listen: false)
        .getFooterBannerList(categoryProvider.categoryList[value].id, context);
    await Provider.of<ProductProvider>(context, listen: false).getLProductList(
        categoryProvider.categoryList[value].id, '1', context,
        reload: true);
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(categoryProvider.categoryList[value].id, true, context);
    await Provider.of<BannerProvider>(context, listen: false)
        .getMainSectionBanner(categoryProvider.categoryList[value].id, context);
    Provider.of<BannerProvider>(context, listen: false).getSecondSectionBanner(
        categoryProvider.categoryList[value].id, context);
    await Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(
            categoryProvider.categoryList[value].id, true, context, false);

    await Provider.of<BrandProvider>(context, listen: false)
        .getBrandList(categoryProvider.categoryList[value].id, true, context);
  }

  @override
  Widget build(BuildContext context) {





    Provider.of<ProductProvider>(context, listen: false)
        .featuredProductList
        .clear();
    if (Provider.of<CategoryProvider>(context).categoryList.length > 0) {
      var x = Provider.of<CategoryProvider>(context)
          .categoryList[
              Provider.of<CategoryProvider>(context).categorySelectedIndex]
          .id;
      Provider.of<BannerProvider>(context, listen: false)
          .getMainSectionBanner(x, context);
      Provider.of<BannerProvider>(context, listen: false)
          .getSecondSectionBanner(x, context);
      Provider.of<BannerProvider>(context, listen: false)
          .getFooterBannerList(x, context);
      Provider.of<BannerProvider>(context, listen: false)
          .getBannerList(x, true, context);
      Provider.of<ProductProvider>(context, listen: false)
          .getLatestProductList(x, 1, context, reload: true);

      /// new
      Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
          ProductType.NEW_ARRIVAL, x, 1, context,
          reload: true);
      Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
          ProductType.DISCOUNTED_PRODUCT, x, 1, context,
          reload: true);
      Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
          ProductType.BEST_SELLING, x, 1, context,
          reload: true);
      Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
          ProductType.TOP_PRODUCT, x, 1, context,
          reload: true);

      ///end new
      Provider.of<ProductProvider>(context, listen: false)
          .getFeaturedProductList(x, '1', context, reload: true);
      Provider.of<FeaturedDealProvider>(context, listen: false)
          .getFeaturedDealList(x, true, context);
      Provider.of<ProductProvider>(context, listen: false)
          .getLProductList(x, '1', context, reload: true);
      Provider.of<BrandProvider>(context, listen: false)
          .getBrandList(x, true, context);
      Provider.of<FlashDealProvider>(context, listen: false)
          .getMegaDealList(x, true, context, true);
    }
    List<String> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];
    return Consumer<CategoryProvider>(
      builder: (context, cProvider, child) =>
         RefreshIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        onRefresh: () async {
          try {
        await    clearLists(context,
                cProvider, cProvider.categorySelectedIndex);
          } catch (e, s) {
            print(s);
          }
         // await _loadData(context, true);
          await Provider.of<FlashDealProvider>(context, listen: false)
              .getMegaDealList(Provider.of<CategoryProvider>(context,listen: false).categoryList[cProvider
                  .categorySelectedIndex]
                  .id,
              true,
              context,
              false);


          Provider.of<ProductProvider>(context, listen: false)
              .featuredProductList
              .clear();
          if (Provider.of<CategoryProvider>(context,listen: false).categoryList.length > 0) {
            var x = Provider.of<CategoryProvider>(context,listen: false)
                .categoryList[
            Provider.of<CategoryProvider>(context,listen: false).categorySelectedIndex]
                .id;
            Provider.of<BannerProvider>(context, listen: false)
                .getMainSectionBanner(x, context);
            Provider.of<BannerProvider>(context, listen: false)
                .getSecondSectionBanner(x, context);
            Provider.of<BannerProvider>(context, listen: false)
                .getFooterBannerList(x, context);
            Provider.of<BannerProvider>(context, listen: false)
                .getBannerList(x, true, context);
            Provider.of<ProductProvider>(context, listen: false)
                .getLatestProductList(x, 1, context, reload: true);

            /// new
            Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
                ProductType.NEW_ARRIVAL, x, 1, context,
                reload: true);
            Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
                ProductType.DISCOUNTED_PRODUCT, x, 1, context,
                reload: true);
            Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
                ProductType.BEST_SELLING, x, 1, context,
                reload: true);
            Provider.of<ProductProvider>(context, listen: false).getHomeProductList(
                ProductType.TOP_PRODUCT, x, 1, context,
                reload: true);

            ///end new
            Provider.of<ProductProvider>(context, listen: false)
                .getFeaturedProductList(x, '1', context, reload: true);
            Provider.of<FeaturedDealProvider>(context, listen: false)
                .getFeaturedDealList(x, true, context);
            Provider.of<ProductProvider>(context, listen: false)
                .getLProductList(x, '1', context, reload: true);
            Provider.of<BrandProvider>(context, listen: false)
                .getBrandList(x, true, context);
            Provider.of<FlashDealProvider>(context, listen: false)
                .getMegaDealList(x, true, context, true);
          }
          return true;


        },
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor:AppConstants.textScaleFactior),
          child: SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: ColorResources.getHomeBg(context),
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: [

                      SliverAppBar(

                        toolbarHeight: MediaQuery.of(context).size.height*0.055,
                        bottom: PreferredSize(

                          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.055),
                          child: Consumer<CategoryProvider>(
                            builder: (context, categoryProvider, child) {
                              return DefaultTabController(
                                initialIndex: categoryProvider.categorySelectedIndex,
                                length: categoryProvider.categoryList.length,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  //margin: getPadding(right: 10,left: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: StatefulBuilder(builder: (context, _change) {
                                    return isloading
                                        ?
                                    //   TabBar(
                                    //     indicatorPadding: getPadding(all: 5),
                                    //
                                    //     controller: _tabController2,
                                    //     unselectedLabelColor: Colors.white,
                                    //     //  labelColor:Colors.redAccent,
                                    //     labelStyle: robotoBold.copyWith(
                                    //         fontSize: 13,
                                    //         color: ColorResources
                                    //             .getReviewRattingColor(context)),
                                    //     isScrollable: true,
                                    //
                                    //     indicatorColor: Colors.white,
                                    //     // indicatorWeight: 2.0,
                                    //     indicator: BoxDecoration(
                                    //       border: Border(
                                    //         top: BorderSide(
                                    //             color: Colors.white, width: 2.0),
                                    //         bottom: BorderSide(
                                    //             color: Colors.white, width: 2.0),
                                    //       ),
                                    //     ),
                                    // /*    onTap: (value) async {
                                    //       if (!isloading) {
                                    //         _change(() {
                                    //           isloading = true;
                                    //         });
                                    //         categoryProvider
                                    //             .changeSelectedIndex(value);
                                    //         try {
                                    //           await clearLists(context,
                                    //               categoryProvider, value);
                                    //         } catch (e, s) {
                                    //           print(s);
                                    //         }
                                    //
                                    //         // Future.delayed(const Duration(seconds: 0), () {
                                    //         _change(() {
                                    //           isloading = false;
                                    //         });
                                    //         // });
                                    //       }
                                    //     },*/
                                    //     // controller: _tabController,
                                    //     labelColor: Colors.redAccent,
                                    //     tabs: categoryProvider.categoryList
                                    //         .map((e) => Tab(height: 40,
                                    //       text: e.name,
                                    //     ))
                                    //         .toList(),
                                    //   )
                                    TabShimmer()
                                        :
                                    // Future.delayed(const Duration(seconds: 0), () {
                                    Center(
                                      child: Column(
                                        children: [
                                          TabBar(
                                            indicatorPadding: getPadding(all: 5),

                                            controller: _tabController2,
                                            unselectedLabelColor: Colors.black,
                                            //  labelColor:Colors.redAccent,
                                            labelStyle: robotoBold.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                color: ColorResources
                                                    .getReviewRattingColor(context)),
                                            isScrollable: true,

                                            indicatorColor: Colors.white,
                                            // indicatorWeight: 2.0,
                                            indicator: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.black, width: 2.0),
                                                bottom: BorderSide(
                                                    color: Colors.black, width: 2.0),
                                              ),
                                            ),
                                            onTap: (value)

                                            //todo: here add the word async
                                            {
                                              _scrollController.animateTo(
                                                0,
                                                duration: Duration(milliseconds: 100),
                                                curve: Curves.easeInOut,
                                              );
                                              if (!isloading) {
                                                _change(() {
                                                  isloading = true;
                                                });
                                                categoryProvider
                                                    .changeSelectedIndex(value);
                                                try {
                                                  clearLists(context,
                                                      categoryProvider, value);
                                                } catch (e, s) {
                                                  print(s);
                                                }

                                                // Future.delayed(const Duration(seconds: 0), () {
                                                _change(() {
                                                  isloading = false;
                                                });
                                                // });
                                              }
                                            },
                                            // controller: _tabController,
                                            labelColor: Colors.redAccent,
                                            tabs: categoryProvider.categoryList
                                                .map((e) => Tab(

                                              height: 40,
                                              text: e.name,
                                            ))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    );

                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                        pinned: true,
                        floating: true,
                        elevation: 0,
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Theme.of(context).highlightColor,
                        title: Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(context,
                                  CupertinoPageRoute(builder: (_) => SearchScreen(
                                    Attribute(id: int.parse(AppConstants.categoryId),
                                    name: "",childes:
                                        [Child(id: Provider.of<CategoryProvider>(context,listen: false).getCatId().toString(),name: "")])
                                  ))),
                              child: Container(

                                height: MediaQuery.of(context).size.height*0.05,
                                padding: getPadding(top: 5),
                                color: ColorResources.getHomeBg(context),
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[
                                          Provider.of<ThemeProvider>(context)
                                              .darkTheme
                                              ? 900
                                              : 200],
                                          spreadRadius: 1,
                                          blurRadius: 1)
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(children: [
                                    Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                          getTranslated('SEARCH_HINT', context),
                                          style: robotoRegular.copyWith(
                                              color: Theme.of(context).hintColor)),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => NotificationScreen()));
                              },
                              icon:
                              Stack(children: <Widget>[
                                Image.asset(
                                  Images.notification,
                                  height: Dimensions.ICON_SIZE_DEFAULT,
                                  width: Dimensions.ICON_SIZE_DEFAULT,
                                  color: ColorResources.getPrimary(context),
                                ),
                                Provider.of<NotificationProvider>(context,
                                    listen: false)
                                    .notificationList
                                    .length
                                    .toString() ==
                                    '0'
                                    ? SizedBox()
                                    : Positioned(
                                  top: -0,
                                  right: -0,
                                  child: Consumer<NotificationProvider>(
                                      builder: (context, cart, child) {
                                        return CircleAvatar(
                                          radius: 6,
                                          backgroundColor: /*_pageIndex==2? ColorResources.BLACK:*/
                                          Colors.red,
                                          child: Text(
                                            cart.notificationList.length.toString(),
                                            style: titilliumSemiBold.copyWith(
                                              color: ColorResources.WHITE,
                                              fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ])
                            /* Stack(clipBehavior: Clip.none, children: [
                              Image.asset(
                                Images.notification,
                                height: Dimensions.ICON_SIZE_DEFAULT,
                                width: Dimensions.ICON_SIZE_DEFAULT,
                                color: ColorResources.getPrimary(context),
                              ),
                            ]),*/
                          ),
                        ],
                      ) ,// search bar
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            ),

                            ///second section banner
                            // Provider.of<BannerProvider>(context, listen: false).secondSectionBannerList!= null &&       Provider.of<BannerProvider>(context, listen: false).secondSectionBannerList.length >0?
                            //  Consumer<BannerProvider>(builder: (context, footerBannerProvider, child) {return footerBannerProvider.secondSectionBannerList != null && footerBannerProvider.secondSectionBannerList.length > 0


                                 // : SizedBox();
                            // }),


                         if (AppConstants.bannerFirst)
                          SecondSectionBannersView(index: 0),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING/2),
                          AppConstants.categoryType1=='true'?  CategoryView(isHomePage: true):SizedBox(),
                            if (!AppConstants.bannerFirst)
                              Column(
                                children: [

                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  if(AppConstants.bannersView)
                                    BannersView(

                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width * 0.4,

                                  ),
                                  if(!AppConstants.bannersView)
                                    SecondSectionBannersView(index: 0),
                                ],
                              ),
                            if (AppConstants.bannerFirst)
                              Column(
                                children: [

                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  if(AppConstants.bannersView)
                                    BannersView(

                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width * 0.4,

                                    ),
                                  if(!AppConstants.bannersView)
                                    Provider.of<BannerProvider>(context, listen: false).secondSectionBannerList !=
                                        null &&
                                        Provider.of<BannerProvider>(context, listen: false).secondSectionBannerList.length >=
                                            1? SecondSectionBannersView(index: 0):SizedBox(),
                                ],
                              ),




                            /// ctegory filter new vertical and horizntal mayneed num1

                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            ///flash deal  solved in all sections
                            // Mega Deal

                            Provider.of<FlashDealProvider>(context, listen: false)
                                        .flashDealList !=
                                    null
                                ? Consumer<FlashDealProvider>(
                                    builder: (context, flashDeal, child) {
                                      return (flashDeal.flashDeal != null &&
                                              flashDeal.flashDealList != null &&
                                              flashDeal.flashDealList.length > 0)
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 2, right: 2),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      height: Dimensions
                                                          .HOME_PAGE_PADDING),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Consumer<FlashDealProvider>(
                                                          builder: (context, megaDeal,
                                                              child) {
                                                            return (megaDeal.flashDeal != null &&
                                                                    megaDeal.flashDealList !=
                                                                        null &&
                                                                    megaDeal.flashDealList
                                                                            .length >
                                                                        0)
                                                                ? Container(
                                                                    height: 325,
                                                                    child:
                                                                        FlashDealsView())
                                                                : SizedBox.shrink();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    //color: Theme.of(context).primaryColor.withOpacity(0.2),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox.shrink();
                                    },
                                  )
                                : SizedBox(),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            ///Brand
                           AppConstants.showBrand?
                               Consumer<BrandProvider>(
                              builder: (context, brandProvider, child) {
                                return brandProvider.brandList.length > 0
                                    ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL,
                                          right: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL,
                                          bottom: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: TitleRow(
                                          title:
                                          getTranslated('brand', context),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        AllBrandScreen()));
                                          }),
                                    ),
                                    SizedBox(
                                        height:
                                        Dimensions.PADDING_SIZE_SMALL),
                                    BrandView(isHomePage: true),
                                  ],
                                )
                                    : Container();
                              },
                            ):SizedBox  (),
                            /// top seller num3
                            AppConstants.showTopSeller?
                                Column(children: [
                                  singleVendor?SizedBox():
                                  TitleRow(title: getTranslated('top_seller', context),
                                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => AllTopSellerScreen(topSeller: null,)));},),
                                  singleVendor?SizedBox(height: 0):SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  singleVendor?SizedBox():
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: Dimensions.HOME_PAGE_PADDING),
                                    child: TopSellerView(isHomePage: true),
                                  ),
                                ],):SizedBox(),

                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            /// Featured Products
                            Consumer<ProductProvider>(
                                builder: (context, featured, _) {
                              return featured.featuredProductList != null &&
                                      featured.featuredProductList.length > 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          //  left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                          left: 15,
                                          right: 25,
                                          bottom:
                                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: Dimensions.PADDING_SIZE_SMALL),
                                        child: TitleRow(
                                            title: getTranslated(
                                                'featured_products', context),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (_) => AllProductScreen(
                                                          productType: ProductType
                                                              .FEATURED_PRODUCT)));
                                            }),
                                      ),
                                    )
                                  : SizedBox();
                            }),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Dimensions.HOME_PAGE_PADDING),
                              child: FeaturedProductView(
                                scrollController: _scrollController,
                                isHome: true,
                              ),
                            ),


                            /// feature deals fixed
                            Column(
                              children: [
                                //title
                                Consumer<FeaturedDealProvider>(
                                  builder: (context, featuredDealProvider, child) {
                                    return featuredDealProvider.featuredDealProductList !=
                                                null &&
                                            featuredDealProvider
                                                    .featuredDealProductList.length >
                                                0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                //  left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                                left: 15,
                                                right: 25,
                                                bottom:
                                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                            child: TitleRow(
                                                title: getTranslated(
                                                    'featured_deals', context),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (_) =>
                                                              FeaturedDealScreen()));
                                                }),
                                          )
                                        : SizedBox.shrink();
                                  },
                                ),
                                //body
                                Consumer<FeaturedDealProvider>(
                                  builder: (context, featuredDealProvider, child) {
                                    return featuredDealProvider.featuredDealProductList !=
                                        null &&
                                        featuredDealProvider
                                            .featuredDealProductList.length >
                                            0
                                        ? Container(
                                        height:
                                        350, //featuredDealProvider.featuredDealProductList.length> 4 ? 200 * 4.0 : 200 * (double.parse(featuredDealProvider.featuredDealProductList.length.toString())),
                                        child: FeaturedDealsView())
                                        : SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),


                            ///recomended product num4

                            //new recomended fixed
                            Provider.of<ProductProvider>(context, listen: false)
                                        .recommendedProduct !=
                                    null
                                ? InkWell(
                                    onTap: () {
                                   Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              transitionDuration:
                                                  Duration(milliseconds: 1000),
                                              pageBuilder: (context, anim1, anim2) =>
                                                  ProductDetails(
                                                      product: Provider.of<
                                                                  ProductProvider>(
                                                              context,
                                                              listen: false)
                                                          .recommendedProduct)));
                                    },
                                    child: RecommendedProductCard1(),
                                  )
                                : SizedBox(),

                            // NewCardRecomendedProduct(),

                            /// Latest Products
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            //footer banner list
                            SingleChildScrollView(
                              child: Consumer<BannerProvider>(
                                  builder: (context, footerBannerProvider, child) {
                                return footerBannerProvider.footerBannerList !=
                                            null &&
                                        footerBannerProvider
                                                .footerBannerList.length >=
                                            1
                                    ? Container(
                                        height: ((MediaQuery.of(context).size.width *
                                                footerBannerProvider
                                                    .footerBannerList.length) /
                                            2.1),
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: footerBannerProvider
                                              .footerBannerList.length,
                                          itemBuilder: (context, index) => Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: FooterBannersView(index: index),
                                          ),
                                        ),
                                      )
                                    : SizedBox();
                              }),
                            ),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            /// Category Filter horizontal num5

                            HomeProductView(
                                isHomePage: true,
                                productType: ProductType.NEW_ARRIVAL,
                                scrollController: _scrollController),
                            //  Provider.of<BannerProvider>(context, listen: false).mainSectionBannerList.length >=1 ?     MainSectionBannersView(index: Random().nextInt(  Provider.of<BannerProvider>(context, listen: false).mainSectionBannerList.length),):SizedBox(),
                            //  FooterBannersView(index:Random().nextInt( Provider.of<BannerProvider>(context, listen: false).footerBannerList.length) ),

                            ///main section banner
                            Consumer<BannerProvider>(
                                builder: (context, footerBannerProvider, child) {
                              return footerBannerProvider.mainSectionBannerList !=
                                          null &&
                                      footerBannerProvider
                                              .mainSectionBannerList.length >
                                          0
                                  ? MainSectionBannersView(
                                      index: Random().nextInt(footerBannerProvider
                                          .mainSectionBannerList.length),
                                    )
                                  : SizedBox();
                            }),
                            SizedBox(
                              height: 5,
                            ),

                            ///footer  banner
                            Consumer<BannerProvider>(
                                builder: (context, footerBannerProvider, child) {
                              return footerBannerProvider.footerBannerList != null &&
                                      footerBannerProvider.footerBannerList.length > 0
                                  ? FooterBannersView(
                                      index: Random().nextInt(footerBannerProvider
                                          .footerBannerList.length))
                                  : SizedBox();
                            }),

                            ///main section banner with builder num6

                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            ///discount product

                            HomeProductView(
                                isHomePage: true,
                                productType: ProductType.DISCOUNTED_PRODUCT,
                                scrollController: _scrollController),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            HomeProductView(
                                isHomePage: true,
                                productType: ProductType.BEST_SELLING,
                                scrollController: _scrollController),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            ///main section banner
                            Consumer<BannerProvider>(
                                builder: (context, footerBannerProvider, child) {
                              return footerBannerProvider.mainSectionBannerList !=
                                          null &&
                                      footerBannerProvider
                                              .mainSectionBannerList.length >
                                          0
                                  ? MainSectionBannersView(
                                      index: Random().nextInt(footerBannerProvider
                                          .mainSectionBannerList.length),
                                    )
                                  : SizedBox();
                            }),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            ///footer  banner
                            Consumer<BannerProvider>(
                                builder: (context, footerBannerProvider, child) {
                              return footerBannerProvider.footerBannerList != null &&
                                      footerBannerProvider.footerBannerList.length > 0
                                  ? FooterBannersView(
                                      index: Random().nextInt(footerBannerProvider
                                          .footerBannerList.length))
                                  : SizedBox();
                            }),
                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            HomeProductView(
                                isHomePage: true,
                                productType: ProductType.TOP_PRODUCT,
                                scrollController: _scrollController),

                            SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            Consumer<BannerProvider>(
                                builder: (context, footerBannerProvider, child) {
                              return footerBannerProvider.mainSectionBannerList !=
                                          null &&
                                      footerBannerProvider
                                              .mainSectionBannerList.length >
                                          0
                                  ? MainSectionBannersView(
                                      index: Random().nextInt(footerBannerProvider
                                          .mainSectionBannerList.length),
                                    )
                                  : SizedBox();
                            }),

                            /// ctegory filter new vertical tab controller num7

                            ///Home Category view of num8
                            HomeCategoryProductView(isHomePage: true),
                            // SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                            /// the widget of احدث المنتجات num9

                            /// this is the widget that shows the products horizontally without title row num10

                            ///category filter very new vertical and horizntal num11

                            /// Category Filter
                            Column(
                              children: [
                                Consumer<ProductProvider>(
                                    builder: (ctx, prodProvider, child) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: Row(children: [
                                      Expanded(
                                          child: Text(
                                              prodProvider.title == 'xyz'
                                                  ? getTranslated('new_arrival', context)
                                                  : prodProvider.title,
                                              style: titleHeader)),
                                      prodProvider.latestProductList != null
                                          ? PopupMenuButton(
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                      value: ProductType.NEW_ARRIVAL,
                                                      child: Text(getTranslated(
                                                          'new_arrival', context)),
                                                      textStyle: robotoRegular.copyWith(
                                                        color:
                                                            Theme.of(context).hintColor,
                                                      )),
                                                  PopupMenuItem(
                                                      value: ProductType.TOP_PRODUCT,
                                                      child: Text(getTranslated(
                                                          'top_product', context)),
                                                      textStyle: robotoRegular.copyWith(
                                                        color:
                                                            Theme.of(context).hintColor,
                                                      )),
                                                  PopupMenuItem(
                                                      value: ProductType.BEST_SELLING,
                                                      child: Text(getTranslated(
                                                          'best_selling', context)),
                                                      textStyle: robotoRegular.copyWith(
                                                        color:
                                                            Theme.of(context).hintColor,
                                                      )),
                                                  PopupMenuItem(
                                                      value:
                                                          ProductType.DISCOUNTED_PRODUCT,
                                                      child: Text(getTranslated(
                                                          'discounted_product', context)),
                                                      textStyle: robotoRegular.copyWith(
                                                        color:
                                                            Theme.of(context).hintColor,
                                                      )),
                                                ];
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      Dimensions.PADDING_SIZE_SMALL)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.PADDING_SIZE_SMALL,
                                                    vertical:
                                                        Dimensions.PADDING_SIZE_SMALL),
                                                child: Image.asset(
                                                  Images.dropdown,
                                                  scale: 3,
                                                ),
                                              ),
                                              onSelected: (value) {
                                                if (value == ProductType.NEW_ARRIVAL) {
                                                  Provider.of<ProductProvider>(context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[0]);
                                                } else if (value ==
                                                    ProductType.TOP_PRODUCT) {
                                                  Provider.of<ProductProvider>(context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[1]);
                                                } else if (value ==
                                                    ProductType.BEST_SELLING) {
                                                  Provider.of<ProductProvider>(context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[2]);
                                                } else if (value ==
                                                    ProductType.DISCOUNTED_PRODUCT) {
                                                  Provider.of<ProductProvider>(context,
                                                          listen: false)
                                                      .changeTypeOfProduct(
                                                          value, types[3]);
                                                }
                                                Provider.of<ProductProvider>(context,
                                                        listen: false)
                                                    .getLatestProductList(
                                                        Provider.of<CategoryProvider>(
                                                                context,
                                                                listen: false)
                                                            .categoryList[Provider.of<
                                                                        CategoryProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .categorySelectedIndex]
                                                            .id,
                                                        1,
                                                        context,
                                                        reload: true);

                                                // ProductView(
                                                //     isHomePage: false,
                                                //     productType: value,
                                                //     scrollController:
                                                //         _scrollController);
                                              })
                                          : SizedBox(),
                                    ]),
                                  );
                                }),
                                ProductView1(
                                    isHomePage: false,
                                    productType: ProductType.NEW_ARRIVAL,
                                    scrollController: _scrollController),
                                Container(
                                  height: 40,
                                  color: Colors.transparent,
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Provider.of<SplashProvider>(context, listen: false)
                              .configModel
                              .announcement
                              .status ==
                          '1'
                      ? Positioned(
                          top: MediaQuery.of(context).size.height - 128,
                          left: 0,
                          right: 0,
                          child: Consumer<SplashProvider>(
                            builder: (context, announcement, _) {
                              return (announcement.configModel.announcement
                                              .announcement !=
                                          null &&
                                      announcement.onOff)
                                  ? AnnouncementScreen(
                                      announcement:
                                          announcement.configModel.announcement)
                                  : SizedBox();
                            },
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
