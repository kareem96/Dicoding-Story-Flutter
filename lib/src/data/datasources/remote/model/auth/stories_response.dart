import 'package:dicoding_story_flutter/src/domain/entities/auth/stories.dart';
import 'package:equatable/equatable.dart';

class StoriesResponse extends Equatable {
  final String? message;
  final List<DataStories>? data;

  const StoriesResponse({this.message, this.data});

  factory StoriesResponse.fromJson(dynamic json) {
    final message = json["message"] as String?;
    final dataTemp = json["listStory"] as List<dynamic>?;
    final data = dataTemp != null
        ? dataTemp.map((v) => DataStories.fromJson(v)).toList()
        : <DataStories>[];

    return StoriesResponse(
      message: message,
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map["listStory"] = data?.map((e) => e.toJson()).toList();
    }
    return map;
  }

  Stories toEntity() {
    final _listStory = data!
        .map<Story>(
          (model) => Story(
            id: "${model.id}",
            name: model.name ?? "",
            description: model.description ?? "",
            photoUrl: model.photoUrl ?? "",
            createdAt: model.createdAt ?? "",
          ),
        )
        .toList();
    return Stories(_listStory, message);
  }

  @override
  List<Object?> get props => [];
}

class DataStories extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final String? createdAt;

  const DataStories(
      {this.id, this.name, this.description, this.photoUrl, this.createdAt});

  DataStories.fromJson(dynamic json)
      : id = json["id"] as String?,
        name = json["name"] as String?,
        description = json["description"] as String?,
        photoUrl = json["photoUrl"] as String?,
        createdAt = json["createdAt"] as String?;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["description"] = description;
    map["photoUrl"] = photoUrl;
    map["createdAt"] = createdAt;

    return map;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        photoUrl,
        createdAt,
      ];
}
