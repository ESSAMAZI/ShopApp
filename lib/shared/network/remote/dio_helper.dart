import 'package:dio/dio.dart';

class DioHeplper {
  static late Dio dio;
  //الاتصال بالبيانات الرابط
  static init() {
    dio = Dio(
      BaseOptions(
        //ماخذ من INITAL VALUE
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   //ثابت لا يتغير
        //   'Content-Type': 'application/json',
        //   //'Content-Type': 'text/plain',
        //   // 'Content-Length': '<calculated when request is sent>',
        //   // 'Host': '<calculated when request is sent>',
        // },
      ),
    );
  }

  //داله جلب البيانات
  static Future<Response> getaDta({
    required String url, //الرابط
    Map<String, dynamic>? query,
    String lang = 'ar', //البيانات
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.get(url, queryParameters: query);
  }

  //داله ارسال
  static Future<Response> postData({
    required String url, //الرابط
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar', //البيانات
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Content-Length':
      //     'multipart/form-data; boundary=<calculated when request is sent>',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  //التعديل

  static Future<Response> putData({
    required String url, //الرابط
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar', //البيانات
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Content-Length':
      //     'multipart/form-data; boundary=<calculated when request is sent>',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
