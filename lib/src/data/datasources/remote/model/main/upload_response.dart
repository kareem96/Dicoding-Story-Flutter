import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:equatable/equatable.dart';

class UploadResponse extends Equatable{
  final String? message;
  final bool? error;

  const UploadResponse(this.message, this.error);

  UploadResponse.fromJson(dynamic json):
      message = json["message"] as String?,
      error = json["error"] as bool?;

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map["message"] = message;
    map["error"] = error;
    return map;
  }

  Upload toEntity() => Upload(message, error);

  @override
  List<Object?> get props => [
    message,
    error,
  ];

}
