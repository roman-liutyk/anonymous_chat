import 'package:anonymous_chat/app/app.dart';
import 'package:anonymous_chat/core/di/locator.dart';
import 'package:anonymous_chat/domain/repositories.dart/auth_repository.dart';
import 'package:anonymous_chat/presentation/blocs/app_bloc_observer.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();
  setUpBlocObserver();

  /// Checks authorization before loading app
  await getIt.get<AuthRepository>().isUserAuthorized();

  runApp(const App());
}
