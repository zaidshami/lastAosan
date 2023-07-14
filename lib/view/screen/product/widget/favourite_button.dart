import 'package:flutter/material.dart';
import '../../../../data/model/response/product_model.dart';
import '../../../../provider/auth_provider.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../utill/images.dart';
import '../../../../view/basewidget/animated_custom_dialog.dart';
import '../../../../view/basewidget/guest_dialog.dart';
import '../../../../view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final Product product;
  FavouriteButton({this.backgroundColor = Colors.black, this.favColor = Colors.white, this.isSelected = false, this.product});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();


    feedbackMessage(String message) {
      if (message != '') {
        showCustomSnackBar(message, context, isError: false);
      }
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isGuestMode) {
              showAnimatedDialog(context, GuestDialog(), isFlip: true);
            } else {
              Provider.of<WishListProvider>(context, listen: false).checkWishList(product.id)  ?
              Provider.of<WishListProvider>(context, listen: false).removeWishList(product, feedbackMessage: feedbackMessage) :
              Provider.of<WishListProvider>(context, listen: false).addWishList(product, feedbackMessage: feedbackMessage);
            }
          },
          child:
         Consumer<WishListProvider>(
           builder: (context, value, child) {
             return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                color: Theme.of(context).cardColor,
                child: Padding(padding: EdgeInsets.all(8),
                  child: Image.asset(
                    value.checkWishList(product.id) ? Images.wish_image : Images.wishlist1,
                    color: favColor, height: 16, width: 16,
                  ),
                )
            );
           },
         ),
        ),
      ],
    );
  }
}
