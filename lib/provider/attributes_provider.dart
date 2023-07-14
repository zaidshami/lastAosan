import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/filter_category_1.dart';
import '../data/repository/attribute_repo.dart';

class AttributeProvider extends ChangeNotifier {
  final AttributeRepo attributeRepo;
  List<Attribute> attributes = [];
  bool loading = false;
  String errorMessage = '';
  int _selectedParentIndex = 0;

  AttributeProvider({@required this.attributeRepo});

  int get selectedParentIndex => _selectedParentIndex;

  Future<void> fetchCategoryFilterList() async {
    loading = true;
    notifyListeners();

    ApiResponse response = await attributeRepo.getCategoryFilterList();

    if (response.response != null) {
      List<dynamic> list = response.response.data;
      attributes = list.map((item) => Attribute.fromJson(item)).toList();
    } else {
      // handle the error message as per your application design
      errorMessage = 'Failed to fetch attributes: ${response.error.toString()}';
      print(errorMessage);
    }

    loading = false;
    // Don't call notifyListeners() here
  }

  void selectParent(int index) {
    _selectedParentIndex = index;
    notifyListeners();
  }
}
