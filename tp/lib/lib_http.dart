import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp/transfer.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';



class SignletonDio{
  static var cookieManager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookieManager);
    return dio;
  }
}



Future<SignupResponse> signup(SignupRequest req) async {

  try {
    var response = await SignletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signup',
      data: req.toJson()
    );
    print(response);
    return SignupResponse.fromJson(response.data);
  }catch(e){
    print(e);
    throw(e);
  }

}
Future<SignupResponse> signin(SignupRequest req) async {

  try {
    var response = await SignletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signin',
        data: req.toJson()
    );
    print(response);
    return SignupResponse.fromJson(response.data);
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<List<HomeItemResponse>> home() async {

  try {
    var response = await SignletonDio.getDio().get('http://10.0.2.2:8080/api/home');
    //Instancier liste
    List<HomeItemResponse> homeItems = [];

    //Avoir objet sous forme liste JSON
    var listeJson = response.data as List;

    // Changer en HomeItemResponse
    var listeHomeItems = listeJson.map(
            (elementJSON) {
          return HomeItemResponse.fromJson(elementJSON);
        }
    ).toList();

    homeItems = listeHomeItems;
    print(response);
    return homeItems;
  }catch(e){
    print(e);
    throw(e);
  }

}


Future<String> add(AddTaskRequest req) async {

  try {
    var response = await SignletonDio.getDio().post(
        'http://10.0.2.2:8080/api/add',
        data: req.toJson()
    );
    print(response);
    return response.data.toString();
  }catch(e){
    print(e);
    throw(e);
  }

}

