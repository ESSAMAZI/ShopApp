// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class Shop_Login_Cubit extends Cubit<Shop_Login_States> {
  Shop_Login_Cubit() : super(Shop_Login_Initial_State());

  static Shop_Login_Cubit get(context) => BlocProvider.of(context);
  //تسجيل الدخول ناخد الرابط هو عباره عن البوست
  // ثم نستعلم عن البيانات الادخال تكون الاعمده في
  // body :row
  //1
  LoginModle? loginModle;

  //
  void userLogin({required String email, required String password}) {
    emit(Shop_Login_Loadin_gState());
    DioHeplper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      // print(value.data);
      loginModle = LoginModle.fromeJson(value.data);
      //loginModle.data.email;
      // print(loginModle!.data);
      // print(loginModle!.status);
      // print(loginModle!.data!.email);

      emit(Shop_Login_Success_State(loginModle!));
      //emit(Shop_Login_Success_State());
    }).catchError((onError) {
      emit(Shop_Login_Error_State(onError.toString()));
      print(onError.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;
  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(Shop_Change_Password_Visibility_State());
  }

  //جلب بيانات المستخدم
  LoginModle? usermodel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHeplper.getaDta(
      url: PROFILE,
      token: token,
    ).then((value) {
      //حلب البيانات  بعد تحقق الاتصال
      usermodel = LoginModle.fromeJson(value.data);
      //
      //  print(usermodel!.data!.name);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      emit(ShopErrorUserDataState());
      print(error.toString());
    });
  }
}
