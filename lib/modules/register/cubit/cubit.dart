// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';

import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';

import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class Shop_Register_Cubit extends Cubit<Shop_Register_States> {
  Shop_Register_Cubit() : super(Shop_Register_Initial_State());

  static Shop_Register_Cubit get(context) => BlocProvider.of(context);
  //تسجيل الدخول ناخد الرابط هو عباره عن البوست
  // ثم نستعلم عن البيانات الادخال تكون الاعمده في
  // body :row
  //1
  LoginModle? registerModel;

  //
  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(Shop_Register_Loadin_State());
    DioHeplper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
      token: token,
    ).then((value) {
      // print(value.data);
      registerModel = LoginModle.fromeJson(value.data);
      //loginModle.data.email;
      // print(loginModle!.data);
      // print(loginModle!.status);
      // print(loginModle!.data!.email);

      emit(Shop_Register_Success_State(registerModel!));
    }).catchError((onError) {
      // emit(Shop_Login_Error_State(onError.toString()));
      print(onError.toString());
    });
  }

  IconData suffixR = Icons.visibility_outlined;
  bool isPasswordShow = true;
  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffixR = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(Shop_Register_Change_Password_Visibility_State());
  }
}
