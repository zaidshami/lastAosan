import 'package:flutter/material.dart';
import 'package:flutter_Aosan_ecommerce/utill/custom_themes.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/product_details_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/images.dart';
import '../../../../utill/math_utils.dart';
import '../../../../view/basewidget/animated_custom_dialog.dart';
import '../../../../view/basewidget/guest_dialog.dart';
import '../../../../view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final Product product;
  final isDetails;

//the keyboard has aproblem
  FavouriteButton(
      {this.isDetails = false,
      this.backgroundColor = Colors.black,
      this.favColor = Colors.white,
      this.isSelected = false,
      this.product});

  @override
  Widget build(BuildContext context) {
    int wishCount =
        Provider.of<ProductDetailsProvider>(context, listen: false).wishCount;
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }
    return Consumer<WishListProvider>(
      builder: (context, value, child) => Column(
        children: [
          GestureDetector(
            onTap: () {
              if (isGuestMode) {
                showAnimatedDialog(context, GuestDialog(), isFlip: true);
              } else {
                if (Provider.of<WishListProvider>(context, listen: false)
                    .checkWishList(product.id)) {
                  Provider.of<WishListProvider>(context, listen: false)
                      .removeWishList(product,
                          feedbackMessage: feedbackMessage);
                  wishCount--;
                } else {
                  Provider.of<WishListProvider>(context, listen: false)
                      .addWishList(product, feedbackMessage: feedbackMessage);
                  wishCount++;
                }
              }
            },
            child: Consumer<WishListProvider>(
              builder: (context, value, child) {
                return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Center(
                            child: Image.asset(
                              value.checkWishList(product.id)
                                  ? Images.wish_image
                                  : Images.wishlist1,
                              color: favColor,
                              height: 20,
                              width: 20,
                            ),
                          ),
                          isDetails && wishCount != null && wishCount != 0
                              ? Padding(
                                  padding: getPadding(right: 4, top: 5),
                                  child: Consumer<ProductDetailsProvider>(
                                      builder: (context, value, child) => Text(
                                          '${wishCount.toString()}',
                                          style: robotoBold)),
                                )
                              : SizedBox()
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
