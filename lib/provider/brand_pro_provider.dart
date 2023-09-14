import 'package:flutter/material.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/brand_model.dart';
import '../../../../data/repository/brand_repo.dart';
import '../../../../helper/api_checker.dart';
import '../data/model/SearchListModels/BrandSearchListModel.dart';
import '../data/model/SearchListModels/brand_pro_search_model.dart';
import '../data/model/response/brand_pro_model.dart';
import '../data/repository/brand_pro_repo.dart';

class BrandProProvider extends ChangeNotifier {
  final BrandProRepo brandProRepo;

  BrandProProvider({@required this.brandProRepo});

  List<BrandProModel> _brandProList = [];

  List<BrandProModel> get brandProList => _brandProList;


  List<BrandProSearch> get searchbrandProList {
    List<BrandProSearch> newlist=[];
    _brandProList.forEach((element) {
      newlist.add(BrandProSearch(element));
    });
    return newlist;
  }

  List<BrandProModel> _originalBrandList = [];

  Future<void> getBrandList(int id,bool reload, BuildContext context) async {
    if (_brandProList.length == 0 || reload) {
      ApiResponse apiResponse = await brandProRepo.getBrandList(id);
      // print("${apiResponse.response} rrretuyt");
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _originalBrandList.clear();
        apiResponse.response.data.forEach((brand) => _originalBrandList.add(BrandProModel.fromJson(brand)));
        _brandProList.clear();
        apiResponse.response.data.forEach((brand) => _brandProList.add(BrandProModel.fromJson(brand)));
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  bool isTopBrand = true;
  bool isAZ = false;
  bool isZA = false;

  void sortBrandLis(int value) {
    if (value == 0) {
      _brandProList.clear();
      _brandProList.addAll(_originalBrandList);
      isTopBrand = true;
      isAZ = false;
      isZA = false;
    } else if (value == 1) {
      _brandProList.clear();
      _brandProList.addAll(_originalBrandList);
      _brandProList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      isTopBrand = false;
      isAZ = true;
      isZA = false;
    } else if (value == 2) {
      _brandProList.clear();
      _brandProList.addAll(_originalBrandList);
      _brandProList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      Iterable iterable = _brandProList.reversed;
      _brandProList = iterable.toList();
      isTopBrand = false;
      isAZ = false;
      isZA = true;
    }

    notifyListeners();
  }
}
