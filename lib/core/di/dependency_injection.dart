import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/log_in_repo.dart';
import '../../features/auth/data/repos/sign_up_repo.dart';
import '../../features/auth/presentation/providers/log_in_provider.dart';
import '../../features/auth/presentation/providers/sign_up_provider.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginProvider>(() => LoginProvider(getIt()));

  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupProvider>(() => SignupProvider(getIt()));
}
