part of 'stories_cubit.dart';

enum StoriesStatus {
  loading,
  success,
  failure,
  empty,
}

extension StoriesStatusX on StoriesStatus {
  bool get isLoading => this == StoriesStatus.loading;

  bool get isSuccess => this == StoriesStatus.success;

  bool get isFailure => this == StoriesStatus.failure;

  bool get isEmpty => this == StoriesStatus.empty;
}

class StoriesState extends Equatable {
  final StoriesStatus status;
  final Stories? stories;
  final String? message;

  const StoriesState({
    this.status = StoriesStatus.loading,
    this.stories,
    this.message
  });

  StoriesState copyWith({
    StoriesStatus? status,
    Stories? stories,
    String? message,
  }) {
    return StoriesState(
      status: status ?? this.status,
      stories: stories ?? this.stories,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stories,
        message,
      ];
}
