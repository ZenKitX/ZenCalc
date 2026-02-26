part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const CALCULATOR = _Paths.CALCULATOR;
  static const HISTORY = _Paths.HISTORY;
}

abstract class _Paths {
  _Paths._();
  static const CALCULATOR = '/calculator';
  static const HISTORY = '/history';
}
