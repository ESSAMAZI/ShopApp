// ignore_for_file: file_names

class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
