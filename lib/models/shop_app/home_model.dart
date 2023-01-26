class HomeModel {
  bool? status;
  late HomeDataModel data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  late List<ProductsModel> products = [];
//to carry the banner and products data
  HomeDataModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromjson(element));
    });
  }
}

class BannerModel {
  //we didn't use category and products because they are always null
  int? id;
  String? image;
  BannerModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  String? image;
  String? name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  bool? inCart;
  late bool inFavorites;
  ProductsModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    inCart = json['in_cart'];
    inFavorites = json['in_favorites'];
  }
}
