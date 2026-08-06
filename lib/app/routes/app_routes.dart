part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const calculator = _Paths.calculator;
  static const history = _Paths.history;
}

abstract class _Paths {
  _Paths._();
  static const calculator = '/calculator';
  static const history = '/history';
}
