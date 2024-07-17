import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:run_it_app/core/services/dio_http_client.dart';

@module
abstract class InjectableModules {
  @lazySingleton
  Dio get dio => DioHttpClient.instance;
}
