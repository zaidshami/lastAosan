import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../data/model/response/product_model.dart';
class CartModel {
  int _id;
  String _image;
  String _name;
  String _thumbnail;
  int _sellerId;
  String _sellerIs;
  String _seller;
  double _price;
  double _discountedPrice;
  int _quantity;
  int _maxQuantity;
  String _variant;
  String _color;
  int _qty_check;

  //Variation _variation;
  double _discount;
  String _discountType;
  double _tax;
  String _taxType;
  int shippingMethodId;
  String _cartGroupId;
  String _shopInfo;
 // List<ChoiceOptions> _choiceOptions;
 // List<int> _variationIndexes;
  double  _shippingCost;
  String _shippingType;

  VariationModel ivariationModel ;
  ProductOption  iproductModel  ;
  String get imagePath{
    if(productType==1){
    return  thumbnail;
    } if(productType==2||productType==3){
      return  productModel.image;
    }
  }


  int get productType{
    if(productModel==null){
     return 1;
    }if(productModel!=null&&productModel.id.trim()==""){
      return 2;
    }if(productModel!=null&&productModel.id.trim()!=""){
      return 3;
    }else{
      return 1;
    }

  }

  CartModel(
      this._id, this._thumbnail, this._name, this._seller, this._price, this._discountedPrice, this._quantity, this._maxQuantity, this._variant, this._color,/*this._qty_check*/
    //  this._variation,
      this._discount, this._discountType, this._tax, this._taxType, this.shippingMethodId, this._cartGroupId,this._sellerId, this._sellerIs,
      this._image, this._shopInfo,
    //  this._choiceOptions, this._variationIndexes,
      this._shippingCost,
      {@required this.ivariationModel, this.iproductModel });

  String get variant => _variant;
  String get color => _color;
  int get qty_check => _qty_check;
 // Variation get variation => _variation;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int value) {
    _quantity = value;
  }


  int get maxQuantity => _maxQuantity;
  double get price => _price;
  double get discountedPrice => _discountedPrice;
  String get name => _name;
  String get seller => _seller;
  String get image => _image;
  int get id => _id;
  double get discount => _discount;
  String get discountType => _discountType;
  double get tax => _tax;
  String get taxType => _taxType;
  String get cartGroupId => _cartGroupId;
  String get sellerIs => _sellerIs;
  int get sellerId => _sellerId;
  String get thumbnail => _thumbnail;


  String get shopInfo => _shopInfo;
  // List<ChoiceOptions> get choiceOptions => _choiceOptions;
  // List<int> get variationIndexes => _variationIndexes;
  double get  shippingCost => _shippingCost;
  String get  shippingType => _shippingType;
  VariationModel get  variationModel => ivariationModel;
  ProductOption get  productModel => iproductModel;



  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _seller = json['seller'];

    _thumbnail = json['thumbnail'];
    _sellerId = int.parse(json['seller_id'].toString());
    _sellerIs = json['seller_is'];
    _image = json['image'];
    _price = json['price'].toDouble();
    _discountedPrice = json['discounted_price'];
    _quantity = int.parse(json['quantity'].toString());
    _maxQuantity = json['max_quantity'];
    _variant = json['variant'];
    _color = json['color'];
    _qty_check = json['qty_check'];
   // _variation = json['variation'] != null ? Variation.fromJson(json['variation']) : null;
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _tax = json['tax'].toDouble();
    _taxType = json['tax_type'];
    shippingMethodId = json['shipping_method_id'];
    _cartGroupId = json['cart_group_id'];
    _shopInfo = json['shop_info'];
    iproductModel=json['product_option']!=null?ProductOption.fromJson(json['product_option']):null;
    // if (json['choice_options'] != null) {
    //   _choiceOptions = [];
    //   json['choice_options'].forEach((v) {_choiceOptions.add(new ChoiceOptions.fromJson(v));
    //   });
    // }
    // _variationIndexes = json['variation_indexes'] != null ? json['variation_indexes'].cast<int>() : [];
    // if(json['shipping_cost'] != null){
    //   _shippingCost =double.parse(json['shipping_cost'].toString());
    // }
    if(json['shipping_type'] != null){
      _shippingType = json['shipping_type'];
    }


  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['seller'] = this._seller;
    data['image'] = this._image;
    data['price'] = this._price;
    data['discounted_price'] = this._discountedPrice;
    data['quantity'] = this._quantity;
    data['max_quantity'] = this._maxQuantity;
    data['variant'] = this._variant;
    data['color'] = this._color;
    data['qty_check'] = this._qty_check;
    //  data['variation'] = this._variation;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['tax'] = this._tax;
    data['tax_type'] = this._taxType;
    data['shipping_method_id'] = this.shippingMethodId;
    data['cart_group_id'] = this._cartGroupId;
    data['thumbnail'] = this._thumbnail;
    data['seller_id'] = this._sellerId;
    data['seller_is'] = this._sellerIs;
    data['shop_info'] = this._shopInfo;
    // if (this._choiceOptions != null) {
    //   data['choice_options'] = this._choiceOptions.map((v) => v.toJson()).toList();
    // }
    // data['variation_indexes'] = this._variationIndexes;
    data['shipping_cost'] = this._shippingCost;
    data['_shippingType'] = this._shippingType;
    return data;
  }
  set thumbnail (index){
    if (productModel.image!=null){
      thumbnail= productModel.image;

    }      else  this._thumbnail;
  }
}
class VariationModel{


  String product_color;
  String product_size;

  VariationModel(
      {
        this.product_color="",this.product_size=""
      });

  Map<String, dynamic> toJson(String id,String quantity, ) {
    final Map<String, dynamic> data = new Map<String, dynamic>();

     data['id'] = id;
     data['quantity'] = quantity;
    this.product_color.trim().length>0 ?   data['product_color'] = "\"${this.product_color}\"":"";
    this.product_size.trim().length>0  ?    data['product_size'] = "\"${this.product_size}\"":"";
    return data;
  }

}
class ProductOption {
  ProductOption({
    this.color,
    this.colorVal,
    this.price,
    this.qunt,
    this.image,
    this.id="",this.name=""
  });

  final String color;
  final String colorVal;
  final String price;
  final String qunt;
  final String image;
  final String id;
  final String name;


  ProductOption copyWith({
    String color,
    String colorVal,
    String price,
    String qunt,
    String image='',
    String id,
    String name,
  }) =>
      ProductOption(
        color: color ?? this.color,
        colorVal: colorVal ?? this.colorVal,
        price: price ?? this.price,
        qunt: qunt ?? this.qunt,
        image: image ?? this.image,
      );

  factory ProductOption.fromRawJson(String str) => ProductOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
    color: json["color"],
    colorVal: json["color_val"],
    price: json["price"],
    qunt: json["qunt"].toString(),
    image: json["image"],
    id: json["id"]!=null?json["id"]:"",
    name: json["name"]!=null?json["name"]:""
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "color_val": colorVal,
    "price": price,
    "qunt": qunt,
    "image": image,
  };
}






///the variation clas is always empty
// class VariationsClass {
//   VariationsClass({
//     this.empty,
//   });
//
//   final dynamic empty;
//
//   VariationsClass copyWith({
//     dynamic empty,
//   }) =>
//       VariationsClass(
//         empty: empty ?? this.empty,
//       );
//
//   factory VariationsClass.fromRawJson(String str) => VariationsClass.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory VariationsClass.fromJson(Map<String, dynamic> json) => VariationsClass(
//     empty: json["المقاس"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "المقاس": empty,
//   };
// }

///old choice option
// class ChoicesClass {
//   ChoicesClass({
//     this.choice81,
//   });
//
//   final dynamic choice81;
//
//   ChoicesClass copyWith({
//     dynamic choice81,
//   }) =>
//       ChoicesClass(
//         choice81: choice81 ?? this.choice81,
//       );
//
//   factory ChoicesClass.fromRawJson(String str) => ChoicesClass.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory ChoicesClass.fromJson(Map<String, dynamic> json) => ChoicesClass(
//     choice81: json["choice_81"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "choice_81": choice81,
//   };
// }
