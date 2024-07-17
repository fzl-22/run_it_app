import 'package:equatable/equatable.dart';
import 'package:run_it_app/core/errors/exceptions.dart';

/// Abstraction of [Exception] class
///
/// [Failure] implementation will takes [message].
abstract class Failure extends Equatable {
  const Failure({
    required this.message,
  });

  final String message;

  /// returns stringified [message].
  String get errorMessage => '$Error: $message';

  @override
  List<Object?> get props => [message];
}

/// Implementation of [Failure] to handle cache-related failures
///
/// [CacheFailure] can be instantiated from an [CacheException] using
/// [CacheFailure.fromException]
class CacheFailure extends Failure {
  const CacheFailure({
    required this.prefix,
    required super.message,
  });

  factory CacheFailure.fromException(CacheException exception) {
    return CacheFailure(
      message: exception.message,
      prefix: 'Cache Failure',
    );
  }

  final String prefix;

  @override
  String get errorMessage => '$prefix: $message';

  @override
  List<Object?> get props => [message, prefix];
}

/// Implementation of [Failure] to handle server-related failures
///
/// [HttpFailure] can be instantiated from an [HttpException] using
/// [HttpFailure.fromException]
class HttpFailure extends Failure {
  const HttpFailure({
    required super.message,
    required this.statusCode,
  });

  factory HttpFailure.fromException(HttpException exception) {
    return HttpFailure(
      message: exception.message,
      statusCode: exception.statusCode,
    );
  }

  final int statusCode;

  @override
  String get errorMessage => '$statusCode: $message';
}

/// Implementation of [Failure] to handle client-related failures
///
/// [ClientFailure] can be instantiated from an [ClientException] using
/// [ClientFailure.fromException]
class ClientFailure extends Failure {
  const ClientFailure({
    required super.message,
    this.prefix = '',
  });

  factory ClientFailure.fromException(ClientException exception) {
    return ClientFailure(
      message: exception.message,
      prefix: exception.prefix,
    );
  }

  @override
  String get errorMessage => '$prefix: $message';

  final String prefix;
}

/// Implementation of [Failure] to handle custom failures.
///
/// [GeneralFailure] can be instantiated from an [ClientException] using
/// [GeneralFailure.fromException].
class GeneralFailure extends Failure {
  const GeneralFailure({
    required super.message,
  });

  factory GeneralFailure.fromException(GeneralException exception) {
    return GeneralFailure(
      message: exception.message,
    );
  }

  @override
  String get errorMessage => message;
}
