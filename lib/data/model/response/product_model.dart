import 'dart:convert';
import 'dart:convert' as jj;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'cart_model.dart';

class ProductModel {
  int _totalSize;
  int _limit;
  int _offset;
  List<Product> _products;

  ProductModel({int totalSize, int limit, int offset, List<Product> products}) {
    this._totalSize = totalSize;
    this._limit = limit;
    this._offset = offset;
    this._products = products;
  }

  int get totalSize => _totalSize;

  int get limit => _limit;

  int get offset => _offset;

  List<Product> get products => _products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _limit = json['limit'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this._totalSize;
    data['limit'] = this._limit;
    data['offset'] = this._offset;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int _id;
  String _addedBy;
  int _userId;
  int _brand_id;
  String _name;
  String _slug;
  String _model_number;
  List<CategoryIds> _categoryIds;
  String _unit;
  List<String> _images; // List<String> _images
  String _thumbnail;
  String _img_path;
  List<ProductColors> _colors;
  List<String> _attributes;
  List<ChoiceOptions> _choiceOptions;
  List<Variation> _variation;
  double _unitPrice;
  double _purchasePrice;
  double _tax;
  int _minQty;
  String _taxType;
  double _discount;
  String _discountType;
  int _currentStock;
  String _details;
  String _details2;
  String _createdAt;
  String _updatedAt;
  List<Rating> _rating;
  double _shippingCost;
  int _isMultiPly;
  int _reviewCount;
  String _videoUrl;
  String _desc;
  List<DetailsOption> _details_option;
  List<ProductSize> _productSizeList;
  List<ProductColor> _productColorsList;
  List<ProductOption> _productOptionList;

  Product({
    int id,
    String addedBy,
    int userId,
    int brand_id,
    String name,
    String slug,
    String  model_number,
    List<CategoryIds> categoryIds,
    String unit,
    int minQty,
    List<String> images, //List<String> images
    String thumbnail,
    String img_path,
    List<ProductColors> colors,
    String variantProduct,
    List<String> attributes,
    List<ChoiceOptions> choiceOptions,
    List<Variation> variation,
    double unitPrice,
    double purchasePrice,
    double tax,
    String taxType,
    double discount,
    String discountType,
    int currentStock,
    String details,
    String details2,
    String attachment,
    String createdAt,
    String updatedAt,
    int featuredStatus,
    List<Rating> rating,
    double shippingCost,
    int isMultiPly,
    int reviewCount,
    String videoUrl,
    String desc,
    List<DetailsOption> details_option,
    List<ProductSize> productSizeList,
    List<ProductColor> productColorsList,
    List<ProductOption> productOptionLIst,
  }) {
    this._id = id;
    this._addedBy = addedBy;
    this._userId = userId;
    this._brand_id = brand_id;
    this._name = name;
    this._desc = desc;
    this._slug = slug;
    this._model_number =  model_number;
    this._categoryIds = categoryIds;
    this._unit = unit;
    this._minQty = minQty;
    this._images = images;
    this._thumbnail = thumbnail;
    this._img_path = img_path;
    this._colors = colors;
    this._attributes = attributes;
    this._choiceOptions = choiceOptions;
    this._variation = variation;
    this._unitPrice = unitPrice;
    this._purchasePrice = purchasePrice;
    this._tax = tax;
    this._taxType = taxType;
    this._discount = discount;
    this._discountType = discountType;
    this._currentStock = currentStock;
    this._details = details;
    this._details2 = details2;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._rating = rating;
    this._shippingCost = shippingCost;
    this._isMultiPly = isMultiPly;
    this._reviewCount = reviewCount;
    this._details_option = details_option;
    this._productSizeList = productSizeList;
    this._productOptionList = productOptionLIst;
    this._productColorsList = productColorsList;
    if (videoUrl != null) {
      this._videoUrl = videoUrl;
    }
  }

  int get id => _id;

  String get addedBy => _addedBy;

  int get userId => _userId;

  int get brand_id => _brand_id;

  String get name => _name;

  String get desc => _desc;

  String get slug => _slug;
  String get  model_number =>  _model_number;

  List<CategoryIds> get categoryIds => _categoryIds;

  String get unit => _unit;

  int get minQty => _minQty;

  List<String> get images => _images;

  String get thumbnail => _thumbnail;

  String get img_path => _img_path;

  List<ProductColors> get colors => _colors;

  List<String> get attributes => _attributes;

  List<ChoiceOptions> get choiceOptions => _choiceOptions;

  List<Variation> get variation => _variation;

  double get unitPrice => _unitPrice;

  double get purchasePrice => _purchasePrice;

  double get tax => _tax;

  String get taxType => _taxType;

  double get discount => _discount;

  String get discountType => _discountType;

  int get currentStock => _currentStock;

  String get details => _details;

  String get details2 => _details2;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  List<Rating> get rating => _rating;

  double get shippingCost => _shippingCost;

  int get isMultiPly => _isMultiPly;

  int get reviewCount => _reviewCount;

  String get videoUrl => _videoUrl;

  List<DetailsOption> get detailsOption => _details_option;

  List<ProductSize> get productsizelist => _productSizeList;

  List<ProductColor> get productColorsList => _productColorsList;

  ProductSize filteredproductsizelist(int index) => productsizelist[index];

  List<ProductOption> get productOptionList => _productOptionList;
  int randomizedColor  = 1;
  int randomizedSize  = 0;
  ProductVarType get productType {
    if (productsizelist.isEmpty && productColorsList.isEmpty)
      return ProductVarType.productNormal;

    if (productsizelist.isEmpty && productColorsList.isNotEmpty) {
      randomizedColor = Random().nextInt(productColorsList.length);
      return ProductVarType.productWithColor;
    }

    if (productsizelist.isNotEmpty && productColorsList.isEmpty) {
      randomizedSize = Random().nextInt(productsizelist.length);
      return ProductVarType.productWithColorSize;
    }

    return ProductVarType.productNormal;
  }


  //elementAt(new Random().nextInt(productsizelist.length))
  //elementAt(Random().nextInt(productsizelist.length))
  List<String> get productFrontImage {
    List<String> _temp = [];

    //if (productsizelist.isNotEmpty) {
    if (productType==ProductVarType.productWithColorSize) {

      productsizelist.first.images.forEach((element) {
        _temp.add(element);
      });
      

    } else if (productType==ProductVarType.productWithColor) {

      productColorsList.first.images.forEach((element) {
        _temp.add(element);
      });
    } else if(productType==ProductVarType.productNormal){

      _temp = images;
    }
    return _temp;
  }

  //}

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _brand_id = json['brand_id'];
    _name = json['name'];
    _desc = json['desc'];
    _slug = json['slug'];
    _model_number = json['model_number'];
    if (json['category_ids'] != null) {
      _categoryIds = [];
      try {
        String jsonString = jj.json.encode(json['category_ids']);

        List<Map<dynamic, dynamic>> newData =
            List<Map<dynamic, dynamic>>.from(jj.json.decode(jsonString));

        newData.forEach((v) {
          _categoryIds.add(
              CategoryIds(id: int.parse(v['id']), position: v['position']));
        });
      } catch (e) {
        String jsonString = jj.json.encode(json['category_ids']);

        List<Map<dynamic, dynamic>> newData =
            List<Map<dynamic, dynamic>>.from(jj.json.decode(jsonString));

        newData.forEach((v) {
          _categoryIds.add(
              CategoryIds(id: int.parse(v['id']), position: v['position']));
        });
      }
    }
    _unit = json['unit'];
    _minQty = json['min_qty'];
    //print("dszzz ${json['images']}");

    if (json['images'] != null) {
      _images = [];
      try {
        // _images = List<List<String>>.from(json["images"].map((x) => List<String>.from(x.map((x) => x))));

        _images = json['images'] != null ? json['images'].cast<String>() : [];
      } catch (e) {
        //print("gsfdzgsdf ${json["images"][0]}");
//        _images=[];
//         _images.add([json["images"][0]]);
        //_images = List<List<String>>.from( jsonDecode(json["images"]).map((x) => List<String>.from(x.map((x) => x))));
        json['images'] != null ? jsonDecode(json['images']).cast<String>() : [];
      }
    }
    //_images = json['images'] != null ? json['images'].cast<String>() : [];
    _thumbnail = json['thumbnail'];
    _img_path = json['img_path'];
    if (json['colors'] != null) {
      _colors = [];
      try {
        json['colors'].forEach((v) {
          _colors.add(new ProductColors.fromJson(v));
        });
      } catch (e) {
        // jsonDecode(json['colors']).forEach((v) {
        //   _colors.add(new ProductColors.fromJson(v));
        // }
        // );
      }
    }
    if (json['attributes'] != null) {
      try {

        _attributes = json['attributes'].cast<String>();
      } catch (e) {
        _attributes = jsonDecode(json['attributes']).cast<String>();
      }
    }
    if (json['choice_options'] != null) {
      _choiceOptions = [];
      try {
        json['choice_options'].forEach((v) {
          _choiceOptions.add(new ChoiceOptions.fromJson(v));
        });
      } catch (e) {
        var log = new Logger();
        log.e(e.toString());
        jsonDecode(json['choice_options']).forEach((v) {
          _choiceOptions.add(new ChoiceOptions.fromJson(v));
        });
      }
    }
    if (json['variation'] != null) {
      _variation = [];
      try {
        json['variation'].forEach((v) {
          _variation.add(new Variation.fromJson(v));
        });
      } catch (e) {
        // jsonDecode(json['variation']).forEach((v) {
        //   _variation.add(new Variation.fromJson(v));
        // });
      }
    }
    if (json['unit_price'] != null) {
      _unitPrice = json['unit_price'].toDouble();
    }
    if (json['purchase_price'] != null) {
      _purchasePrice = json['purchase_price'].toDouble();
    }

    if (json['tax'] != null) {
      _tax = json['tax'].toDouble();
    }
    _taxType = json['tax_type'];
    if (json['discount'] != null) {
      _discount = json['discount'].toDouble();
    }
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    _details = json['details'];
    _details2 = json['details2'];

    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['rating'] != null) {
      _rating = [];
      json['rating'].forEach((v) {
        _rating.add(new Rating.fromJson(v));
      });
    } else {}
    if (json['shipping_cost'] != null) {
      _shippingCost = double.parse(json['shipping_cost'].toString());
    }
    if (json['multiply_qty'] != null) {
      _isMultiPly = int.parse(json['multiply_qty'].toString());
    }
    if (json['reviews_count'] != null) {
      _reviewCount = int.parse(json['reviews_count'].toString());
    }
    if (json['details_option'] != null) {
      _details_option = [];
      try {
        json['details_option'].forEach((v) {
          _details_option.add(new DetailsOption.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['details_option']).forEach((v) {
          _details_option.add(new DetailsOption.fromJson(v));
        });
      }
    }
    _videoUrl = json['video_url'];
    // print("bbnnnn ${ json['name']}");
    if (json['product_size'] != null) {
      _productSizeList = [];
      try {
        var _temp = json['product_size'];
        // print("the z list $_temp");
        _temp.forEach((v) {
          _productSizeList.add(new ProductSize.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['product_size']).forEach((v) {
          _productSizeList.add(new ProductSize.fromJson(v));
        });
      }
    } else {
      _productSizeList = [];
    }

    if (json['product_color'] != null) {
      _productColorsList = [];
      try {
        var _temp = json['product_color'];
        // print("the z list $_temp");
        _temp.forEach((v) {
          _productColorsList.add(new ProductColor.fromJson(v));
        });
      } catch (e) {
        jsonDecode(json['product_color']).forEach((v) {
          _productColorsList.add(new ProductColor.fromJson(v));
        });
      }
    } else {
      _productColorsList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['added_by'] = this._addedBy;
    data['user_id'] = this._userId;
    data['name'] = this._name;
    data['slug'] = this._slug;
    data['model_number'] = this.model_number;
    if (this._categoryIds != null) {
      data['category_ids'] = this._categoryIds.map((v) => v.toJson()).toList();
    }
    data['unit'] = this._unit;
    data['min_qty'] = this._minQty;
    data['images'] = this._images;
    data['thumbnail'] = this._thumbnail;
    data['img_path'] = this._img_path;
    if (this._colors != null) {
      data['colors'] = this._colors.map((v) => v.toJson()).toList();
    }
    data['attributes'] = this._attributes;
    if (this._choiceOptions != null) {
      data['choice_options'] =
          this._choiceOptions.map((v) => v.toJson()).toList();
    }
    if (this._variation != null) {
      data['variation'] = this._variation.map((v) => v.toJson()).toList();
    }
    data['unit_price'] = this._unitPrice;
    data['purchase_price'] = this._purchasePrice;
    data['tax'] = this._tax;
    data['tax_type'] = this._taxType;
    data['discount'] = this._discount;
    data['discount_type'] = this._discountType;
    data['current_stock'] = this._currentStock;
    data['details'] = this._details;
    data['details2'] = this._details2;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._rating != null) {
      data['rating'] = this._rating.map((v) => v.toJson()).toList();
    }
    data['shipping_cost'] = this._shippingCost;
    data['multiply_qty'] = this._isMultiPly;
    data['reviews_count'] = this._reviewCount;
    data['video_url'] = this._videoUrl;
    data['desc'] = this._desc;
    return data;
  }
}

class ProductSize {
  ProductSize({
    this.code,
    this.size,
    this.images,
  });

  String code;
  List<Size> size;
  List<String> images;

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        code: json["code"],
        size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class Size {
  Size({
    this.id,
    this.code,
    this.name,
    this.price,
    this.qunt,
  });

  String id;
  String code;
  String name;
  String price;
  String qunt;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        code: json["code"]!=null? json["code"]:"",
        name: json["name"],
        price: json["price"],
        qunt: json["qunt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "price": price,
        "qunt": qunt,
      };
}

class CategoryIds {
  int _position;
  int _id;

  CategoryIds({int position, int id}) {
    this._position = position;
    this._id = id;
  }

  int get position => _position;

  int get id => _id;

  CategoryIds.fromJson(Map<String, dynamic> json) {
    _position = json['position'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this._position;
    data['id'] = this._id;
    return data;
  }
}

class ProductColors {
  String _name;
  String _code;

  ProductColors({String name, String code}) {
    this._name = name;
    this._code = code;
  }

  String get name => _name;

  String get code => _code;

  ProductColors.fromJson(Map<String, dynamic> json) {
    // print("ProductColors zzzaid"+json.toString());

    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['code'] = this._code;
    return data;
  }
}

class ChoiceOptions {
  String _name;
  String _title;
  List<dynamic> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name;

  String get title => _title;

  List<dynamic> get options => _options;

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    // print("zzzaid"+json.toString());
    _name = json['name'];
    _title = json['title'];
    _options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class DetailsOption {
  String _name;
  String _title;
  List<String> _options;

  ChoiceOptions({String name, String title, List<String> options}) {
    this._name = name;
    this._title = title;
    this._options = options;
  }

  String get name => _name;

  String get title => _title;

  List<String> get options => _options;

  DetailsOption.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _title = json['title'];
    _options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['title'] = this._title;
    data['options'] = this._options;
    return data;
  }
}

class Variation {
  String _type;
  double _price;
  String _sku;
  String _file;
  int _qty;

  Variation({String type, double price, String sku, int qty, String file}) {
    this._type = type;
    this._price = price;
    this._sku = sku;
    this._qty = qty;
    this._file = file;
  }

  String get file => _file;

  String get type => _type;

  double get price => _price;

  String get sku => _sku;

  int get qty => _qty;

  Variation.fromJson(Map<String, dynamic> json) {
    // print("Variation zzzaid"+json.toString());

    _type = json['type'];
    _file = json['file'];
    _price = json['price'].toDouble();
    _sku = json['sku'];
    _qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['file'] = this._file;
    data['price'] = this._price;
    data['sku'] = this._sku;
    data['qty'] = this._qty;
    return data;
  }
}

class Rating {
  String _average;
  int _productId;

  Rating({String average, int productId}) {
    this._average = average;
    this._productId = productId;
  }

  String get average => _average;

  int get productId => _productId;

  Rating.fromJson(Map<String, dynamic> json) {
    _average = json['average'].toString();
    _productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this._average;
    data['product_id'] = this._productId;
    return data;
  }
}

class ProductColor {
  ProductColor({
    this.id,
    this.code,
    this.val,
    this.price,
    this.qunt,
    this.images,
  });

  final String id;
  final String code;
  final String val;
  final String price;
  final int qunt;
  final List<String> images;

  ProductColor copyWith({
    String id,
    String code,
    String val,
    String price,
    int qunt,
    List<String> images,
  }) =>
      ProductColor(
        id: id ?? this.id,
        code: code ?? this.code,
        val: val ?? this.val,
        price: price ?? this.price,
        qunt: qunt ?? this.qunt,
        images: images ?? this.images,
      );

  factory ProductColor.fromRawJson(String str) =>
      ProductColor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        id: json["id"],
        code: json["code"],
        val: json["val"],
        price: json["price"],
        qunt: json["qunt"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "val": val,
        "price": price,
        "qunt": qunt,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

enum ProductVarType { productNormal, productWithColor, productWithColorSize }
