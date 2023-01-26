import 'package:ali/models/shop_app/add_or_delete_favourites_model.dart';
import 'package:ali/models/shop_app/login_user_model.dart';

import '../../../models/shop_app/search_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoryDataState extends ShopStates {}

class ShopErrorCategoryDataState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  final AddORDeleteFavourites favModel;

  ShopSuccessChangeFavState(this.favModel);
}

class ShopErrorChangeFavState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel? shopLoginModel;
  ShopSuccessGetUserDataState(this.shopLoginModel);
}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel? shopLoginModel;
  ShopSuccessUpdateUserDataState(this.shopLoginModel);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}

class ShopSuccessSearchState extends ShopStates {
  final SearchModel? searchModel;
  ShopSuccessSearchState(this.searchModel);
}

class ShopLoadingSearchState extends ShopStates {}

class ShopErrorSearchState extends ShopStates {}
