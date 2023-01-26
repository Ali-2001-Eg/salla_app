import 'package:ali/models/shop_app/login_user_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  late ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginChangingSuffixState extends ShopLoginState {}

class ShopLoginErrorState extends ShopLoginState {}
