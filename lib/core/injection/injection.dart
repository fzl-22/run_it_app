import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:run_it_app/core/injection/injection.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: false,
  usesNullSafety: true,
)
Future<void> initDependencies() async => sl.init();
