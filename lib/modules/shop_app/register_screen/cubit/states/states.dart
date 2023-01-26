import 'package:ali/models/shop_app/login_user_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  late ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterChangingSuffixState extends ShopRegisterState {}

class ShopRegisterErrorState extends ShopRegisterState {}
