import 'package:ali/models/shop_app/login_user_model.dart';
import 'package:ali/shared/network/end_points.dart';
import 'package:ali/shared/network/remote/dio_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../states/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  //required
  ShopLoginCubit() : super(ShopLoginInitialState());
  //to have object of the cubit
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  //object from the constructor to give access to it
  late ShopLoginModel loginModel;
  var auth = CacheHelper.getData(key: 'token');
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelpers.postData(
            url: LOGIN,
            data: {
              'email': email,
              'password': password,
            },
            token: auth)
        .then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.data.token);
      print(loginModel.message);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }

  bool isPasswordShown = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changeSuffixAndObscureText() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    emit(ShopLoginChangingSuffixState());
  }
}
