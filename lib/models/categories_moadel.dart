class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromeJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromeJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data = [];
  CategoriesDataModel.fromeJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromeJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromeJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
