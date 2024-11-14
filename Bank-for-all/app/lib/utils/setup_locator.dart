import 'package:get_it/get_it.dart';

import '../services/auth_service.dart';
import '../services/shared_prefs.dart';
import '../services/transactions_service.dart';
import '../services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => SharedPrefs());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => UserService());
}
