// ignore_for_file: non_constant_identifier_names

import 'package:shopapp/models/ChangeFavorites_model.dart';
import 'package:shopapp/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel modelF;
  ShopSuccessChangeFavoritesState(this.modelF);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final LoginModle UserUpdate;
  ShopSuccessUpdateUserState(this.UserUpdate);
}

class ShopErrorUpdateUserState extends ShopStates {}
