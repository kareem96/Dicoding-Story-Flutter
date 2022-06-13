import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';

class PostRegister extends UseCase<Register, RegisterParams>{
  final AuthRepository _repo;

  PostRegister(this._repo);

  @override
  Future<Either<Failure, Register>> call(params) => _repo.register(params);

}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    this.name = "",
    this.email = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
  };
}