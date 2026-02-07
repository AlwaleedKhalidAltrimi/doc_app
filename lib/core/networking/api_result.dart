import 'api_error_model.dart';

/// Base Result
abstract class ApiResult<T> {
  const ApiResult();

  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ApiErrorModel apiErrorModel) = Failure<T>;
}

/// Success State
class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

/// Failure State
class Failure<T> extends ApiResult<T> {
  final ApiErrorModel apiErrorModel;
  const Failure(this.apiErrorModel);
}
