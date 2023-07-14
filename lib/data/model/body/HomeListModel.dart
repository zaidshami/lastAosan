import '../response/product_model.dart';

class HomeListModel {
  String title ;

  HomeListModel(this.title);
  List<Product> ProductList = [];
  int latestPageSize;
  int lOffset = 1;
  bool filterIsLoading = false;
  bool filterFirstLoading = true;
  bool isLoading = false;


}