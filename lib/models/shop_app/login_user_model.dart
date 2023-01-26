//shared between profile and login model
class ShopLoginModel {
  bool? status;
  dynamic message;
  late ShopUserData data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    //to give access to the named constructor if json !=null
    data = ShopUserData.fromjson(json['data']);
  }
}

class ShopUserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  ShopUserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
