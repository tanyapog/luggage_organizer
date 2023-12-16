import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
FutureOr<void> configureInjection(String env) => getIt.init(environment: env);
