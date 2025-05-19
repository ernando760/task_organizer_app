import 'package:result_dart/result_dart.dart';

import '../error/base_exception.dart';

abstract class BaseUsecase<
  S extends Object,
  F extends BaseException,
  P extends Object?
> {
  AsyncResultDart<S, F> execute(P params);
}
