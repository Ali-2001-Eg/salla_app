import 'package:ali/layout/shop_app/shop_cubit/states.dart';
import 'package:ali/models/shop_app/add_or_delete_favourites_model.dart';
import 'package:ali/models/shop_app/favorites_model.dart';
import 'package:ali/models/shop_app/home_model.dart';
import 'package:ali/models/shop_app/search_model.dart';
import 'package:ali/modules/shop_app/categories/categories_screen.dart';
import 'package:ali/modules/shop_app/favorites/favorites_screen.dart';
import 'package:ali/modules/shop_app/products/products_screen.dart';
import 'package:ali/modules/shop_app/settings/settings_screen.dart';
import 'package:ali/shared/network/end_points.dart';
import 'package:ali/shared/network/remote/dio_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/login_user_model.dart';
import '../../../shared/components/components.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    ShopCategorySreen(),
    ShopFavoritesScreen(),
    ShopSettingsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  //to send the data and get it easily
  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelpers.getData(
      url: HOME,
      token: auth,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      // printFullText(homeModel!.data!.banners[0].image);
      //to add favourite items in a map
      homeModel!.data.products.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelpers.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }

  late AddORDeleteFavourites changefavouritesModel;

//post method
  void changeFavourites(int productId) {
    //to get the second state after calling this method
    favourites[productId] = !(favourites[productId])!;
    emit(ShopChangeFavState());
    DioHelpers.postData(
      url: FAVOUTITES,
      data: {
        'product_id': productId,
      },
      token: auth,
    ).then((value) {
      changefavouritesModel = AddORDeleteFavourites.fromJson(value.data);
      changefavouritesModel = AddORDeleteFavourites.fromJson(value.data);
      // print(value.data);
      // print(productId);
      if (!(changefavouritesModel.status)!) {
        favourites[productId] = !(favourites[productId])!;
      } else {
        //to build the favourites method after changing its state
        getFavouritesData();
      }
      emit(ShopSuccessChangeFavState(changefavouritesModel));
    }).catchError((error) {
      favourites[productId] = !(favourites[productId])!;
      print(error.toString());
      emit(ShopErrorChangeFavState());
    });
  }

  FavouritesModel? favouritesModel;

  void getFavouritesData() {
    emit(ShopLoadingGetFavouritesState());
    DioHelpers.getData(
      url: FAVOUTITES,
      token: auth,
    ).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelpers.getData(
      url: PROFILE,
      token: auth,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel!.data.name);
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  SearchModel? searchModel;
  void getSearchData(String search) {
    emit(ShopLoadingSearchState());
    DioHelpers.postData(
      url: SEARCH,
      token: auth,
      data: {'text': search},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState(searchModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSearchState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelpers.putData(
      url: UPDATE,
      token: auth,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel!.data.name);
      emit(ShopSuccessUpdateUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
