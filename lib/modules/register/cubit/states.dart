// ignore_for_file: camel_case_types

import 'package:shopapp/models/login_model.dart';

abstract class Shop_Register_States {}

class Shop_Register_Initial_State extends Shop_Register_States {}

class Shop_Register_Loadin_State extends Shop_Register_States {}

class Shop_Register_Success_State extends Shop_Register_States {
  final LoginModle loginmodel;

  Shop_Register_Success_State(this.loginmodel);
}

class Shop_Register_Error_State extends Shop_Register_States {
  final String error;

  Shop_Register_Error_State(this.error);
}

class Shop_Register_Change_Password_Visibility_State
    extends Shop_Register_States {}
