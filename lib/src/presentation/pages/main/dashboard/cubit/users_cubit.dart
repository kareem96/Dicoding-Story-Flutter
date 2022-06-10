import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_state.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit(UserState initialState) : super(initialState);

}