import '../../../../data/model/response/product_model.dart';

class OrderDetailsModel {
  int _id;
  int _orderId;
  int _productId;
  int _sellerId;
  Product _productDetails;
  int _qty;
  double _price;
  double _tax;
  double _discount;
  String _deliveryStatus;
  String _paymentStatus;
  String _createdAt;
  String _updatedAt;
  int _shippingMethodId;
  String _variant;
  int _refundReq;
  String _color ;
  String _size ;
  String _product_details_img ;
  //List<Variation> _variation;

  OrderDetailsModel(
      {int id,
        int orderId,
        int productId,
        int sellerId,
        Product productDetails,
        int qty,
        double price,
        double tax,
        double discount,
        String deliveryStatus,
        String paymentStatus,
        String createdAt,
        String updatedAt,
        int shippingMethodId,
        String variant,
        int refundReq,
        String color ,
        String size ,
        String product_details_img ,


        //List<Variation> variation
      }) {
    this._id = id;
    this._orderId = orderId;
    this._productId = productId;
    this._sellerId = sellerId;
    this._productDetails = productDetails;
    this._qty = qty;
    this._price = price;
    this._tax = tax;
    this._discount = discount;
    this._deliveryStatus = deliveryStatus;
    this._paymentStatus = paymentStatus;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._shippingMethodId = shippingMethodId;
    this._variant = variant;
    this._refundReq = refundReq;
    this._color = color;
    this._size = size ;
    this._product_details_img = product_details_img ;
    //this._variation = variation;
  }

  int get id => _id;
  int get orderId => _orderId;
  int get productId => _productId;
  int get sellerId => _sellerId;
  Product get productDetails => _productDetails;
  int get qty => _qty;
  double get price => _price;
  double get tax => _tax;
  double get discount => _discount;
  String get deliveryStatus => _deliveryStatus;
  String get paymentStatus => _paymentStatus;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  int get shippingMethodId => _shippingMethodId;
  String get variant => _variant;
  String get color => _color;
  String get size => _size;
  String get product_details_img => _product_details_img;
  int get refundReq => _refundReq;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _orderId = json['order_id'];
    _productId = json['product_id'];
    _sellerId = json['seller_id'];
    if(json['product_details'] != null) {
      _productDetails = Product.fromJson(json['product_details']);
    }
    _qty = json['qty'];
    _price = json['price'].toDouble();
    _tax = json['tax'].toDouble();
    _discount = json['discount'].toDouble();
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _shippingMethodId = json['shipping_method_id'];
    _variant = json['variant'];
    _size = json['size'];
    _product_details_img = json['product_details_img'];
    _color = json['color'];
    _refundReq = json['refund_request'];
    /*if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation.add(new Variation.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['order_id'] = this._orderId;
    data['product_id'] = this._productId;
    data['seller_id'] = this._sellerId;
    if(this._productDetails != null) {
      data['product_details'] = this._productDetails.toJson();
    }
    data['qty'] = this._qty;
    data['price'] = this._price;
    data['tax'] = this._tax;
    data['discount'] = this._discount;
    data['delivery_status'] = this._deliveryStatus;
    data['payment_status'] = this._paymentStatus;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['shipping_method_id'] = this._shippingMethodId;
    data['variant'] = this._variant;
    data['color'] = this._color;
    data['size'] = this._size;
    data['product_details_img'] = this._product_details_img;
    data['refund_request'] = this._refundReq;
    /*if (this._variation != null) {
      data['variation'] = this._variation.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
