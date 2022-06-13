import 'package:dicoding_story_flutter/src/domain/entities/auth/stories.dart';
import 'package:equatable/equatable.dart';

class Stories extends Equatable {
  final List<Story> story;
  final String? message;

  const Stories(this.story, this.message);

  @override
  List<Object?> get props => [Story, message];
}

class Story extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? photoUrl;
  final String? createdAt;

  const Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        photoUrl,
        createdAt,
      ];
}
