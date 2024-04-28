import 'package:anonymous_chat/core/services/secure_storage_service.dart';
import 'package:anonymous_chat/data/repositories/api_auth_repository.dart';
import 'package:anonymous_chat/data/repositories/api_user_repository.dart';
import 'package:anonymous_chat/domain/repositories.dart/auth_repository.dart';
import 'package:anonymous_chat/domain/repositories.dart/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

/// Sets up all app dependencies.
void setupDependencies() {
  getIt.registerLazySingleton<Client>(
    () => Client(),
  );
  getIt.registerLazySingleton<SecureSotrageService>(
    () => SecureSotrageService(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => ApiAuthRepository(
      client: getIt.get(),
      secureStorage: getIt.get(),
    ),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => ApiUserRepository(
      client: getIt.get(),
      secureStorage: getIt.get(),
    ),
  );
}
