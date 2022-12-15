// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/ChangeFavorites_model.dart';
import 'package:shopapp/models/Favorites_Model.dart';

import 'package:shopapp/models/categories_moadel.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
//import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/cateogries/cateogries_Screen.dart';
import 'package:shopapp/modules/favorites/favorites_Screen.dart';
import 'package:shopapp/modules/prodeuts/prodeuts_Screen.dart';
import 'package:shopapp/modules/setttings/setttingsS_creen.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../models/Favorites_Model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  // الشاشات
  List<Widget> bottomScreens = [
    const ProdeutsScreen(),
    const CateogriesScreen(),
    const FavoritesScreen(),
    SetttingsScreen(),
  ];
  //عناصر الشاشة
  List<BottomNavigationBarItem> bottomitems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  //جلب بيانات المنتجات المفضله لدى المستخدم
  Map<int, bool> favorites = {};

  // جلب البيانات المنتجات
  HomeModel? homemodel; //تعريف موديل الهوم
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHeplper.getaDta(
      url: Home,
      token: token,
    ).then((value) {
      homemodel = HomeModel.formJson(value.data);
      // print(homemodel!.data!.banners[0].image);
      //printFullText(homemodel!.data!.banners[0].image.toString());
      //print(homemodel!.status);
      //جلب بيانات المنتجتات المفضله
      homemodel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      emit(ShopErrorHomeDataState());
      print(onError.toString());
    });
  }

  // جلب الاقسام الخاصه بالمنتجات
  CategoriesModel? categoriesModels;
  void getCategories() {
    DioHeplper.getaDta(
      url: GetCategories,
      token: token,
    ).then((value) {
      //حلب البيانات  بعد تحقق الاتصال
      categoriesModels = CategoriesModel.fromeJson(value.data);
      //
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
      print(error.toString());
    });
  }

  //اعجاب بالمنتجات
  ChangeFavoritesModel? changeFavoritesModel;

  //Map<int, bool> favorites = {};
  void changeFavrites(int productID) {
    //التغير اللحظي
    //اذا كان منتج مفضل اعكس
    //اذا كان منتج غير مفضل اعكس
    favorites[productID] = !favorites[productID]!;

    emit(ShopChangeFavoritesState());

    DioHeplper.postData(
      url: FAVORITES,
      data: {'product_id': productID},
      token: token,
    ).then((value) {
      // جلب حاله قيمه المنتج
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // اذا كانت حاله القيمه هي خطى او حصل اي خطاء عند جلب البيانات
      //لابد من ان يعد الزر الى حالته الطبيعيه
      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !favorites[productID]!;
      } else {
        //تحديث البيانات عند الشاشه

        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

//جلب المنتجات المفضله
  FavoritesModel? favoritesModel;

  void getFavorites() {
    //تحديث البيانات عند الشاشه

    emit(ShopLoadingGetFavoritesState());
    DioHeplper.getaDta(
      url: FAVORITES,
      token: token,
    ).then((value) {
      //حلب البيانات  بعد تحقق الاتصال
      favoritesModel = FavoritesModel.fromJson(value.data);
      //
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print(error.toString());
    });
  }

  // //جلب بيانات المستخدم
  LoginModle? UpdateUsermodel;

  void PostUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHeplper.putData(
      url: UPDATE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      //حلب البيانات  بعد تحقق الاتصال
      UpdateUsermodel = LoginModle.fromeJson(value.data);
      //
      //  print(usermodel!.data!.name);
      emit(ShopSuccessUpdateUserState(UpdateUsermodel!));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });
  }
}
