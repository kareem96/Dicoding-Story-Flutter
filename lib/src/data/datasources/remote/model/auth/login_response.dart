import 'dart:convert';
import 'package:dicoding_story_flutter/src/domain/entities/auth/login.dart';
import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  /*final String? error;*/
  final String? message;
  final LoginResult? loginResult;

  const LoginResponse({
    /*this.error,*/
    this.message,
    this.loginResult
  });

  /*LoginResponse.fromJson(dynamic json)
      : error = json["error"] as String?,
        message = json["success"] as String?,
        loginResult = json["loginResult"] as LoginResult?;*/

  /*Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["error"] = error;
    map["success"] = message;
    map["loginResult"] = loginResult;
    return map;
  }*/

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      /*error: json["error"],*/
      message: json["message"],
      loginResult: json.containsKey("loginResult")
          ? LoginResult.fromJson(json["loginResult"])
          : null);

  Map<String, dynamic> toJson() => {
        /*"error": error,*/
        "message": message,
        "loginResult": loginResult,
      };

  Login toEntity() => Login(
      /*error,*/
      message,
      loginResult
  );

  @override
  List<Object?> get props => [
    /*error,*/
    message,
    loginResult
  ];
}
