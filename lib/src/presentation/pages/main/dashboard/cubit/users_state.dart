part of 'users_cubit.dart';

enum  UserStatus{loading, success, failure, empty}

extension UserStatusX on UserStatus{
  bool get isLoading => this == UserStatus.loading;
  bool get isSuccess => this == UserStatus.success;
  bool get isFailure => this == UserStatus.failure;
  bool get isEmpty => this == UserStatus.empty;
}

class UserState extends Equatable{
  final UserStatus status;
  final String? users;
  final String? message;

  const UserState({this.status = UserStatus.loading, this.users, this.message});
  
  UserState copyWith({
  UserStatus? status,
  String? user,
  String? message,
}){
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }
  
  @override
  List<Object?> get props => throw UnimplementedError();
  
}