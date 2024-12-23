import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../models/transfer.dart';



class SignletonDio{
  static var cookieManager = CookieManager(CookieJar());
  static String username= "";
  static Cookie? cookie;
  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookieManager);
    dio.options.connectTimeout = Duration(seconds: 3);
    dio.options.receiveTimeout = Duration(seconds: 3);
    return dio;
  }
}



Future<SignupResponse> signup(SignupRequest req) async {

  try {
    var response = await SignletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signup',
      data: req.toJson()
    );
    SignletonDio.username = req.username;
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
    SignletonDio.username = req.username;
    print(response);
    return SignupResponse.fromJson(response.data);
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<String> signout() async {

  try {
    var response = await SignletonDio.getDio().post(
        'http://10.0.2.2:8080/api/id/signout',
    );
    print(response);
    return response.data.toString();
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<List<HomeItemResponse>> home() async {

  try {
    var response = await SignletonDio.getDio().get('http://10.0.2.2:8080/api/home/photo');
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

Future<TaskDetailResponse> detail(int id) async {

  try {
    var response = await SignletonDio.getDio().get('http://10.0.2.2:8080/api/detail/photo/' + id.toString());

    return TaskDetailResponse.fromJson(response.data);
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<String> updateProgress(int id, int valeur) async {

  int value = valeur.toInt();

  try {
    var response = await SignletonDio.getDio().get('http://10.0.2.2:8080/api/progress/' + id.toString() + '/' + value.toString());

    return response.data.toString();
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<String> up(FormData file ) async {


  try {

    var response = await SignletonDio.getDio().post('http://10.0.2.2:8080/file', data: file);
    List<Cookie> cookies = await SignletonDio.cookieManager.cookieJar.loadForRequest(Uri.parse("http://10.0.2.2:8080/file/"+ response.data.toString()));
    SignletonDio.cookie = cookies.first;
    return response.data.toString();
  }catch(e){
    print(e);
    throw(e);
  }

}

Future<String> delete(int taskId) async {

  try {
    var response = await SignletonDio.getDio().get('http://10.0.2.2:8080/api/delete/' + taskId.toString());
    print(response);
    return response.data.toString();
  }catch(e){
    print(e);
    throw(e);
  }

}
