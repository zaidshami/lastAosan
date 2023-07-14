import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/product_model.dart';
import '../../../provider/product_details_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/images.dart';


final _transformationController = TransformationController();
TapDownDetails _doubleTapDetails;
class ProductsImageView extends StatefulWidget {
  final Product product;
  List<String> imagesList;

  ProductsImageView({this.product,@required this.imagesList });

  @override
  State<ProductsImageView> createState() => _ProductsImageViewState();
}

class _ProductsImageViewState extends State<ProductsImageView> {
  @override
  void initState() {
    Provider.of<ProductDetailsProvider>(
        context,
        listen:
        false)
        .setImageSliderSelectedIndexZero();
    // Provider.of<ProductProvider>(context, listen: false)
    //     .setImageSliderSelectedIndex(0);
    Provider.of<ProductProvider>(
        context,
        listen:
        false).selectImageIndex =0 ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
print("the imageeeee buid and " +    Provider.of<ProductDetailsProvider>(
    context,
    listen:
    false)
    .imageSliderIndex.toString());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [


            ///the photo on top
            Expanded(
              flex: 8,
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) => Stack(
                  fit: StackFit.expand,
                    children: [


                      Consumer<ProductDetailsProvider>(
                        builder: (context, details, child) =>
                      Container(

                            child: GestureDetector(
                              onTap:(){
                                Provider.of<ProductDetailsProvider>(
                                    context,
                                    listen:
                                    false)
                                    .setImageSliderSelectedIndexZero();
                              },
                              //onDoubleTapDown: _handleDoubleTapDown,
                        //  onDoubleTap: _handleDoubleTap,
                              child: InteractiveViewer(
                             transformationController: _transformationController,
                                child: PhotoViewGallery.builder(

                 scaleStateChangedCallback:nextScaleStateCycle,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  builder: (BuildContext context, int index) {
                                    return PhotoViewGalleryPageOptions(

                                      initialScale:PhotoViewComputedScale.covered,
                                      minScale: PhotoViewComputedScale.contained * 1,
                                      maxScale: PhotoViewComputedScale.covered * 2,
                                        //childSize: MediaQuery.of(context).size,
                                      imageProvider: CachedNetworkImageProvider(
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/'
                                          '${widget.imagesList[Provider.of<ProductProvider>(context, listen: false)
                                          .selectImageIndex]}'),
                                   //   initialScale: PhotoViewComputedScale.contained * 0.8,
                                      heroAttributes: PhotoViewHeroAttributes(tag: widget.imagesList[index]),
                                    );
                                  },
                                  itemCount: widget.imagesList.length,
                                  loadingBuilder: (context, event) => Center(
                                    child: GestureDetector(
                                     // onDoubleTapDown: _handleDoubleTapDown,
                                      //onDoubleTap: _handleDoubleTap,
                                      child: InteractiveViewer(
                                        transformationController: _transformationController,
                                        child: CachedNetworkImage(

                                          fit: BoxFit.contain,
                                          errorWidget: (context, url, error) => Image.asset(
                                            Images.placeholder,
                                            fit: BoxFit.contain,
                                          ),
                                          placeholder: (context, url) =>
                                              Image.asset(Images.placeholder, fit: BoxFit.contain),
                                          imageUrl:
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/'
                                              '${widget.imagesList[Provider.of<ProductProvider>(context, listen: false)
                                              .selectImageIndex]}',),
                                      ),
                                    ),
                                  ),


                                  onPageChanged: (v){
                                    print(  Provider.of<ProductProvider>(context, listen: false).selectImageIndex);
                                    Provider.of<ProductProvider>(context, listen: false).selectImageIndex<widget.imagesList.length-1 ?    Provider.of<ProductProvider>(context, listen: false).selectImageIndex ++ :  Provider.of<ProductProvider>(context, listen: false).selectImageIndex = 0 ;


                                  },
                                ),
                              ),
                            )
                        ),
                      ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(50)),
                        //color: Colors.grey.withOpacity(.5),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

          /// the rest of the photos of the product
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: widget.imagesList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {


                      Provider.of<ProductProvider>(context, listen: false)
                          .setImageSliderSelectedIndex(index);
                    },
                    child: Container(
                        margin: EdgeInsets.all(4),
                        child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) => Image.asset(
                                  Images.placeholder,
                                  fit: BoxFit.cover,
                                ),
                            placeholder: (context, url) =>
                                Image.asset(Images.placeholder),
                            imageUrl:
                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/'
                                '${widget.imagesList[index]}')

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PhotoViewScaleState nextScaleStateCycle(PhotoViewScaleState actual) {
  print('actual--');
  print(actual);
  switch (actual) {
    case PhotoViewScaleState.initial:
      return PhotoViewScaleState.covering;
 case PhotoViewScaleState.zoomedOut:
      return PhotoViewScaleState.zoomedOut;
    case PhotoViewScaleState.originalSize:
      return  PhotoViewScaleState.zoomedIn;
    case PhotoViewScaleState.initial:
    case PhotoViewScaleState.covering:
      return PhotoViewScaleState.initial;
    default:
      return PhotoViewScaleState.zoomedOut;
  }
}