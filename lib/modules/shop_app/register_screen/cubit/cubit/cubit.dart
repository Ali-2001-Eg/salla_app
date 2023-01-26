import 'package:ali/models/shop_app/login_user_model.dart';
import 'package:ali/shared/network/end_points.dart';
import 'package:ali/shared/network/remote/dio_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/network/local/cache_helper.dart';
import '../states/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  //required
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  //to have object of the cubit
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  //object from the constructor to give access to it
  ShopLoginModel? loginModel;
  var auth = CacheHelper.getData(key: 'token');
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelpers.postData(
            url: REGISTER,
            data: {
              'name': name,
              'email': email,
              'password': password,
              'phone': phone,
            },
            token: auth)
        .then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.data.token);
      print(loginModel!.message);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }

  bool isPasswordShown = true;
  IconData suffix = Icons.remove_red_eye_outlined;
  void changeSuffixAndObscureText() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_rounded;
    emit(ShopRegisterChangingSuffixState());
  }
}
