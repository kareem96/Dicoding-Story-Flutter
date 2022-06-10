import 'package:equatable/equatable.dart';

class Login extends Equatable {
  /*final String? error;*/
  final String? message;
  final LoginResult? loginResult;

  const Login(
      /*this.error,*/
      this.message,
      this.loginResult);

  @override
  List<Object?> get props => [
    /*error,*/
    message,
    loginResult
  ];
}

class LoginResult extends Equatable {
  final String? userId;
  final String? name;
  final String? token;

  const LoginResult({this.userId, this.name, this.token});

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
      userId: json["userId"],
      name: json["name"],
      token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "userId" : userId,
    "name" : name,
    "token" : token
  };


  @override
  List<Object?> get props => [userId, name, token];
}
