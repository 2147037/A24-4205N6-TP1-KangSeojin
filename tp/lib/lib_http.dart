import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp/transfer.dart';

Future<SignupResponse> signup(SignupRequest req) async {

  try {
    var response = await Dio().post(
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
    var response = await Dio().post(
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

Future<SignupResponse> home(SignupRequest req) async {

  try {
    var response = await Dio().post(
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

