import 'package:dicoding_story_flutter/src/data/data.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/domain/usecase/auth/auth.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/auth/auth.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/dashboard/cubit/cubit.dart';
import 'package:dicoding_story_flutter/src/presentation/pages/main/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async{
  if(isUnitTest){
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
  }else{
    sl.registerSingleton<DioClient>(DioClient());
    dataSource();
    repositories();
    usecase();
    cubit();
  }
}

void cubit() {
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => StoriesCubit(sl()));
  sl.registerFactory(() => NavDrawerCubit());
}

void usecase() {
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => GetStories(sl()));
}

void repositories() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

void dataSource() {
  sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(sl()));
}

void initPrefManager(SharedPreferences _initPrefManager) {
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}