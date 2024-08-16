import 'package:getx_revision/constants/exception.dart';

sealed class Result<R,E extends Exception>  {
const Result();
}

class Success<R,E extends Exception> extends Result<R,E >{
  final R value;
  const Success(this.value);
}

class Failure<R,E extends Exception> extends Result<R,E >{
  final AppException exception;
  const Failure(this.exception);
}