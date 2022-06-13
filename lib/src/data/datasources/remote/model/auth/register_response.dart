import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable{
  final String? message;
  /*final String? token;*/
  final String? error;

  const RegisterResponse({this.message, this.error});

  RegisterResponse.fromJson(dynamic json):
      message = json["message"] as String?,
      error = json["error"] as String?;

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map["message"] = message;
    map["error"] = error;
    return map;
  }

  Register toEntity() => Register(message);


  @override
  List<Object?> get props => [
    message,
    error,
  ];
}