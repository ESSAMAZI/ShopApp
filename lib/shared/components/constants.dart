// ignore_for_file: avoid_print

import '../../modules/login/shop_login_Screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? token;
//
void singOut(context) {
  //print('token$token');
  CacheHelper.clearData(key: 'token').then((value) {
    if (value) {
      // print()
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

//ترجع النص طويل بدون مايقتص
void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
