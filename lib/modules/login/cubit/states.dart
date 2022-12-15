// ignore_for_file: camel_case_types

import '../../../models/login_model.dart';

abstract class Shop_Login_States {}

class Shop_Login_Initial_State extends Shop_Login_States {}

class Shop_Login_Loadin_gState extends Shop_Login_States {}

class Shop_Login_Success_State extends Shop_Login_States {
  final LoginModle loginmodel;

  Shop_Login_Success_State(this.loginmodel);
}

class Shop_Login_Error_State extends Shop_Login_States {
  final String error;

  Shop_Login_Error_State(this.error);
}

class Shop_Change_Password_Visibility_State extends Shop_Login_States {}

class ShopLoadingUserDataState extends Shop_Login_States {}

class ShopSuccessUserDataState extends Shop_Login_States {
  // final LoginModle loginModle;
  // ShopSuccessUserDataState(this.loginModle);
}

class ShopErrorUserDataState extends Shop_Login_States {}
