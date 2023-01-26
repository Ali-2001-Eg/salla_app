import 'package:dio/dio.dart';

class DioHelpers {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.getpostman.com/collections/94db931dc503afd508a5',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

//det method returns future response
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    //when I need to override some options in the API
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? query,
  }) async {
    //when I need to override some options in the API
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
