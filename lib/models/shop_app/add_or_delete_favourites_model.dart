class AddORDeleteFavourites {
  bool? status;
  String? message;

  AddORDeleteFavourites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
