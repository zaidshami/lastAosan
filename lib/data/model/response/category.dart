class Category {
  int _id;
  String _name;
  String _name2;
  String _slug;
  String _icon;
  int _parentId;
  int _position;
  String _createdAt;
  String _updatedAt;
  List<SubCategory> _subCategories;
  void addSubCategory(SubCategory subCategory) {
    if (_subCategories == null) {
      _subCategories = [];
    }
    _subCategories.add(subCategory);
  }
  Category(
      {int id,
        String name,
        String name2,
        String slug,
        String icon,
        int parentId,
        int position,
        String createdAt,
        String updatedAt,
        List<SubCategory> subCategories}) {
    this._id = id;
    this._name = name;
    this._name2 = name2;
    this._slug = slug;
    this._icon = icon;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._subCategories = subCategories;
  }

  int get id => _id;
  String get name => _name;
  String get name2 => _name2;
  String get slug => _slug;
  String get icon => _icon;
  int get parentId => _parentId;
  int get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<SubCategory> get subCategories => _subCategories;
  List<SubCategory> get subCategorieswithoutall => subCategories.getRange(1, _subCategories.length).toList();

  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _name2 = json['name2'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      _subCategories = [];
      _subCategories.add(SubCategory(name: "اعرض الكل",id: json['id'],subSubCategories: showAll(json),icon:json['icon'] ));

      json['childes'].forEach((v) {
        _subCategories.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['name2'] = this._name2;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._subCategories != null) {
      data['childes'] = this._subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

List<SubSubCategory> showAll(var jsaon){

List<SubSubCategory> _subSubCategories=[];
List<SubCategory>  subCategories =[];
jsaon['childes'].forEach((v) {
  subCategories.add(new SubCategory.fromJson(v));
});
subCategories.forEach((element) {
  _subSubCategories.add(SubSubCategory(id: element.id,name: element.name,icon: element.icon));

});
return _subSubCategories;
}


class SubCategory {
  int _id;
  String _name;
  String _name2;
  String _slug;
  String _icon;
  String _icon2;
  int _parentId;
  int _position;
  String _createdAt;
  String _updatedAt;
  List<SubSubCategory> _subSubCategories;

  SubCategory(
      {int id,
        String name,
        String name2,
        String slug,
        String icon,
        String icon2,
        int parentId,
        int position,
        String createdAt,
        String updatedAt,
        List<SubSubCategory> subSubCategories}) {
    this._id = id;
    this._name = name;
    this._name2 = name2;
    this._slug = slug;
    this._icon = icon;
    this._icon2 = icon2;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._subSubCategories = subSubCategories;
  }

  int get id => _id;
  String get name => _name;
  String get name2 => _name2;
  String get slug => _slug;
  String get icon => _icon;
  String get icon2 => _icon2;
  int get parentId => _parentId;
  int get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<SubSubCategory> get subSubCategories => _subSubCategories;
  List<SubSubCategory> get subSubCategorieswithoutall => subSubCategories.getRange(1, _subSubCategories.length).toList();


  SubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _name2 = json['name2'];
    _slug = json['slug'];
    _icon = json['icon'];
    _icon2 = json['icon2'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      _subSubCategories = [];
      _subSubCategories.add(SubSubCategory(name: "اعرض الكل "  ,id: json['id'],icon:json['icon'] ));


      json['childes'].forEach((v) {
        _subSubCategories.add(new SubSubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['name2'] = this._name2;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['icon2'] = this._icon2;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._subSubCategories != null) {
      data['childes'] = this._subSubCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubSubCategory {
  int _id;
  String _name;
  String _name2;
  String _slug;
  String _icon;
  String _icon2;
  int _parentId;
  int _position;
  String _createdAt;
  String _updatedAt;
  List<SubSubSubCategory> _subSubSubCategories;

  SubSubCategory(
      {int id,
        String name,
        String name2,
        String slug,
        String icon,
        String icon2,
        int parentId,
        int position,
        String createdAt,
        String updatedAt,
        List<SubSubSubCategory> subSubSubCategories,
      }) {
    this._id = id;
    this._name = name;
    this._name2 = name2;
    this._slug = slug;
    this._icon = icon;
    this._icon2 = icon2;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._subSubSubCategories = subSubSubCategories;


  }

  int get id => _id;
  String get name => _name;
  String get name2 => _name2;
  String get slug => _slug;
  String get icon => _icon;
  String get icon2 => _icon2;
  int get parentId => _parentId;
  int get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  List<SubSubSubCategory> get subSubSubCategories => _subSubSubCategories;

  SubSubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _name2 = json['name2'];
    _slug = json['slug'];
    _icon = json['icon'];
    _icon2 = json['icon2'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['name2'] = this._name2;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['icon2'] = this._icon2;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }


}



class SubSubSubCategory {
  int _id;
  String _name;
  String _name2;
  String _slug;
  String _icon;
  String _icon2;
  int _parentId;
  int _position;
  String _createdAt;
  String _updatedAt;

  SubSubSubCategory(
      {int id,
        String name,
        String name2,
        String slug,
        String icon,
        String icon2,
        int parentId,
        int position,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._name = name;
    this._name2 = name2;
    this._slug = slug;
    this._icon = icon;
    this._icon2 = icon2;
    this._parentId = parentId;
    this._position = position;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get name2 => _name2;
  String get slug => _slug;
  String get icon => _icon;
  String get icon2 => _icon2;
  int get parentId => _parentId;
  int get position => _position;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  SubSubSubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _name2 = json['name2'];
    _slug = json['slug'];
    _icon = json['icon'];
    _icon2 = json['icon2'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['name2'] = this._name2;
    data['slug'] = this._slug;
    data['icon'] = this._icon;
    data['icon2'] = this._icon2;
    data['parent_id'] = this._parentId;
    data['position'] = this._position;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }


}
