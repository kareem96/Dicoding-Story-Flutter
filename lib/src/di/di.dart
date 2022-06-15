import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data.dart';
import '../domain/domain.dart';
import '../presentation/pages/pages.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  if (isUnitTest) {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance().then((value) {
      initPrefManager(value);
    });
    sl.registerSingleton<DioClient>(DioClient(isUnitTest: true));
    dataSource();
    repositories();
    usecase();
    cubit();
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    dataSource();
    repositories();
    usecase();
    cubit();
  }
}

void cubit() {
  sl.registerFactory(() => RegisterCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => StoriesCubit(sl()));
  sl.registerFactory(() => UploadCubit(sl()));
  sl.registerFactory(() => NavDrawerCubit());
}

void usecase() {
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));
  sl.registerLazySingleton(() => PostStories(sl()));
  sl.registerLazySingleton(() => GetStories(sl()));
}

void repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

void dataSource() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(sl()));
}

void initPrefManager(SharedPreferences _initPrefManager) {
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}
